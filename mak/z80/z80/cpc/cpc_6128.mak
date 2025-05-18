# SPDX-License: GPL-2

# *****************************
# *** @author: Έnosis Sys	***
# *** @file: cpc_6128.mak	***
# *** @date: 13/03/2025		***
# *****************************

# ***********************
# *** Important Paths ***
# ***********************

SRC_PATH := src/z80/z80/cpc/6128
HDR_PATH := include/z80/z80/cpc/6128
BIN_PATH := build/bin/z80/z80/cpc/6128

SNA_PATH := $(BIN_PATH)/sna
CPR_PATH := $(BIN_PATH)/cpr

# *********************
# *** Special files ***
# *********************

SNA_BIN := $(SNA_PATH)/nexos.sna
CPR_BIN := $(CPR_PATH)/nexos.cpr

SRC_SNA := $(SRC_PATH)/main/sna/main.asm
SRC_CPR := $(SRC_PATH)/main/cpr/main.asm

RASM_SH := $(SIT_PATH)/rasm.sh
WAPE_SH := $(SIT_PATH)/winape.sh

WINAPE_EXEC := lib/emu/winape/WinApe.exe

# ************************
# *** Imporrtants data ***
# ************************

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
	make -j$(nproc) system ARCH=z80 TARGET=z80 PC=cpc_6128

system: $(SNA_BIN) $(CPR_BIN)

run.winape: $(WINAPE_EXEC)
	wine $<

clean:
	$(RM) $(SNA_BIN) $(CPR_BIN)

# ********************
# *** .PHONY rules ***
# ********************

.PHONY: $(AS) $(ASFLAGS)

# **********************
# *** Generate files ***
# **********************

$(SNA_BIN): $(SRC_SNA) $(SOURCE) $(HEADER)
	@mkdir -p $(dir $@)
	$(AS) $(ASFLAGS) -oi $@ $<

$(CPR_BIN): $(SRC_CPR) $(SOURCE) $(HEADER)
	@mkdir -p $(dir $@)
	$(AS) $(ASFLAGS) -oc $@ $<