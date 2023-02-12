#version 330 core
out vec4 out_color;

in vec3 vs_normal;
in vec3 vs_color;

uniform float t;
uniform vec3 uniform_color;

void
main()
{
	out_color = vec4((vs_normal + 1.0) / 2.0, 1.0);
	// out_color = vec4(
	// 	(uniform_color * 0.3) + vs_color * (((sin(t) + 1.0) / 2) + 0.3),
	// 	1.0f
	// );
}
