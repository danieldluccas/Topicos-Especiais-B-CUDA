
#include "cuda_runtime.h"
#include "device_launch_parameters.h"
#include <stdlib.h>
#include <stdio.h>

#define TAMANHO 5


__global__ void identidade2d(int *a)
{
    int i = blockIdx.x * blockDim.x + threadIdx.x;
    int j = blockIdx.y * blockDim.y + threadIdx.y;
    printf("i = %d\n", i);
    printf("j = %d\n", j);
    if (i < TAMANHO && j < TAMANHO)
    {
        if (i == j)
        {
            *(a + (i + j)) = 1;
        }
        else
        {
            *(a+(i + j)) = 0;
        }
        printf("%i\n", *(a + (i + j)));
    }
    
}

int main()
{
    int m[TAMANHO][TAMANHO];
    int *matriz;
    const int n_threads = 1;
    const int blocos = TAMANHO / n_threads;
        
    dim3 grade(1,1);

    /*for (int i = 0; i < TAMANHO; i++)
    {
        for (int j = 0; j < TAMANHO; j++)
        {
            m[i][j] = rand() % 100;
            printf("%4i ", m[i][j]);
        }
        printf("\n");
    }
    */

    //reserva espaço na memória
    cudaMalloc((void **)&matriz, TAMANHO * TAMANHO * sizeof(int));


    identidade2d <<<1,1>>> (matriz);
    cudaDeviceSynchronize();
    //cudaMemcpy(m, matriz, TAMANHO * TAMANHO * sizeof(int), cudaMemcpyDeviceToHost);
    cudaDeviceReset();
    cudaFree(matriz);
}

