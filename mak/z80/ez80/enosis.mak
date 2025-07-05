# SPDX-License: GPL-2

# *****************************
# *** @author Έnosis Tech	***
# *** @version 00.00.0F		***
# *****************************

# ***********************
# *** Important Paths ***
# ***********************

SRC_PATH := src/$(ARCH)/$(TARGET)/$(HOST)
HDR_PATH := include/$(ARCH)/$(TARGET)/$(HOST)
IHX_PATH := build/bin/$(ARCH)/$(TARGET)/$(HOST)/ihx
BIN_PATH := build/bin/$(ARCH)/$(TARGET)/$(HOST)/bin

# *********************
# *** Special files ***
# *********************

NEX_SRC := $(SRC_PATH)/main/main.asm
NEX_BIN := $(BIN_PATH)/enosis.bin
NEX_IHX := $(IHX_PATH)/enosis.ihx

# **********************
# *** Important data ***
# **********************

nproc := $(shell nproc)

# *************************
# *** Find system files ***
# *************************

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

Z88DKASMFLAGS := -m=ez80_strict -float=ieee16 -I=$(SRC_PATH) -I=$(HDR_PATH) -I=$(HDR_PATH)/kernel
Z88DKDISFLAGS := -mez80_strict -a
Z88DKTICFLAGS := 
Z88DKAPPFLAGS := +hex -w -r 16

# *************
# *** Rules ***
# *************

# *** Compiling ***

all: $(NEX_BIN) $(NEX_IHX)

# *** Running ***

run: $(NEX_BIN)
	$(Z88DKTIC) $(Z88DKTICFLAGS) $<

# *** Disassebly ***

dis: $(NEX_BIN)
	$(Z88DKDIS) $(Z88DKDISFLAGS) $<

# *** Cleaning ***

clean:
	$(RM) $(NEX_BIN) $(NEX_IHX)

# ********************
# *** .PHONY rules ***
# ********************

.PHONY: all run dis clean

# ****************************
# *** Generate system file ***
# ****************************

# Format: pure binary

$(NEX_BIN): $(NEX_SRC) $(SOURCE) $(HEADER)
	@mkdir -p $(dir $@)
	$(Z88DKASM) $(Z88DKASMFLAGS) -o$@ -b $<

# Format: Intel hex

$(NEX_IHX): $(NEX_BIN)
	@mkdir -p $(dir $@)
	$(Z88DKAPP) $(Z88DKAPPFLAGS) --binfile $< -o $@ --org 0x0200