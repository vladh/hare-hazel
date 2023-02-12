# © 2022 Vlad-Stefan Harbuz <vlad@vladh.net>
# SPDX-License-Identifier: MIT

.POSIX:
.SUFFIXES:

LIBS=-lc -lSDL2 -lEGL
VARS=LD_LIBRARY_PATH=/usr/lib:${LD_LIBRARY_PATH}

hazel:
	@ # Bug https://todo.sr.ht/~sircmpwn/hare/569
	@ # rm -rf ${HOME}/.cache/hare/hazel
	mkdir -p bin
	$(VARS) hare build $(LIBS) -o bin/hazel cmd/hazel

run: hazel
	./bin/hazel

.PHONY: hazel run
