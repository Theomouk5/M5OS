#include "string.h"

void int_to_string(int n, char* str)
{
    if(n == 0)
    {
        str[0] = '0';
        str[1] = '\0';
        return;
    }

    char* ptr = str;
    int i, j = 0;

    while (n > 0)
    {
        int unit = n % 10;
        *ptr++ = '0' + unit;
        n /= 10;
    }

    *ptr = '\0';

    if(n < 0)
    {
        i = 1;
        str[0] = '-';
    }

    for(j = ptr - str - 1; i < j; i++, j--)
    {
        char tmp = str[i];
        str[i] = str[j];
        str[j] = tmp;
    }
}

int strlen(char* str)
{
    int size = 0;

    while(str[size] != 0)
    {
        size++;
    }

    return size;
}
