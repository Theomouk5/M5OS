#include "../drivers/vga/vga.h"

void kernel_main()
{
    int number = -450;
    vgaPutInt(number);
}
