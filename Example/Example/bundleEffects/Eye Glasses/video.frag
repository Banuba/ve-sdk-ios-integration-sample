#version 300 es

precision highp float;

in vec2 var_uv;

layout( location = 0 ) out vec4 frag_color;

uniform sampler2D glfx_VIDEO;

void main()
{
	vec3 color = texture(glfx_VIDEO,var_uv).rgb;
	frag_color = vec4(color,1.0);
}
