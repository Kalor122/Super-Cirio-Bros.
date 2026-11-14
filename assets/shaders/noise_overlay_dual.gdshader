shader_type canvas_item;

uniform sampler2D noise_texture_a : filter_linear_mipmap, repeat_enable;
uniform sampler2D noise_texture_b : filter_linear_mipmap, repeat_enable;

uniform vec2 noise_scroll_speed_a = vec2(0.05, 0.03);
uniform float noise_scale_a : hint_range(0.1, 10.0) = 1.0;
uniform vec4 noise_color_a : source_color = vec4(1.0, 1.0, 1.0, 0.5);

uniform vec2 noise_scroll_speed_b = vec2(-0.02, 0.06);
uniform float noise_scale_b : hint_range(0.1, 10.0) = 2.0;
uniform vec4 noise_color_b : source_color = vec4(1.0, 1.0, 1.0, 0.3);

uniform bool use_gradient_a = false;
uniform sampler2D noise_gradient_a : source_color, filter_linear;
uniform float gradient_strength_a : hint_range(0.0, 1.0) = 0.5;

uniform bool use_gradient_b = false;
uniform sampler2D noise_gradient_b : source_color, filter_linear;
uniform float gradient_strength_b : hint_range(0.0, 1.0) = 0.3;

// 0 = Average, 1 = Multiply, 2 = Add, 3 = Max
uniform int layer_combine_mode : hint_range(0, 3) = 0;

// 0 = Normal, 1 = Multiply, 2 = Add, 3 = Screen, 4 = Overlay
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

	// --- Layer A ---
	vec2 uv_a = UV * noise_scale_a + noise_scroll_speed_a * TIME;
	float n_a = texture(noise_texture_a, uv_a).r;
	vec3 tinted_a;
	float strength_a;
	if (use_gradient_a) {
		tinted_a = texture(noise_gradient_a, vec2(n_a, 0.5)).rgb;
		strength_a = gradient_strength_a;
	} else {
		tinted_a = noise_color_a.rgb * n_a;
		strength_a = noise_color_a.a;
	}

	// --- Layer B ---
	vec2 uv_b = UV * noise_scale_b + noise_scroll_speed_b * TIME;
	float n_b = texture(noise_texture_b, uv_b).r;
	vec3 tinted_b;
	float strength_b;
	if (use_gradient_b) {
		tinted_b = texture(noise_gradient_b, vec2(n_b, 0.5)).rgb;
		strength_b = gradient_strength_b;
	} else {
		tinted_b = noise_color_b.rgb * n_b;
		strength_b = noise_color_b.a;
	}

	vec3 combined_noise;
	if (layer_combine_mode == 1) {
		combined_noise = tinted_a * tinted_b;
	} else if (layer_combine_mode == 2) {
		combined_noise = min(tinted_a + tinted_b, vec3(1.0));
	} else if (layer_combine_mode == 3) {
		combined_noise = max(tinted_a, tinted_b);
	} else {
		combined_noise = (tinted_a + tinted_b) * 0.5;
	}

	float effect_strength = (strength_a + strength_b) * 0.5;

	vec3 blended;
	if (blend_mode == 1) {
		blended = blend_multiply(base_color.rgb, combined_noise);
	} else if (blend_mode == 2) {
		blended = blend_add(base_color.rgb, combined_noise);
	} else if (blend_mode == 3) {
		blended = blend_screen(base_color.rgb, combined_noise);
	} else if (blend_mode == 4) {
		blended = blend_overlay(base_color.rgb, combined_noise);
	} else {
		blended = mix(base_color.rgb, combined_noise, effect_strength);
	}

	vec3 final_rgb = (blend_mode == 0) ? blended : mix(base_color.rgb, blended, effect_strength);

	COLOR = vec4(final_rgb, base_color.a);
}
