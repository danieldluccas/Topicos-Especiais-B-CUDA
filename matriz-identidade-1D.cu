#include "cuda_runtime.h"
#include "device_launch_parameters.h"

#include <stdio.h>

//threads = tamanho * tamanho
#define TAMANHO 8
#define BLOCOS 1
#define THREADS 25


__global__ void identi (int* b)
{   
    int i = threadIdx.x;
    
    //printf("i: %d\n", i);
    if (i == 0)
        b[i] = 1;
    else if (i % (TAMANHO + 1) == 0)
    {
        b[i] = 1;
    }
    else
    {
        b[i] = 0;
    }
}



int main()
{
   const int basexaltura = TAMANHO * TAMANHO;
   int resultado[basexaltura];
    
    int* d_c = nullptr;


    
    //reserva espaço na memoria do device
    printf("====RESERVA A MEMORIA DA GPU PARA DADOS====\n");
    cudaMalloc((void**)&d_c, basexaltura * sizeof(int));
   
    //invoca o kernel
    identi << <BLOCOS, basexaltura >> > (d_c);
    cudaDeviceSynchronize();

    //retorna os dados do device para a CPU
    cudaMemcpy(resultado, d_c, basexaltura * sizeof(int), cudaMemcpyDeviceToHost);

    //imprime a matriz
    for (int i = 0; i < TAMANHO; i++)
    {
        for (int j = 0; j < TAMANHO; j++)
        {
            //printf("c[%d] = %d\n", i * TAMANHO + j + 1, resultado[i*TAMANHO + j]);
            printf("%d ", resultado[i * TAMANHO + j]);
        }
        printf("\n");
    }

    cudaFree(d_c);
    cudaDeviceReset();
    printf("====FIM====\n");
}