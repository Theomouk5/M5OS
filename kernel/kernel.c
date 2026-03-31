#include "../drivers/vga/vga.h"

void kernel_main()
{
    vgaPutNumber(6);
    vgaPutNumber(7);
    vgaPutChar('\n');
    vgaPutNumber(-4);
}
