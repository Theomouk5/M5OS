#include "io.h"

int screen_x = 0;
int screen_y = 0;
TermColor color = WHITE;

void setColor(TermColor c) {
    color = c;
}

void printChar(char c) {
    
    if (c == '\n') {
        screen_y++;
        screen_x = 0;
        return;
    }

    *(char *)(VIDEO_BUFFER + (screen_y * SCR_WIDTH + screen_x) * 2) = c;
    *(char *)(VIDEO_BUFFER + (screen_y * SCR_WIDTH + screen_x) * 2 + 1) = color;

    screen_x++;

    if (screen_x == SCR_WIDTH) {
        screen_y++;
        screen_x = 0;
    }
}

void printString(char *s) {
    while (*s != '\0')
        printChar(*s++);
}
