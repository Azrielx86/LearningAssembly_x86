#include <stdio.h>
#include <stdlib.h>
#include <time.h>

void generate_random(int *array, int size)
{
	srand(time(NULL));
	for (int i = 0; i < size; i++)
		array[i] = rand() % 100;
}

void print_array(int *array, int size)
{
	for (int i = 0; i < size; i++)
		printf("%d ", array[i]);
}
