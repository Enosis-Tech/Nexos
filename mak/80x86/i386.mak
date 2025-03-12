# SPDX-License: GPL-2

# *****************************
# *** @file: x86_32.mak		***
# *** @author: Pexnídi inc	***
# *** @date: 11/03/2025		***
# *****************************

# ***********************
# *** Important Paths ***
# ***********************

SRC_PATH := src/80x86/i386
OBJ_PATH := build/objects/80x86/i386
ISO_PATH := build/iso/80x86/i386
LDS_PATH := linker/80x86
BIN_PATH := build/bin/80x86

NEX_PATH_UEFI := build/iso/80x86/i386/kernel/uefi
NEX_PATH_BIOS := build/iso/80x86/i386/kernel/bios
GRB_PATH_BOOT := build/iso/80x86/i386/boot/grub

# *********************
# *** Special files ***
# *********************

LDS_FILE := $(LDS_PATH)/i386.ld

NEX_ISO_BIN := $(BIN_PATH)/nexos_i386.iso

NEX_UEFI_BIN := $(NEX_PATH_UEFI)/nexos.uefi
NEX_BIOS_BIN := $(NEX_PATH_BIOS)/nexos.bios
GRB_CFG_FILE := $(GRB_PATH_BOOT)/grub.cfg

# ******************
# *** Find files ***
# ******************

SOURCE := $(shell find $(SRC_PATH) -type f -name '*.asm')
OBJECT := $(patsubst $(SRC_PATH)/%.asm,$(OBJ_PATH)/%.opx,$(SOURCE))

OBJECT_UEFI := $(filter-out $(OBJ_PATH)/multiboot/bios/boot.opx,$(OBJECT))
OBJECT_BIOS := $(filter-out $(OBJ_PATH)/multiboot/uefi/boot.opx,$(OBJECT))

# *************
# *** Tools ***
# *************

AS := fasm
LD := ld

QEMU := qemu-system-i386
GRUB := grub-mkrescue

# *******************
# *** Tools flags ***
# *******************

ASFLAGS := -p 10
LDFLAGS := -m elf_i386 -T$(LDS_FILE)

QEMUFLAGS := -vga std -boot d -cdrom 

# *************
# *** Rules ***
# *************

all: $(OBJECT) $(NEX_BIOS_BIN) $(NEX_UEFI_BIN) $(NEX_ISO_BIN)

run: $(NEX_ISO_BIN)
	$(QEMU) $(QEMUFLAGS) $<

clean:
	$(RM) $(OBJECT) $(NEX_BIOS_BIN) $(NEX_UEFI_BIN) $(NEX_ISO_BIN)

.PHONY: $(AS) $(LD) $(QEMU) $(GRUB) \
		$(ASFLAGS) $(LDFLAGS) $(QEMUFLAGS)

# **********************
# *** Generate files ***
# **********************

$(NEX_ISO_BIN): $(GRB_CFG_FILE) $(NEX_BIOS_BIN) $(NEX_UEFI_BIN)
	@mkdir -p $(dir $@)
	$(GRUB) -o $@ $(ISO_PATH)

$(NEX_UEFI_BIN): $(OBJECT_UEFI)
	@mkdir -p $(dir $@)
	$(LD) $(LDFLAGS) -o $@ $^

$(NEX_BIOS_BIN): $(OBJECT_BIOS)
	@mkdir -p $(dir $@)
	$(LD) $(LDFLAGS) -o $@ $^

# ***************
# *** Patrons ***
# ***************

$(OBJ_PATH)/%.opx: $(SRC_PATH)/%.asm
	@mkdir -p $(dir $@)
	$(AS) $(ASFLAGS) $< $@