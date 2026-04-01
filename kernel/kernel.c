#include "../drivers/vga/vga.h"

void kernel_main()
{
    for(int i = 0; i <= 10000; i++)
    {
        vgaPutInt(i);
        vgaPutChar('\n');
    }
}
