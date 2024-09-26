#include <stdio.h>

int a = 12;
int b = 13;
int bsum;
int main(void)
{
    printf("a: %d b: %d", a, b);
    __asm__(
        ".intel_syntax noprefix;"
        "mov    rax, a;"
        "add    rax, b;"
        "mov    bsum, rax;"
        :::"rax"
    );
}