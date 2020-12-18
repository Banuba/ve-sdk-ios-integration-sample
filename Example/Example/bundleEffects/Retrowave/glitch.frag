#version 300 es

precision highp float;

in vec2 var_uv;
in vec4 random;

layout( location = 0 ) out vec4 F;

uniform sampler2D glfx_BACKGROUND;
uniform sampler2D luttex;

float time;

float rand () {
    return fract(sin(time)*10000.0);
}

void main()
{	
	time = random.x;

	vec2 uvR = var_uv;
	vec2 uvG = var_uv;
	vec2 uvB = var_uv;

	uvR.x = var_uv.x * 1.0 - rand() * 0.02 * 0.8;
	uvB.y = var_uv.y * 1.0 + rand() * 0.02 * 0.8;

	if (uvG.y < rand() && uvG.y > rand() -0.1 && sin(time) < 0.0)
	{
		uvG.x = (uvG + 0.02 * rand()).x;
	}

	vec4 c;
	c.r = texture(glfx_BACKGROUND, uvR).r;
	c.g = texture(glfx_BACKGROUND, uvG).g;
	c.b = texture(glfx_BACKGROUND, uvB).b;
	c.w = 1.0;

	float scanline = sin (var_uv.y * 800.0 * rand())/30.0;
	c *= 1.0 - scanline;

	float vegDist = length((0.5, 0.5) - var_uv);
	c *= 1.0 - vegDist * 0.6;

	F = c;
}
