# SPDX-License: GPL-2

# *********************************
# *** @author: Έnosis Tech		***
# *** @file: micro_énosis.mak	***
# *** @date: 02/04/2024			***
# *********************************

# ***********************
# *** Important Paths ***
# ***********************

SRC_PATH := src/z80/énosis
HDR_PATH := include/z80/énosis
BIN_PATH := build/bin/z80/énosis

# *********************
# *** Special files ***
# *********************

NEX_BIN := $(BIN_PATH)/nexos.rom

NEX_SRC := $(SRC_PATH)/main/nexos.asm

RASM_SH := $(SIT_PATH)/rasm.sh

WINAPE_EXEC := lib/emu/winape/WinApe.exe

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

AS := ./lib/bin/rasm

# *******************
# *** Tools flags ***
# *******************

ASFLAGS := -I$(HDR_PATH) -I$(SRC_PATH) -s -utf8 -fq -map -twe -xr -void -mml

# *************
# *** Rules ***
# *************

all:
	make -j$(nproc) system TARGET=MICRO-ENOSIS

system: $(NEX_BIN)

run.winape: $(WINAPE_EXEC)
	wine $<

clean:
	$(RM) $(NEX_BIN)

# ********************
# *** .PHONY rules ***
# ********************

.PHONY: $(AS) $(ASFLAGS)

# *********************
# *** Generate file ***
# *********************

$(NEX_BIN): $(NEX_SRC) $(SOURCE) $(HEADER)
	@mkdir -p $(dir $@)
	$(AS) $(ASFLAGS) -or $@ $<