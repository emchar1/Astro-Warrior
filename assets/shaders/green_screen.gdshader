shader_type canvas_item;

uniform vec3 key_color : source_color = vec3(0.0, 1.0, 0.0);
uniform float threshold : hint_range(0.0, 1.0) = 0.2;
uniform float smoothing : hint_range(0.0, 0.5) = 0.05;

void fragment() {
	vec4 color = texture(TEXTURE, UV);

	float distance_to_green = distance(color.rgb, key_color);

	color.a *= smoothstep(threshold, threshold + smoothing, distance_to_green);

	COLOR = color;
}