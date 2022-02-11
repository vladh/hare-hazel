# hare-peony

This is a 3D game engine written from scratch in Hare. It's based on the
[peony game engine](https://git.sr.ht/~vladh/peony). I haven't yet decided
the scope of this implementation. It might be a full rewrite of the C++ version,
it might only feature basic components.

For more details on the capabilities of the C++ engine, check out the
original [peony game engine](https://git.sr.ht/~vladh/peony). Here's a picture
of a scene from the full C++ engine.

![peony screenshot](https://vladh.net/static/peony@1000px.jpg)

For more details on 3D graphics in Hare, check out
[hare-3d-graphics](https://sr.ht/~vladh/hare-3d-graphics/).

## Usage

* Make sure to clone with submodules (`git clone --recurse-submodules git@git.sr.ht:~vladh/hare-peony`)
* Install `libsdl2`
* Run `make run` to run the demo

## Developing

Please note that `make run` will delete some cache directories in
`~/.cache/hare/` due to [bug 569](https://todo.sr.ht/~sircmpwn/hare/569).

## License

This project is licensed under a restrictive license. You are free to use the
source code only for personal, educational, non-commercial purposes. The full
license is included.
