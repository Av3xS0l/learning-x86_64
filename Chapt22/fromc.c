#include <stdio.h>
#include <string.h>

extern int rarea(int, int);
extern int rcircum(int, int);
extern double carea(double);
extern double ccircum(double);
extern void sreverse(char *, int);
extern void adouble(double[], int);
extern double asum(double[], int);
int main()
{
    char rstring[64];
    int side1, side2, rArea, rCirc;
    double radius, cArea, cCirc;
    double array[] = {70.0, 83.2, 91.5, 72.1, 55.5};
    long int len;
    double sum;

    // calls asam
    scanf("%d", &side1);
    scanf("%d", &side2);

    rArea = rarea(side1, side2);
    rCirc = rcircum(side1, side2);

    printf("Area: %d\n", rArea);
    printf("Rect circum: %d\n\n", rCirc);

    printf("Radius of circle: ");
    scanf("%lf", &radius);

    cArea = carea(radius);
    cCirc = carea(radius);
    printf("Area: %lf\n");
    printf("Circle circum: %lf\n\n");

    // asam with string argument
    scanf("%s", rstring);
    sreverse(rstring, strlen(rstring));

    printf("Reversed: %s\n\n", rstring);
    len = sizeof(array)/sizeof(double);
    printf("Array elements:\n");
    for (int i = 0; i< len; i++)
    {
        printf("%d : %lf\n", i, array[i]);
    }
    sum = asum(array, len);
    printf("Sum: %lf\n", sum);
    adouble(array, len);

    for (int i = 0; i< len; i++)
    {
        printf("%d : %lf\n", i, array[i]);
    }

    sum = asum(array, len);
    printf("Sum: %lf\n", sum);
    return 0;
}
