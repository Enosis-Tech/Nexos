# SPDX-License: GPL-2

# ****************************
# *** @author: Έnosis Tech ***
# *** @file: Makefile     ***
# *** @date: 19/04/2025    ***
# ****************************

# Set shell

SHELL := /bin/sh

# Basic vars

TARGET ?= MICRO-ENOSIS
SET-ENV ?= none

# Set enviroment

ifeq ($(SET-ENV),binutils)

	include mak/tools/gnu/binutils.mak

else ifeq ($(SET-ENV),rasm)

	include mak/tools/free-code/rasm.mak

else ifeq ($(SET-ENV),winape)

	include mak/tools/private-code/winape.mak

endif

# Compiling for architecture

ifeq ($(TARGET),x86-64)

	include mak/80x86/amd64.mak

else ifeq ($(TARGET),x86-32)

	include mak/80x86/i386.mak

else ifeq ($(TARGET),8086)

	include mak/80x86/8086.mak

else ifeq ($(TARGET),ARM-64)

	include mak/arm/aarch64.mak

else ifeq ($(TARGET),ARM)

	include mak/arm/arm.mak

else ifeq ($(TARGET),RISC-V64)

	include mak/riscv/riscv64.mak

else ifeq ($(TARGET),RISC-V)

	include mak/riscv/riscv.mak

else ifeq ($(TARGET),CPC-6128)

	include mak/z80/cpc_6128.mak

else ifeq ($(TARGET),MICRO-ENOSIS)

	include mak/z180/enosis.mak

endif