# SPDX-License: GPL-2

# *****************************
# *** @file: winape.mak		***
# *** @author: Pexnídi inc	***
# *** @date: 20/03/2025		***
# *****************************

# *************
# *** Paths ***
# *************

LIB_PATH := lib/emu/winape
SIT_PATH := script/z80/install

# ***********
# *** URL ***
# ***********

WINAPE := http://www.winape.net/download/WinAPE20B2.zip

# *************
# *** Tools ***
# *************

WGET := wget

# *******************
# *** Tools flags ***
# *******************

WGETFLAGS := 

# Rules

all: directory clone compiling

stable: $(SIT_PATH)/winape.sh
	@chmod +x $<
	./$<

directory:
	mkdir -p $(LIB_PATH)

clone:
	$(WGET) $(WINAPE)

compiling:
	unzip WinAPE20B2.zip -d $(LIB_PATH)
	$(RM) WinAPE20B2.zip