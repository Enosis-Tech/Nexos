# SPDX-License: GPL-2

# *****************************
# *** @author Έnosis Tech	***
# *** @version 00.00.0F		***
# *****************************

# ***********************
# *** Important Paths ***
# ***********************

SRC_PATH := src/z180/énosis
HDR_PATH := include/z180/énosis
IHX_PATH := build/bin/z180/enosis/ihx
BIN_PATH := build/bin/z180/énosis/bin

# ****************************
# *** Special system files ***
# ****************************

NEX_SRC_FIRM := $(SRC_PATH)/main/main.firm.asm
NEX_SRC_BOOT := $(SRC_PATH)/main/main.boot.asm
NEX_SRC_KERN := $(SRC_PATH)/main/main.kern.asm

NEX_BIN_FIRM := $(BIN_PATH)/enosis-firm.bin
NEX_BIN_BOOT := $(BIN_PATH)/enosis-boot.bin
NEX_BIN_KERN := $(BIN_PATH)/enosis-nexos.bin

NEX_IHX_FIRM := $(IHX_PATH)/enosis-firm.ihx
NEX_IHX_BOOT := $(IHX_PATH)/enosis-boot.ihx
NEX_IHX_KERN := $(IHX_PATH)/enosis-kern.ihx

# **************************
# *** Special user files ***
# **************************

NEX_SRC_ENFS := $(SRC_PATH)/main/main.enfs.asm

NEX_BIN_ENFS := $(BIN_PATH)/enosis-enfs.bin

NEX_IHX_ENFS := $(IHX_PATH)/enosis-enfs.ihx

# **********************
# *** Important data ***
# **********************

nproc := $(shell nproc)

# *************************
# *** Find system files ***
# *************************

# Source files

SOURCE_FIRM := $(shell find $(SRC_PATH)/firmware -type f -name '*.asm')
SOURCE_BOOT := $(shell find $(SRC_PATH)/bootloader -type f -name '*.asm')
SOURCE_KERN := $(shell find $(SRC_PATH)/kernel -type f -name '*.asm')

# Header files

HEADER_FIRM := $(shell find $(HDR_PATH)/firmware -type f -name '*.inc')
HEADER_BOOT := $(shell find $(HDR_PATH)/bootloader -type f -name '*.inc')
HEADER_KERN := $(shell find $(HDR_PATH)/kernel -type f -name '*.inc')

# ***********************
# *** Find user files ***
# ***********************

# Soruce files

SOURCE_ENFS := $(shell find $(SRC_PATH)/usr/enfs -type f -name '*.asm')

# Header files

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

Z88DKASMFLAGS := -m=z180 -float=ieee16 -I=$(SRC_PATH) -I=$(HDR_PATH)
Z88DKDISFLAGS := -mz180 -a
Z88DKTICFLAGS := 
Z88DKAPPFLAGS := +hex -w -r 16

# *************
# *** Rules ***
# *************

# *** Compiling ***

all:	$(NEX_BIN_FIRM) $(NEX_BIN_BOOT) $(NEX_BIN_KERN) \
		$(NEX_IHX_FIRM) $(NEX_IHX_BOOT) $(NEX_IHX_KERN) \

# *** Running ***

run-firm: $(NEX_BIN_FIRM)
	$(Z88DKTIC) $(Z88DKTICFLAGS) $<

run-boot: $(NEX_BIN_BOOT)
	$(Z88DKTIC) $(Z88DKTICFLAGS) $<

run-kern: $(NEX_BIN_KERN)
	$(Z88DKTIC) $(Z88DKTICFLAGS) $<

# *** Disassebly ***

dis-firm: $(NEX_BIN_FIRM)
	$(Z88DKDIS) $(Z88DKDISFLAGS) $<

dis-boot: $(NEX_BIN_BOOT)
	$(Z88DKDIS) $(Z88DKDISFLAGS) $<

dis-kern: $(NEX_BIN_KERN)
	$(Z88DKDIS) $(Z88DKDISFLAGS) $<

# *** Cleaning ***

clean:
	$(RM) 	$(NEX_BIN_FIRM) $(NEX_BIN_BOOT) $(NEX_BIN_KERN) \
			$(NEX_IHX_FIRM) $(NEX_IHX_BOOT) $(NEX_IHX_KERN) \

# ********************
# *** .PHONY rules ***
# ********************

.PHONY: $(Z80_ASM) $(ASFLAGS)

# ****************************
# *** Generate system file ***
# ****************************

# Format: pure binary

$(NEX_BIN_FIRM): $(NEX_SRC_FIRM) $(SOURCE_FIRM) $(HEADER_FIRM)
	@mkdir -p $(dir $@)
	$(Z88DKASM) $(Z88DKASMFLAGS) -o$@ -b $<

$(NEX_BIN_BOOT): $(NEX_SRC_BOOT) $(SOURCE_BOOT) $(HEADER_BOOT)
	@mkdir -p $(dir $@)
	$(Z88DKASM) $(Z88DKASMFLAGS) -o$@ -b $<

$(NEX_BIN_KERN): $(NEX_SRC_KERN) $(SOURCE_KERN) $(HEADER_KERN)
	@mkdir -p $(dir $@)
	$(Z88DKASM) $(Z88DKASMFLAGS) -o$@ -b $<

# Format: Intel hex

$(NEX_IHX_FIRM): $(NEX_BIN_FIRM)
	@mkdir -p $(dir $@)
	$(Z88DKAPP) $(Z88DKAPPFLAGS) --binfile $< -o $@ --org 0x0000

$(NEX_IHX_BOOT): $(NEX_BIN_BOOT)
	@mkdir -p $(dir $@)
	$(Z88DKAPP) $(Z88DKAPPFLAGS) --binfile $< -o $@ --org 0x2000

$(NEX_IHX_KERN): $(NEX_BIN_KERN)
	@mkdir -p $(dir $@)
	$(Z88DKAPP) $(Z88DKAPPFLAGS) --binfile $< -o $@ --org 0x4000

# ***************
# *** Patrons ***
# ***************