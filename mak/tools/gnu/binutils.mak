# SPDX-License: GPL-2

# *****************************
# *** @file: binutils.mak	***
# *** @author: Pexnídi inc	***
# *** @date: 20/03/2025		***
# *****************************

# *************
# *** Paths ***
# *************

LIB_PATH := $(shell realpath lib/binutils)
SIT_PATH := script/gnu

BINUTILS_PATH := binutils-gdb

# ***********
# *** URL ***
# ***********

BINUTILS := git://sourceware.org/git/binutils-gdb.git

# *********************
# *** Architectures ***
# *********************

ARCH := x86_64-pc-linux-gnu,arm-none-eabi,riscv64-unknown-elf

# *************
# *** Tools ***
# *************

RM  := rm -rf
GIT := git
CFG := cd $(BINUTILS_PATH) && ./configure

# *******************
# *** Tools flags ***
# *******************

GITFLAGS := clone

CFGFLAGS := --prefix=$(LIB_PATH) --enable-targets=$(ARCH) --disable-nls
MAKEFLAGS := -C $(BINUTILS_PATH) -j$(nproc)


# Rules

all: directory clone compiling


directory:
	mkdir -p $(LIB_PATH)

clone:
	$(GIT) $(GITFLAGS) $(BINUTILS)

compiling:
	$(CFG) $(CFGFLAGS)
	$(MAKE) $(MAKEFLAGS)
	$(MAKE) $(MAKEFLAGS) install
	$(RM) $(BINUTILS_PATH)