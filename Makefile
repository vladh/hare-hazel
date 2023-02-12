# © 2022 Vlad-Stefan Harbuz <vlad@vladh.net>
# SPDX-License-Identifier: MIT

.POSIX:
.SUFFIXES:

LIBS=-lc -lSDL2 -lEGL
VARS=LD_LIBRARY_PATH=/usr/lib:${LD_LIBRARY_PATH}

hazel:
	$(VARS) hare build $(LIBS) cmd/hazel

run:
	@ # Bug https://todo.sr.ht/~sircmpwn/hare/569
	rm -rf \
		${HOME}/.cache/hare/common \
		${HOME}/.cache/hare/graphics \
		${HOME}/.cache/hare/engine
	$(VARS) hare run $(LIBS) cmd/hazel

.PHONY: hazel run
