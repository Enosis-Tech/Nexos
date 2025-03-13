# SPDX-License: GPL-2

# Set shell

SHELL := /bin/sh

# Basic vars

CPU ?= x86-32

# Compiling for architecture

ifeq ($(CPU),x86-64)

	include mak/80x86/amd64.mak

else ifeq ($(CPU),x86-32)

	include mak/80x86/i386.mak

else ifeq ($(CPU),x86)

	include mak/80x86/8086.mak

else ifeq ($(CPU),ARM64)

	include mak/arm/aarch64.mak

else ifeq ($(CPU),ARM)

	include mak/arm/arm.mak

else ifeq ($(CPU),RISCV64)

	include mak/riscv/riscv64.mak

else ifeq ($(CPU),RISCV)

	include mak/riscv/riscv.mak

else ifeq ($(CPU),Z80)

	include mak/z80/cpc.mak

endif