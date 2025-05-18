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

# Rules

all:
	mkdir -p $(LIB_PATH)
	git clone $(RASM)
	make -C rasm -j$(shell nproc)
	mv rasm/rasm.exe $(LIB_PATH)/rasm
	rm -rf rasm

stable: $(SIT_PATH)/rasm.sh
	@chmod +x $<
	./$<