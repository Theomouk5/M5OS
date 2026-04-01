#include "../drivers/vga/vga.h"

void kernel_main()
{
    int number = -26509;
    vgaPutInt(number);
    vgaPutChar('\n');
}
