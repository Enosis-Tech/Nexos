# SPDX-License: GPL-2

# ****************************
# *** @author: Έnosis Tech ***
# *** @file: Makefile     ***
# *** @date: 19/04/2025    ***
# ****************************

# *****************
# *** Set shell ***
# *****************

SHELL := /bin/sh

# **********************
# *** Set enviroment ***
# **********************

ifeq ($(TOOL), binutils)

	include mak/tools/gnu/binutils.mak

else ifeq ($(TOOL), rasm)

	include mak/tools/free-code/rasm.mak

else ifeq ($(TOOL), winape)

	include mak/tools/private-code/winape.mak

endif

# *****************
# *** Compiling ***
# *****************

ifdef HOST

include mak/$(ARCH)/$(TARGET)/$(HOST).mak

else

include mak/$(ARCH)/$(TARGET).mak

endif