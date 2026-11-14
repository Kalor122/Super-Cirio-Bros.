shader_type canvas_item;
// Procedural fire for Godot 4.x. Dark areas are fully transparent.
// Put it on a ColorRect or Sprite2D (any size, no texture needed).

uniform float speed : hint_range(0.0, 3.0) = 0.9;
uniform float noise_scale : hint_range(0.5, 10.0) = 3.5;
uniform float distortion : hint_range(0.0, 1.0) = 0.35;
uniform float flame_height : hint_range(0.2, 1.0) = 0.9;
uniform float fuel : hint_range(0.0, 2.0) = 1.0;
uniform float edge_fade : hint_range(0.0, 0.5) = 0.08;
uniform float brightness : hint_range(0.5, 3.0) = 1.3;

uniform vec4 color_dark : source_color = vec4(0.30, 0.02, 0.0, 1.0);
uniform vec4 color_red : source_color = vec4(0.85, 0.10, 0.0, 1.0);
uniform vec4 color_orange : source_color = vec4(1.0, 0.50, 0.05, 1.0);
uniform vec4 color_core : source_color = vec4(1.0, 0.95, 0.45, 1.0);

float hash(vec2 p) {
	p = fract(p * vec2(123.34, 456.21));
	p += dot(p, p + 45.32);
	return fract(p.x * p.y);
}

float noise(vec2 p) {
	vec2 i = floor(p);
	vec2 f = fract(p);
	f = f * f * (3.0 - 2.0 * f);
	float a = hash(i);
	float b = hash(i + vec2(1.0, 0.0));
	float c = hash(i + vec2(0.0, 1.0));
	float d = hash(i + vec2(1.0, 1.0));
	return mix(mix(a, b, f.x), mix(c, d, f.x), f.y);
}

float fbm(vec2 p) {
	float v = 0.0;
	float a = 0.5;
	for (int i = 0; i < 5; i++) {
		v += a * noise(p);
		p = p * 2.02 + vec2(7.3, 3.1);
		a *= 0.5;
	}
	return v;
}

void fragment() {
	vec2 uv = UV;
	float t = TIME * speed;

	// 1.0 at the bottom of the rect, 0.0 where the flames end
	float grad = clamp((uv.y - (1.0 - flame_height)) / flame_height, 0.0, 1.0);

	// Noise coordinates that scroll upward
	vec2 p = vec2(uv.x * noise_scale, uv.y * noise_scale * 0.9 + t);

	// Warp the coordinates so the flames wiggle and curl
	float warp = fbm(p * 0.8 + vec2(0.0, t * 0.6));
	p.x += (warp - 0.5) * distortion * 4.0;

	float n = fbm(p);

	// Strong at the bottom, breaks apart into tongues toward the top
	float f = n * (0.45 + grad * 1.2) + grad * fuel * 0.55 - 0.45;
	f = clamp(f, 0.0, 1.0);

	// Soft fade on the left and right edges
	float edge = smoothstep(0.0, edge_fade + 0.0001, uv.x) * smoothstep(1.0, 1.0 - edge_fade - 0.0001, uv.x);
	f *= edge;

	// Colour ramp: dark red -> red -> orange -> yellow core
	vec3 col = mix(color_dark.rgb, color_red.rgb, smoothstep(0.0, 0.30, f));
	col = mix(col, color_orange.rgb, smoothstep(0.25, 0.60, f));
	col = mix(col, color_core.rgb, smoothstep(0.55, 0.95, f));

	COLOR = vec4(col * brightness, smoothstep(0.02, 0.30, f));
}