#version 300 es

layout( location = 0 ) in vec3 attrib_pos;

layout(std140) uniform glfx_GLOBAL
{
	mat4 glfx_MVP;
	mat4 glfx_PROJ;
	mat4 glfx_MV;
	vec4 unused_spinner;
	vec4 randomVec;
};
layout(std140) uniform glfx_INSTANCES
{
	vec4 glfx_IDATA[8];
};
uniform uint glfx_CURRENT_I;
#define glfx_T_SPAWN (glfx_IDATA[glfx_CURRENT_I].x)
#define glfx_T_ANIM (glfx_IDATA[glfx_CURRENT_I].y)
#define glfx_ANIMKEY (glfx_IDATA[glfx_CURRENT_I].z)

out vec2 var_uv;
out vec4 random;
out vec2 var_bgmask_uv;

void main()
{	
	random = randomVec;
	float aspect = glfx_PROJ[1][1]/glfx_PROJ[0][0];
	float s = sign(glfx_PROJ[0][0]);

	vec2 v = attrib_pos.xy;
	vec2 uv = v*0.5 + 0.5;

	gl_Position = vec4( v, -1., 1. );
	var_uv = uv;
	var_bgmask_uv = vec2(-sign(glfx_PROJ[0][0]),-sign(glfx_PROJ[1][1]))*v.yx*0.5 + 0.5;
}