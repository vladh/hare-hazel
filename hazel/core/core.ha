// © 2022 Vlad-Stefan Harbuz <vlad@vladh.net>
// SPDX-License-Identifier: MIT

use fmt;
use fs;
use math;
use math::random;
use strings;

use glm::{ v3, m2 };
use sdl2;

use hazel::graphics;
use hazel::engine;
use hazel::common;

export fn run() (void | fs::error | sdl2::error) = {
	common::state.dt = 1000.0 / 60.0;
	common::state.rng = random::init(0);

	graphics::init();
	defer graphics::destroy();

	engine::init();

	for (!common::state.should_quit) {
		engine::update()?;
		graphics::draw();
		sdl2::SDL_Delay(common::state.dt: i32: u32);
	};
};
