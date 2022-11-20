#include <stdio.h>
#include <sys/types.h>
#include <unistd.h>
#include <string.h>
#define MAX 20
int a[1000];
void quick_sort(int low, int high)
{
    int i, j, pivot, temp;
    if (low < high){
        pivot = low;
        i = low;
        j = high;
        while (i < j){
            while (a[i] <= a[pivot] && i < high){
                i++;
            }
            while (a[j] > a[pivot]){
                j--;
            }
            if (i < j){
                temp = a[i];
                a[i] = a[j];
                a[j] = temp;
            }
        }
        temp = a[pivot];
        a[pivot] = a[j];
        a[j] = temp;
        quick_sort(low, j - 1);
        quick_sort(j + 1, high);
    }
}
int main()
{
    int i, n, ele, pid;
    char *str1[MAX];
    char str[5];
    printf("Enter size of Elements: ");
    scanf("%d", &n);
    printf("Enter %d Elements: ", n);
    for (i = 0; i < n; i++){
        scanf("%d", &a[i]);
    }
    pid = fork();
    if (pid < 0){
        printf("Error while creating new process...!!!!");
    }
    else if (pid > 0){
        quick_sort(0, n);
        for (i = 0; i < MAX; i++){
            str1[i] = NULL;
        }
        for (i = 1; i <= n; i++){
            sprintf(str, "%d", a[i]);
            str1[i - 1] = strdup(str);
        }
        execve("./reverse", str1, NULL);
        printf("EXECVE not called..!!");
    }
}


/* #include <stdio.h>
#include <sys/types.h>
#include <unistd.h>
#include <stdlib.h>
int main(int argc, char *argv[])
{
    int i, ele, a[argc];
    printf("Sorted array: ");
    for (i = 0; i < argc; i++)
    {
        a[i] = atoi(argv[i]);
        printf("%d ", a[i]);
    }
    printf("\nElements in reverse order:");
    for (i = argc - 1; i >= 0; i--)
    {
        printf("%d ", a[i]);
    }
    printf("\n");
}
*/