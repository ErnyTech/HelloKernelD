#include <multiboot.h>

MULTIBOOT_HEADER_NAME:       
        // Declare multiboot magic
        .long   MULTIBOOT_HEADER_MAGIC

         // Setup multiboot architecture
        .long   MULTIBOOT_ARCHITECTURE
        
        // Declare header length
        .long   MULTIBOOT_LENGHT
        
        // Generate multiboot checksum
        .long   MULTIBOOT_CHECKSUM
        
        // End of multiboot header
        .word   0
        .word   0
        .long   8
MULTIBOOT_HEADER_END_NAME:
