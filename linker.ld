ENTRY(main)

SECTIONS {
        . = 1M;
        
        .boot :
        {
            *(.multiboot_header)
        }

        .text : 
        {
            *(.text)
        }
}
 
