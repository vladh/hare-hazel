use types;

export fn cstr(s: str) nullable *const i8 = {
	return ((&s): *types::string).data: nullable *const i8;
};
