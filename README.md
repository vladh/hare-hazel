<!--
© 2022 Vlad-Stefan Harbuz <vlad@vladh.net>
SPDX-License-Identifier: MIT
-->

# hare-hazel

This is a very simple 3D game engine written from scratch in Hare. It's loosely
based on the [peony game engine](https://git.sr.ht/~vladh/peony), but implements
a much more minimalistic render pipeline.

Here's a picture of a scene from the full C++ engine. After I've done some more
work on hare-hazel I'll add a screenshot that's more representative.

![peony screenshot](https://vladh.net/static/peony@1000px.jpg)

For more details on 3D graphics in Hare, check out
[hare-3d-graphics](https://sr.ht/~vladh/hare-3d-graphics/).

## Usage

* Make sure to clone with submodules (`git clone --recurse-submodules git@git.sr.ht:~vladh/hare-hazel`)
* Install `libsdl2`
* Run `make run` to run the demo

## Developing

Please note that `make run` will delete some cache directories in
`~/.cache/hare/` due to [bug 569](https://todo.sr.ht/~sircmpwn/hare/569).

## Contributing

Send patches to `~vladh/general@lists.sr.ht` using subject prefix `[PATCH hare-hazel]`. For example:

```
git config sendemail.to '~vladh/general@lists.sr.ht'
git config format.subjectPrefix 'PATCH hare-hazel'
git send-email HEAD^
```

For more information, see [git-send-email.io](https://git-send-email.io/).
