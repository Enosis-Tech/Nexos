# SPDX-License: GPL-2

# *********************************
# *** @author: Έnosis Tech		***
# *** @file: micro_énosis.mak	***
# *** @date: 02/04/2024			***
# *********************************

# ***********************
# *** Important Paths ***
# ***********************

SRC_PATH := src/z180/énosis
HDR_PATH := include/z180/énosis
BIN_PATH := build/bin/z180/énosis

# *********************
# *** Special files ***
# *********************

NEX_FIRM := $(BIN_PATH)/enosis-firm.bin
NEX_BOOT := $(BIN_PATH)/enosis-boot.bin
NEX_KERN := $(BIN_PATH)/enosis-nexos.bin
NEX_USER := $(BIN_PATH)/enosis-user.bin

NEX_BIN := $(BIN_PATH)/nexos.bin

NEX_SRC := $(SRC_PATH)/main/main.asm

# **********************
# *** Important data ***
# **********************

nproc := $(shell nproc)

# ******************
# *** Find files ***
# ******************

SOURCE := $(shell find $(SRC_PATH) -type f -name '*.asm')
HEADER := $(shell find $(HDR_PATH) -type f -name '*.inc')

# *************
# *** Tools ***
# *************

Z88DKASM := z88dk.z88dk-z80asm
Z88DKDIS := z88dk.z88dk-dis
Z88DKTIC := z88dk.z88dk-ticks
Z88DKAPP := z88dk.z88dk-appmake

# *******************
# *** Tools flags ***
# *******************

Z88DKASMFLAGS := -m=z180 -r0000 -float=ieee16 -I=$(SRC_PATH) -I=$(HDR_PATH)
Z88DKDISFLAGS := -mz180
Z88DKTICFLAGS := 
Z88DKAPPFLAGS := +hex

# *************
# *** Rules ***
# *************

all:
	make -j$(nproc) system TARGET=MICRO-ENOSIS

system: $(NEX_BIN)

run:
	$(Z88DKTIC) $(Z88DKTICFLAGS) $(NEX_BIN)

dis-asm:
	$(Z88DKDIS) $(Z88DKDISFLAGS) $(NEX_BIN)

clean:
	$(RM) $(OBJECT) $(NEX_FIRM) $(NEX_BOOT) $(NEX_KERN) $(NEX_USER) $(NEX_BIN)

# ********************
# *** .PHONY rules ***
# ********************

.PHONY: $(Z80_ASM) $(ASFLAGS)

# *********************
# *** Generate file ***
# *********************

$(NEX_BIN):	$(NEX_SRC) $(SOURCE) $(HEADER)
	@mkdir -p $(dir $@)
	$(Z88DKASM) $(Z88DKASMFLAGS) -o$@ -b $<

# ***************
# *** Patrons ***
# ***************