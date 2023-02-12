// (c) 2022 Vlad-Stefan Harbuz <vlad@vladh.net>
// SPDX-License-Identifier: MIT

use fmt;
use math;
use math::random;

use glm;
use glm::{ v3, v4, m4 };
use sdl2;

use hazel::common;

def STAR_SPEED: f32 = 0.6;
def STAR_Z_MAX: f32 = 10.0;
def STAR_Z_MIN: f32 = -4000.0;
def STAR_XY_EXTENT: f32 = 3000.0;

export type engine_state = struct {
	positions: [common::N_OBJECTS]v3,
	rotations: [common::N_OBJECTS]f32,
	scales: [common::N_OBJECTS]f32,
	colors: [common::N_OBJECTS]v3,
};

export let state: engine_state = engine_state { ... };

export fn update() (void | sdl2::error) = {
	process_events()?;

	common::state.t += common::state.dt;

	for (let i = 0z; i < common::N_OBJECTS; i += 1) {
		state.positions[i][2] += STAR_SPEED * common::state.dt;
		if (state.positions[i][2] > STAR_Z_MAX) {
			randomize_object_xy(i);
			state.positions[i][2] = STAR_Z_MIN;
		};
	};
};

fn process_events() (void | sdl2::error) = {
	let ev = sdl2::event { ... };
	for (sdl2::SDL_PollEvent(&ev)? == 1) {
		switch (ev.event_type) {
		case sdl2::SDL_EventType::QUIT =>
			common::state.should_quit = true;
			return;
			case sdl2::SDL_EventType::KEYDOWN =>
			if (ev.key.keysym.sym == sdl2::SDL_Keycode::ESCAPE) {
				common::state.should_quit = true;
				return;
			};
		case => void;
		};
	};
};

fn randomize_object_xy(idx: size) void = {
	state.positions[idx][0] =
		(random::next(&common::state.rng) % STAR_XY_EXTENT: i32: u32): i64: f32 -
		(STAR_XY_EXTENT / 2.0);
	state.positions[idx][1] =
		(random::next(&common::state.rng) % STAR_XY_EXTENT: i32: u32): i64: f32 -
		(STAR_XY_EXTENT / 2.0);
};

fn randomize_object_z(idx: size) void = {
	const extent = (math::absf64(STAR_Z_MIN) +
		math::absf64(STAR_Z_MAX)): i64: u64;
	state.positions[idx][2] =
		(random::next(&common::state.rng) % extent): i64: f32 + STAR_Z_MIN;
};

export fn init() void = {
	init_objects();
};

fn init_objects() void = {
	state.positions = [glm::v3_new(0.0, 0.0, 0.0)...];
	state.rotations = [0.0...];
	state.scales = [0.1...];
	state.colors = [glm::v3_new(1.0, 1.0, 1.0)...];

	for (let i = 0z; i < common::N_OBJECTS; i += 1) {
		randomize_object_xy(i);
		randomize_object_z(i);
	};
};
