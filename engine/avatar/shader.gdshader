shader_type spatial;
render_mode depth_draw_always, cull_disabled, alpha_to_coverage_and_one;

instance uniform float tone:hint_range(0, 1) = 1;
instance uniform float gender:hint_range(0, 1) = 1;
instance uniform bool private = false;

uniform sampler2D albedo_male_dark : source_color;
uniform sampler2D albedo_male_light : source_color;
uniform sampler2D albedo_female_dark : source_color;
uniform sampler2D albedo_female_light : source_color;
uniform sampler2D normal_male : hint_normal;
uniform sampler2D normal_female : hint_normal;
uniform sampler2D gloss_male;
uniform sampler2D gloss_female;
uniform sampler2D specular_male;
uniform sampler2D specular_female;
uniform sampler2D mask_pant;
uniform sampler2D mask_bra;

	
void fragment() {	
	vec4 amd = texture(albedo_male_dark, UV);
	vec4 aml = texture(albedo_male_light, UV);
	vec4 afd = texture(albedo_female_dark, UV);
	vec4 afl = texture(albedo_female_light, UV);
	vec4 nm = texture(normal_male, UV);
	vec4 nf = texture(normal_female, UV);
	vec4 gm = texture(gloss_male, UV);
	vec4 gf = texture(gloss_female, UV);
	vec4 sm = texture(specular_male, UV);
	vec4 sf = texture(specular_female, UV);
	vec4 mp = texture(mask_pant, UV);
	vec4 mb = texture(mask_bra, UV);
	
	vec4 am = mix(amd, aml, tone);
	vec4 af = mix(afd, afl, tone);
	vec4 color = mix(am, af, gender);
	
	if (!private){
		color = mix(color, mp, mp.w);
		if (gender > 0.4){
			color = mix(color, mb, mb.w);
		}
	}
	
	vec3 normal = mix(vec3(nm.xyz), vec3(nf.xyz), gender);
	float gloss = mix(gm.x, gf.x, gender);
	float specular = mix(sm.x, sf.x, gender);	
	
	ALBEDO = vec3(color.xyz);
	ALPHA = color.w;
	NORMAL_MAP = normal;
	ROUGHNESS = 1.0 - gloss;
	SPECULAR = specular;
}
