# --- Outils ------------------------------------
ARCH := i686
CC   := $(ARCH)-elf-gcc
AS   := nasm

# --- Flags -------------------------------------
CFLAGS  := -std=c99 \
		  -ffreestanding \
		  -nostdlib \
		  -Wall \
		  -Wextra \
		  -Iinclude

LDFLAGS := -ffreestanding \
		   -nostdlib \
		   -T linker.ld

# --- Dossiers ----------------------------------
BUILD := build
OBJ   := $(BUILD)/obj
ISO   := $(BUILD)/iso

# --- Sources -----------------------------------
C_SOURCES   := $(shell find kernel -name "*.c")
ASM_SOURCES := $(shell find boot -name "*.s")

# --- Objets ------------------------------------
C_OBJECTS   := $(patsubst %.c, $(OBJ)/%.o, $(C_SOURCES))
ASM_OBJECTS := $(patsubst %.s, $(OBJ)/%.o, $(ASM_SOURCES))
ALL_OBJECTS := $(C_OBJECTS) $(ASM_OBJECTS)

# --- Cibles ------------------------------------
.PHONY: all run clean

all: $(BUILD)/myos.iso

$(BUILD)/myos.iso: $(ISO)/boot/myos.elf grub.cfg
	@mkdir -p $(ISO)/boot/grub
	cp grub.cfg $(ISO)/boot/grub/grub.cfg
	grub-mkrescue -o $@ $(ISO)

# Linkage
$(ISO)/boot/myos.elf: $(ALL_OBJECTS)
	@mkdir -p $(dir $@)
	$(CC) $(LDFLAGS) $(ALL_OBJECTS) -o $@

# Compilation
$(OBJ)/%.o: %.c
	@mkdir -p $(dir $@)
	$(CC) $(CFLAGS) -c $< -o $@

$(OBJ)/%.o: %.s
	@mkdir -p $(dir $@)
	$(AS) -f elf32 $< -o $@

run: all
	qemu-system-i386 -cdrom $(BUILD)/myos.iso

clean:
	rm -rf $(BUILD)
