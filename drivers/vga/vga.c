#include "vga.h"

#include <stdint.h>

Writer vgaWriter = {
    .col = 0,
    .row = 0,
    .color = 0x0F,
    .buffer = (uint16_t*)VGA_BUFFER
};

void vgaSetColor(uint8_t color)
{
    vgaWriter.color = color;
}

void vgaSetPosistion(uint8_t row, uint8_t col)
{
    vgaWriter.row = row;
    vgaWriter.col = col;
}

void vgaScrollDown()
{
    for(int row = 1; row < VGA_HEIGHT; row++)
    {
        for(int col = 0; col < VGA_WIDTH; col++)
        {
            vgaWriter.buffer[(row-1) * VGA_WIDTH + col] = vgaWriter.buffer[row * VGA_WIDTH + col];
        }
    }

    for(int i = 0; i < VGA_WIDTH; i++)
    {
        vgaWriter.buffer[24*VGA_WIDTH + i] = 0;
    }

    vgaWriter.row = 24;
    vgaWriter.col = 0;
}

void vgaPutChar(char chr)
{
    if(vgaWriter.col >= VGA_WIDTH)
    {
        vgaWriter.col = 0;
        vgaWriter.row++;
    }

    switch(chr)
    {
        case '\n':
            vgaWriter.col = 0;
            vgaWriter.row++;
            break;

        default:
            vgaWriter.buffer[vgaWriter.row * VGA_WIDTH + vgaWriter.col] = vgaWriter.color << 8 | chr;
            vgaWriter.col++;
            break;
    }

    if(vgaWriter.row >= VGA_HEIGHT)
    {
        vgaScrollDown();
    }
}

void vgaPutString(char* str)
{
    int i = 0;
    while(str[i] != 0)
    {
        vgaPutChar(str[i++]);
    }
}

void vgaPutNumber(int8_t n)
{
    if(n > 9 || n < -9)
    {
        return;
    }
 
    if(n < 0)
    {
        vgaPutChar('-');
        n *= -1;
    }

    vgaPutChar(48 + (uint8_t)n);
}

void vgaPutInt(int n)
{
    
}
