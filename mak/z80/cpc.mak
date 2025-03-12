# SPDX-License: GPL-2

# *****************************
# *** @file: z80.mak		***
# *** @author: Penídi inc	***
# *** @date: 12/03/2025		***
# *****************************

# ***********************
# *** Important Paths ***
# ***********************

SRC_PATH := src/z80/cpc
HDR_PATH := include/z80/cpc
SCP_PATH := script/install/z80
BIN_PATH := build/bin/z80

SNA_PATH := $(BIN_PATH)/sna
CPR_PATH := $(BIN_PATH)/cpr

# *********************
# *** Special files ***
# *********************

SNA_BIN := $(SNA_PATH)/nexos.sna
CPR_BIN := $(CPR_PATH)/nexos.cpr

SRC_SNA := $(SRC_PATH)/main/sna/main.asm
SRC_CPR := $(SRC_PATH)/main/cpr/main.asm

RASM_SH := $(SCP_PATH)/rasm.sh
WAPE_SH := $(SCP_PATH)/winape.sh

WINAPE_EXEC := lib/emu/winape/WinApe.exe

# ******************
# *** Find files ***
# ******************

SOURCE := $(shell find $(SRC_PATH) -type f -name '*.asm')
HEADER := $(shell find $(HDR_PATH) -type f -name '*.asm')

# *************
# *** Tools ***
# *************

AS := lib/bin/rasm

# *******************
# *** Tools flags ***
# *******************

ASFLAGS := -I$(HDR_PATH) -I$(SRC_PATH) -s -utf8 -fq -map -twe -xr -void -mml

# *************
# *** Rules ***
# *************

all: $(SNA_BIN) $(CPR_BIN)

install.all: $(RASM_SH) $(WAPE_SH)
	./$(RASM_SH)
	./$(WAPE_SH)

install.rasm: $(RASM_SH)
	@chmod +x $<
	./$<

install.winape: $(WAPE_SH)
	@chmod +x $<
	./$<

run.winape: $(WINAPE_EXEC)
	wine $<

clean:
	$(RM) $(SNA_BIN) $(CPR_BIN)

$(SNA_BIN): $(SRC_SNA) $(SOURCE) $(HEADER)
	$(AS) $(ASFLAGS) -oi $@ $<

$(CPR_BIN): $(SRC_CPR) $(SOURCE) $(HEADER)
	$(AS) $(ASFLAGS) -oc $@ $<