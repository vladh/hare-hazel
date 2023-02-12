// © 2022 Vlad-Stefan Harbuz <vlad@vladh.net>
// SPDX-License-Identifier: MIT

use fmt;
use fs;

use sdl2;

use hazel::core;

export fn main() void = {
	match (hazel::core::run()) {
	case let err: sdl2::error =>
		fmt::fatal("SDL2 error: {}", sdl2::strerror(err));
	case let err: fs::error =>
		fmt::fatal("Error: {}", fs::strerror(err));
	case void => void;
	};
};
