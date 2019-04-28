kernel = hellokernel
arch ?= x86_64
CC = gcc
DMD = dmd
ASM_FLAGS = -c -m32 -Iinclude
DLANG_FLAGS = -c -m32 -defaultlib= -noboundscheck -release -betterC
LFLAGS = -Wall -m32 -Werror -nostdlib
kernel_image := build/$(kernel)-$(arch)
iso := build/$(kernel)-$(arch).iso
linker_script := linker.ld
grub := arch/$(arch)/grub/grub.cfg
asm_source := $(wildcard arch/*.S) $(wildcard arch/$(arch)/*.S)
asm_obj := $(patsubst %.S, build/%.o, $(asm_source))
dlang_source := $(wildcard arch/*.d) $(wildcard arch/$(arch)/*.d)
dlang_obj := $(patsubst %.d, build/%.o, $(dlang_source))

.PHONY: all clean run iso

all: $(kernel_image)

clean:
	@rm -r build
	
run: $(iso)
	@qemu-system-$(arch) -cdrom $(iso)
	@make clean

iso: $(iso)

$(iso): $(kernel_image) $(grub)
	@mkdir -p build/iso/boot/grub
	@cp $(kernel_image) build/iso/boot/$(kernel)-$(arch)
	@cp $(grub) build/iso/boot/grub
	@grub-mkrescue -o $(iso) build/iso 2> /dev/null
	@rm -r build/iso

$(kernel_image): $(asm_obj) $(dlang_obj) $(linker_script)
	$(CC) $(LFLAGS) -T $(linker_script) -o $(kernel_image) $(asm_obj) $(dlang_obj) 

$(asm_obj): $(asm_source)
	@mkdir -p $(shell dirname $@)
	$(CC) $(ASM_FLAGS) $< -o $@	
	
$(dlang_obj): $(dlang_source)
	@mkdir -p $(shell dirname $@)
	$(DMD) $(DLANG_FLAGS) $< -od=build/arch/$(arch)
