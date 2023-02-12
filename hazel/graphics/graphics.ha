// © 2022 Vlad-Stefan Harbuz <vlad@vladh.net>
// SPDX-License-Identifier: MIT

use fmt;
use math;

use gl;
use glm;
use glm::{ v3, v4, m4 };
use sdl2;

use hazel::common;
use hazel::engine;
use hazel::util;

export type drawable = struct {
	vbo: uint,
	vao: uint,
	ebo: uint,
	shader_program: uint,
};

export type graphics_state = struct {
	window: *sdl2::SDL_Window,
	cube: drawable,
	object_shader_prog: uint,
	projection: m4,
	view: m4,
};

export let state: graphics_state = graphics_state { ... };

export fn init() void = {
	init_window();
	gl::load();
	gl::glEnable(gl::GL_DEPTH_TEST);
	init_shaders();
	init_matrices();
	init_drawable(&state.cube, state.object_shader_prog);
	gl::glViewport(0, 0,
		common::WINDOW_WIDTH: i32, common::WINDOW_HEIGHT: i32);
	gl::glClearColor(0.0, 0.0, 0.0, 1.0);
};

export fn init_window() void = {
	sdl2::SDL_Init(sdl2::SDL_INIT_VIDEO)!;
	sdl2::SDL_GL_SetAttribute(sdl2::SDL_GLattr::GL_CONTEXT_PROFILE_MASK,
		sdl2::SDL_GLprofile::GL_CONTEXT_PROFILE_CORE);
	sdl2::SDL_GL_SetAttribute(sdl2::SDL_GLattr::GL_CONTEXT_MAJOR_VERSION, 4);
	sdl2::SDL_GL_SetAttribute(sdl2::SDL_GLattr::GL_CONTEXT_MINOR_VERSION, 3);

	const win = sdl2::SDL_CreateWindow("hazel",
		sdl2::SDL_WINDOWPOS_UNDEFINED, sdl2::SDL_WINDOWPOS_UNDEFINED,
		common::WINDOW_WIDTH, common::WINDOW_HEIGHT,
		sdl2::SDL_WindowFlags::OPENGL)!;

	let context = sdl2::SDL_GL_CreateContext(win);

	state.window = win;
};

fn init_shaders() void = {
	const vert = make_shader(VERT_SHADER, gl::GL_VERTEX_SHADER)!;
	const frag = make_shader(FRAG_SHADER, gl::GL_FRAGMENT_SHADER)!;
	const prog = make_shader_program(vert, frag)!;
	gl::glDeleteShader(vert);
	gl::glDeleteShader(frag);
	state.object_shader_prog = prog;
};

fn init_matrices() void = {
	const aspect = common::WINDOW_WIDTH: f32 / common::WINDOW_HEIGHT: f32;
	glm::perspective(&state.projection, 70.0, aspect, 0.01, 5000.0);

	state.view = glm::lookat(
		&glm::v3_new(0.0, 0.0, 15.0),
		&glm::v3_new(0.0, 0.0, 0.0),
		&glm::v3_new(0.0, 1.0, 0.0));
};

export fn destroy() void = {
	sdl2::SDL_Quit();
	sdl2::SDL_DestroyWindow(state.window);
	gl::glDeleteProgram(state.object_shader_prog);
	destroy_drawable(&state.cube);
};

export fn draw() void = {
	gl::glClear(gl::GL_COLOR_BUFFER_BIT | gl::GL_DEPTH_BUFFER_BIT);

	for (let i = 0z; i < common::N_OBJECTS; i += 1) {
		let model = glm::m4_new(1.0);
		glm::scale(&model, &glm::v3_new_fill(engine::state.scales[i]));

		// Correct bunny position
		glm::rotate(&model, glm::rad(-90.0),
			&glm::v3_new(1.0, 0.0, 0.0));

		glm::rotate(&model, engine::state.rotations[i],
			&glm::v3_new(1.0, 0.0, 0.0));
		glm::translate(&model, &engine::state.positions[i]);

		draw_drawable(&state.cube, &model, &engine::state.colors[i]);
	};

	sdl2::SDL_GL_SwapWindow(state.window);
};
