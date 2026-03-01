shader_type spatial;
render_mode world_vertex_coords;

uniform float finite_difference = 0.01;
uniform float wave_speed;
uniform vec2 wave_direction;
uniform vec2 waves_scale;
uniform float lowest_freq = 2;
uniform float freq_spacing = .2;
uniform float offset_largest = .2;
uniform float offset_h_largest = .2;


uniform sampler2D bubble_noise;
uniform float anisotrophic_fac = 2.5;

uniform vec3 height_color: source_color;
uniform float height_light_factor = .9;
uniform vec3 ambient_color: source_color;
uniform float ambient_light_factor = .5;
uniform vec3 norm_view_color: source_color;
uniform float view_norm_factor = .5;

vec3 compute_vertex_pos(vec3 vertex){
	vec3 offset = vec3(0);
	for(float i = 0.; i <= 16.; i+= 1.){
		float i_fac = i * .3;
		float wave_time = wave_speed * (1. + exp(-i_fac)) * TIME;
		vec2 position = vertex.xz * waves_scale.xy;
		position *= (lowest_freq + i_fac);
		float theta = i * .45;
		position *= mat2(
			vec2(cos(theta), sin(theta)),
			vec2(-sin(theta), cos(theta))
		);
		float offset_amount = sin(dot(position, wave_direction) + wave_time);
		offset_amount *= exp(-i_fac) * offset_largest;
		offset += vec3(0,offset_amount,0);
		
		vec2 h_offset= wave_direction * cos(dot(position, wave_direction) + wave_time);
		h_offset *= exp(-i_fac) * offset_h_largest;
		offset += vec3(h_offset.x, 0, h_offset.y);
	}
	return vertex + offset;
}

varying float foam;
varying float height;
varying vec2 world_uv;

void vertex() {
	world_uv = VERTEX.xz * .1;
	vec3 new_vertex = compute_vertex_pos(VERTEX);
	vec3 new_vertex_x_grad = compute_vertex_pos(VERTEX + vec3(finite_difference,0,0));
	vec3 new_vertex_z_grad = compute_vertex_pos(VERTEX + vec3(0,0,finite_difference));
	vec3 v1 = (new_vertex_x_grad - new_vertex);
	vec3 v2 = (new_vertex_z_grad - new_vertex);

	NORMAL = cross(v2, v1);
	height = new_vertex.y / 8. / offset_h_largest + .5;
	//replace with better foam equation later
	foam = height - .25;
	VERTEX = new_vertex;
}

const float COLOR_STEPS = 8.;
const float INV_COLOR_STEPS = .125;

void fragment() {
	vec3 base_color = clamp((
		dot(NORMAL, VIEW) * view_norm_factor +
		height_color * clamp(height * height_light_factor / offset_largest, 0.,1.) +
		ambient_color * ambient_light_factor
	), 0., 1.);
	base_color += step(1. - max(.001,foam),texture(bubble_noise,world_uv).x);
	float base_color_luminance = dot(base_color, vec3(.3,.7,.2));
	vec3 base_color_norm = base_color * (1./base_color_luminance);

	float dither_noise = texture(bubble_noise, world_uv * .5 + wave_direction * TIME * .01).x;

	ALBEDO = round(base_color_luminance * COLOR_STEPS + dither_noise) * INV_COLOR_STEPS * base_color_norm;
}

void light() {
	vec3 specular_direction = LIGHT - 2. * NORMAL * (dot(NORMAL, LIGHT));
	vec3 anisotrophy_vec = cross(specular_direction, NORMAL);
	float aniso = dot(-VIEW,anisotrophy_vec);
	aniso *= aniso;
	float spec_light = clamp(dot(-VIEW, specular_direction) -.94 - aniso * anisotrophic_fac, 0.,1.) * ATTENUATION;

	SPECULAR_LIGHT += round(spec_light * COLOR_STEPS * 3.) * INV_COLOR_STEPS/3. * LIGHT_COLOR;
}
