#include <stdio.h>

int x = 11, y = 12, sum, prod;

int sub(void);
void multi(void);
int main()
{
    printf("Numbers are %d  %d\n", x, y);
    __asm__(
        ".intel_syntax noprefix;"
        "mov    rax, x;"
        "add    rax, y;"
        "mov    sum, rax"
    );
    printf("sum is %d\n", sum);
    printf("difference is %d\n", sub());
    multi();
    printf("product is: %d\n", prod);

}

int sub()
{
    __asm__(
        ".intel_syntax noprefix;"
        "mov    rax, x;"
        "sub    rax, y"
    );
}

void multi()
{
    __asm__(
        ".intel_syntax noprefix;"
        "mov    rax, x;"
        "imul   rax, y;"
        "mov    prod, rax"
    );
}