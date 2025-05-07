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

# ***********************************
# *** Compiling from 80x80 family ***
# ***********************************

ifeq ($(ARCH), x86)

	ifeq ($(TARGET), 8086)

		include mak/80x86/8086.mak
	
	else ifeq ($(TARGET), x86-32)
	
		include mak/80x86/i386.mak
	
	else ifeq ($(TARGET), x86-64)
	
		include mak/80x86/amd64.mak
	
	endif

endif

# ***********************************
# *** Compiling from ARM family ***
# ***********************************

ifeq ($(ARCH), arm)

	ifeq ($(TARGET), aarch32)

		include mak/arm/aarch32.mak

	else ifeq ($(TARGET), aarch64)

		include mak/arm/aarch64.mak

	endif

endif

# ***********************************
# *** Compiling from ARM family ***
# ***********************************

ifeq ($(ARCH), riscv)

	ifeq ($(TARGET), riscv32)

		include mak/riscv/riscv32.mak

	else ifeq ($(TARGET), riscv64)

		include mak/riscv/riscv64.mak

	endif

endif

# ***********************************
# *** Compiling from ARM family ***
# ***********************************

ifeq ($(ARCH), z80)

	# *** Z80 cpu ***

	ifeq ($(TARGET), z80)

		# *** cpc family ***

		ifeq ($(PC), cpc_6128)
		
			include mak/z80/cpc_6128.mak
		
		endif # cpc family
	
	endif # Z80 target

	# *** Z180 cpu ***

	ifeq ($(TARGET), z180)
		
		# *** Έnosis family ***

		ifeq ($(PC), enosis)
			
			include mak/z180/enosis.mak
			
		endif # Έnosis family

	endif # Z180 target

endif # ARCH