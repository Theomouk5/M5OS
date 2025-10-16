#include "io.h"

void k_main() {
    TermColor col = 1;

    while (col < 16)
    {
        printString("TMK5 OS by Theo :) \n");
        col++;
        setColor(col);
    }
}
