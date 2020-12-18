#version 300 es

precision highp float;

in vec2 var_uv;
in vec2 var_bgmask_uv;
in vec4 random;

layout( location = 0 ) out vec4 F;

uniform sampler2D glfx_BACKGROUND;
uniform sampler2D glfx_BG_MASK;
uniform sampler2D luttex;
uniform sampler2D tex;

float time;

float filtered_bg_simple( sampler2D mask_tex, vec2 uv )
{
	float bg1 = texture( mask_tex, uv ).x;
	if( bg1 > 0.98 || bg1 < 0.02 )
		return bg1;

	vec2 o = 1./vec2(textureSize(mask_tex,0));
	float bg2 = texture( mask_tex, uv + vec2(o.x,0.) ).x;
	float bg3 = texture( mask_tex, uv - vec2(o.x,0.) ).x;
	float bg4 = texture( mask_tex, uv + vec2(0.,o.y) ).x;
	float bg5 = texture( mask_tex, uv - vec2(0.,o.y) ).x;

	return 0.2*(bg1+bg2+bg3+bg4+bg5);
}

float rand () {
    return fract(sin(time)*10000.0);
}

void main()
{	
	time = random.x;

	vec2 uv = var_uv;
	uv.y = 1.0 - uv.y;
	uv.x = uv.x * 0.1;
	uv.x += time * 0.1;
	uv.x = fract(uv.x);
	vec3 color = texture(tex, uv).xyz;

	float mask = filtered_bg_simple( glfx_BG_MASK, var_bgmask_uv );
	vec3 bg_color = texture (glfx_BACKGROUND, var_uv).xyz; 

	F = vec4(mix (bg_color, color, mask), 1.0);
}
