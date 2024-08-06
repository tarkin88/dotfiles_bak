# slstatus version
VERSION = 0

# customize below to fit your system

# paths
PREFIX = /usr/local
MANPREFIX = $(PREFIX)/share/man

# flags
CPPFLAGS = -D_DEFAULT_SOURCE
OPTIMISATIONS = -march=native -flto=auto -O3

CFLAGS   = ${OPTIMISATIONS} -std=c99 -pedantic -Wall -Wextra -Wno-unused-parameter -Os
LDFLAGS  = -s
# OpenBSD: add -lsndio
# FreeBSD: add -lkvm -lsndio
LDLIBS   = -lX11

# compiler and linker
CC = cc
