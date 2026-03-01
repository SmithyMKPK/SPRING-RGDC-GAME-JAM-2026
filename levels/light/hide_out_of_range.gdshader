// NOTE: Shader automatically converted from Godot Engine 4.6.stable's CanvasItemMaterial.
shader_type canvas_item;
render_mode blend_mix;

uniform float gamma = 1;
uniform vec2 vision_light_source;
uniform float max_distance = 100.;
varying vec4 world_position;

varying vec4 modulate;

void vertex(){
	modulate = COLOR;
	world_position = MODEL_MATRIX * vec4(VERTEX,0,1);
}

void fragment(){
	vec2 world_pos = world_position.xy;
	float distance_percent = (max_distance - length(world_pos - vision_light_source))/max_distance;
	COLOR = texture(TEXTURE, UV) * modulate *  
	vec4(
		vec3(1),
		pow(distance_percent, gamma)
	);
}