#include "../drivers/vga/vga.h"
#include "../libc/string.h"

void kernel_main()
{
    int test = 5;
    char buffer[16];
    int_to_string(test, buffer);
    vgaPutString(buffer);
}
