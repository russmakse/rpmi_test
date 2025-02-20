ENTRY(_start)

MEMORY {
  RAM (rwx) : ORIGIN = 0x80000000, LENGTH = 128
}

SECTIONS {
  .text : {
    *(.text)
  } > RAM
}