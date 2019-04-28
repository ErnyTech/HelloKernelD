#define MULTIBOOT_HEADER_NAME       multiboot_header
#define MULTIBOOT_HEADER_END_NAME   multiboot_end
#define MULTIBOOT_HEADER_MAGIC		0xE85250D6
#define MULTIBOOT_ARCHITECTURE      0 //Setup i386 protected mode
#define MULTIBOOT_LENGHT            MULTIBOOT_HEADER_END_NAME - MULTIBOOT_HEADER_NAME
#define MULTIBOOT_CHECKSUM          -(MULTIBOOT_HEADER_MAGIC + MULTIBOOT_ARCHITECTURE + (MULTIBOOT_LENGHT))

                                    
                                    
