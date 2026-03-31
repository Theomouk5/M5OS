#ifndef __VGA_H__
#define __VGA_H__

#define VGA_BUFFER 0xB8000
#define VGA_WIDTH 80
#define VGA_HEIGHT 25

#include <stdint.h>

typedef struct
{
    uint8_t col;
    uint8_t row;
    uint8_t color;
    volatile uint16_t* buffer;
} Writer;

extern Writer vgaWriter;

void vgaSetColor(uint8_t color);
void vgaSetPosition(uint8_t row, uint8_t col);
void vgaScrollDown();
void vgaPutChar(char chr);
void vgaPutString(char* str);
void vgaPutNumber(int8_t n);
void vgaPutInt(int n);

#endif
