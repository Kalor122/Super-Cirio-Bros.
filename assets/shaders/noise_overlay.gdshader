shader_type canvas_item;

uniform sampler2D noise_texture : filter_linear_mipmap, repeat_enable;

uniform vec2 noise_scroll_speed = vec2(0.05, 0.03);

uniform float noise_scale : hint_range(0.1, 10.0) = 1.0;

uniform vec4 noise_color : source_color = vec4(1.0, 1.0, 1.0, 0.5);

uniform bool use_gradient = false;
uniform sampler2D noise_gradient : source_color, filter_linear;

uniform float gradient_strength : hint_range(0.0, 1.0) = 0.5;

// 0 = Normal (alpha mix), 1 = Multiply, 2 = Add, 3 = Screen, 4 = Overlay
uniform int blend_mode : hint_range(0, 4) = 0;

vec3 blend_multiply(vec3 base, vec3 blend) {
	return base * blend;
}

vec3 blend_add(vec3 base, vec3 blend) {
	return min(base + blend, vec3(1.0));
}

vec3 blend_screen(vec3 base, vec3 blend) {
	return vec3(1.0) - (vec3(1.0) - base) * (vec3(1.0) - blend);
}

vec3 blend_overlay(vec3 base, vec3 blend) {
	// Per-channel overlay formula
	vec3 result;
	for (int i = 0; i < 3; i++) {
		if (base[i] < 0.5) {
			result[i] = 2.0 * base[i] * blend[i];
		} else {
			result[i] = 1.0 - 2.0 * (1.0 - base[i]) * (1.0 - blend[i]);
		}
	}
	return result;
}

void fragment() {
	vec4 base_color = texture(TEXTURE, UV);

	vec2 noise_uv = UV * noise_scale + noise_scroll_speed * TIME;
	float noise_value = texture(noise_texture, noise_uv).r;

	vec3 tinted_noise;
	float effect_strength;
	if (use_gradient) {
		tinted_noise = texture(noise_gradient, vec2(noise_value, 0.5)).rgb;
		effect_strength = gradient_strength;
	} else {
		tinted_noise = noise_color.rgb * noise_value;
		effect_strength = noise_color.a;
	}

	vec3 blended;
	if (blend_mode == 1) {
		blended = blend_multiply(base_color.rgb, tinted_noise);
	} else if (blend_mode == 2) {
		blended = blend_add(base_color.rgb, tinted_noise);
	} else if (blend_mode == 3) {
		blended = blend_screen(base_color.rgb, tinted_noise);
	} else if (blend_mode == 4) {
		blended = blend_overlay(base_color.rgb, tinted_noise);
	} else {
		// Normal: straight lerp toward the noise color
		blended = mix(base_color.rgb, tinted_noise, effect_strength);
	}

	vec3 final_rgb = (blend_mode == 0) ? blended : mix(base_color.rgb, blended, effect_strength);

	COLOR = vec4(final_rgb, base_color.a);
}
