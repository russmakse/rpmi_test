ENTRY(_start)

MEMORY {
  RAM (rwx) : ORIGIN = 0x80001000, LENGTH = 2M
}

SECTIONS
{
    .text : {
        *(.text .text.*)
    } > RAM

    .rodata : {
        *(.rodata .rodata.*)
    } > RAM

    .data : {
        *(.data .data.*)
    } > RAM

    .bss : {
        *(.bss .bss.*)
    } > RAM
}