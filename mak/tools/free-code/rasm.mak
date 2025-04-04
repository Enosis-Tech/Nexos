# SPDX-License: GPL-2

# *****************************
# *** @file: rasm.mak		***
# *** @author: Pexnídi inc	***
# *** @date: 20/03/2025		***
# *****************************

# *************
# *** Paths ***
# *************

LIB_PATH := lib/bin
SIT_PATH := script/z80/install

# ***********
# *** URL ***
# ***********

RASM := git@github.com:EdouardBERGE/rasm.git

# *************
# *** Tools ***
# *************

RM  := rm -rf
GIT := git

# *******************
# *** Tools flags ***
# *******************

GITFLAGS := clone
MAKEFLAGS := -C rasm -j$(nproc)

# Rules

all: directory clone compiling

stable: $(SIT_PATH)/rasm.sh
	@chmod +x $<
	./$<

directory:
	mkdir -p $(LIB_PATH)

clone:
	$(GIT) $(GITFLAGS) $(RASM)

compiling:
	$(MAKE) $(MAKEFLAGS)
	mv rasm/rasm.exe $(LIB_PATH)/rasm
	$(RM) rasm