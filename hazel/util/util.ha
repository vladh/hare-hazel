// (c) 2022 Vlad-Stefan Harbuz <vlad@vladh.net>
// SPDX-License-Identifier: MIT

use types;

// Turns s into a C string. s must end with a null byte.
export fn cstr(s: str) nullable *const i8 = {
	return ((&s): *types::string).data: nullable *const i8;
};
