# SPDX-License: GPL-2

# *****************************
# *** @file: 8086.mak		***
# *** @author: Pexnídi inc	***
# *** @date: 13/03/2025		***
# *****************************

# ***********************
# *** Important Paths ***
# ***********************

SRC_PATH := src/80x86/8086
ISO_PATH := build/iso/80x86/8086
BIN_PATH := build/bin/80x86

SRC_PATH_BOOT := $(SRC_PATH)/bootloader
SRC_PATH_LODR := $(SRC_PATH)/bootloader/nexloader
SRC_PATH_KERN := $(SRC_PATH)/kernel

NEX_PATH_BOOT := $(ISO_PATH)/boot
NEX_PATH_LODR := $(ISO_PATH)/boot/nexloader
NEX_PATH_KERN := $(ISO_PATH)/kernel

# *********************
# *** Special files ***
# *********************

NEX_RAW := $(BIN_PATH)/nexos_8086.raw
NEX_ISO := $(BIN_PATH)/nexos_8086.iso

SRC_KERN := $(SRC_PATH_KERN)/main/nexos.asm
SRC_BOOT := $(SRC_PATH_BOOT)/nexos_boot.asm
SRC_MCRO := $(SRC_PATH_LODR)/nexos_mk.asm

NEX_KERN := $(NEX_PATH_KERN)/nexos.kern
NEX_BOOT := $(NEX_PATH_BOOT)/nexos.boot
NEX_MKBT := $(NEX_PATH_LODR)/nexos.mkbt

# **********************
# *** Important data ***
# **********************

nproc := $(shell nproc)

# *************
# *** Tools ***
# *************

AS := fasm
DD := dd

ISOF := mkisofs
QEMU := qemu-system-i386
QIMG := qemu-img

# *******************
# *** Tools flags ***
# *******************

ASFLAGS := -m 64 -p 10
DDFLAGS := bs=512

QEMUFLAGS := -vga std -m 1M -name "Nexos 8086" 
QIMGFLAGS := create -f raw

ISOFFLAGS :=	-R -J \
				-V "Nexos" -volset "127" \
				-P "Pexnídi INC" -p "Pexnídi INC" \
				-A "GENISOIMAGE" -sysid "NEXOS" \
				-iso-level 1 -b boot/nexos.boot -c boot/nexos.cat -boot-load-size 127 -no-emul-boot

# *************
# *** Rules ***
# *************

all: 
	make -j$(nproc) system TARGET=8086

system: $(NEX_BOOT) $(NEX_MKBT) $(NEX_KERN) $(NEX_RAW) $(NEX_ISO)

run: $(NEX_RAW)
	$(QEMU) $(QEMUFLAGS) -drive file=$<,format=raw

run-iso: $(NEX_ISO)
	$(QEMU) $(QEMUFLAGS) -cdrom $<

isoinfo: $(NEX_ISO)
	isoinfo -i $< -l -p

boot: $(NEX_ISO)
	sudo dd status=progress if=$< of=/dev/sda

clean:
	$(RM) $(NEX_BOOT) $(NEX_MKBT) $(NEX_KERN) $(NEX_RAW) $(NEX_ISO)

.PHONY: $(AS) $(LD) $(QEMU) $(ISOF) \
		$(ASFLAGS) $(LDFLAGS) $(QEMUFLAGS) $(ISOFFLAGS) \
		all run isoinfo boot clean .PHONY

# **********************
# *** Generate files ***
# **********************

$(NEX_ISO): $(NEX_BOOT) $(NEX_MKBT) $(NEX_KERN)
	@mkdir -p $(dir $@)
	$(ISOF) $(ISOFFLAGS) -o $(NEX_ISO) $(ISO_PATH)

$(NEX_RAW): $(NEX_BOOT) $(NEX_MKBT) $(NEX_KERN)
	@mkdir -p $(dir $@)
	$(QIMG) $(QIMGFLAGS) $@ 1M
	$(DD) $(DDFLAGS) if=$(NEX_BOOT) of=$@ seek=0
	$(DD) $(DDFLAGS) if=$(NEX_MKBT) of=$@ seek=9
	$(DD) $(DDFLAGS) if=$(NEX_KERN) of=$@ seek=10
#	$(DD) $(DDFLAGS) if=$(NEX_MKBT) of=$@ seek=128

$(NEX_BOOT): $(SRC_BOOT)
	@mkdir -p $(dir $@)
	$(AS) $(ASFLAGS) $< $@

$(NEX_MKBT): $(SRC_MCRO)
	@mkdir -p $(dir $@)
	$(AS) $(ASFLAGS) $< $@

$(NEX_KERN): $(SRC_KERN)
	@mkdir -p $(dir $@)
	$(AS) $(ASFLAGS) $< $@