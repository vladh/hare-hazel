// (c) 2022 Vlad-Stefan Harbuz <vlad@vladh.net>
// SPDX-License-Identifier: MIT

use errors;
use fmt;
use strings;

use gl;
use glm;
use glm::{ v3, v4, m4 };

use hazel::util;

fn make_shader(
	source: nullable *const u8,
	kind: uint,
) (uint | errors::invalid) = {
	const shader = gl::glCreateShader(kind);
	gl::glShaderSource(shader, 1,
		&source: nullable *const nullable *const i8, null);
	gl::glCompileShader(shader);

	let success: i32 = 1;
	let log: [512]u8 = [0...];
	gl::glGetShaderiv(shader, gl::GL_COMPILE_STATUS, &success);
	if (success == 0) {
		gl::glGetShaderInfoLog(shader, 512, null: *const i32,
			&log[0]: *i8);
		const log_str = strings::fromutf8(log) as str;
		fmt::printfln("Shader compilation failed: {}", log_str)!;
		return errors::invalid;
	};

	return shader;
};

fn make_shader_program(vert: uint, frag: uint) (uint | errors::invalid) = {
	const program = gl::glCreateProgram();
	gl::glAttachShader(program, vert);
	gl::glAttachShader(program, frag);
	gl::glLinkProgram(program);

	let success: i32 = 1;
	let log: [512]u8 = [0...];
	gl::glGetShaderiv(program, gl::GL_LINK_STATUS, &success);
	if (success == 0) {
		gl::glGetShaderInfoLog(program, 512, null: *const i32,
			&log[0]: *i8);
		const log_str = strings::fromutf8(log) as str;
		fmt::printfln("Shader program linking failed: {}", log_str)!;
		return errors::invalid;
	};

	return program;
};

fn uniformmat4fv(prog: u32, name: str, val: *m4) void = {
	const loc = gl::glGetUniformLocation(prog, util::cstr(name));
	gl::glUniformMatrix4fv(loc, 1, 0, glm::m4_valptr(val));
};

fn uniform3fv(prog: u32, name: str, val: *v3) void = {
	const loc = gl::glGetUniformLocation(prog, util::cstr(name));
	gl::glUniform3fv(loc, 1, glm::v3_valptr(val));
};

fn uniform1f(prog: u32, name: str, val: f32) void = {
	const loc = gl::glGetUniformLocation(prog, util::cstr(name));
	gl::glUniform1f(loc, val);
};
