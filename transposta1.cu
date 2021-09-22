#include "cuda_runtime.h"
#include "device_launch_parameters.h"
#include "cuda.h"


#include <stdio.h>
#include <stdlib.h>

#define TAMANHO 3
#define BLOCOS 3
#define THREADS 1


__global__ void addVetor(int* c, int* a, int* b)
{
    int i = threadIdx.x;
    c[i] = a[i] + b[i];


    /*   printf("teste addkernel %i\n", blockIdx.x * blockDim.x + threadIdx.x);
       int i = threadIdx.x;
       int teste = blockIdx.x * blockDim.x + threadIdx.x;
       printf("i = %i\n", i);
       printf("teste m[%i] = %i\n", i, a[teste]);
     */

}
__global__ void transposta(int *a, int *r)
{
    int i = (blockDim.x * blockIdx.x) + threadIdx.x; // blockDim (3) * blockId (0..2) + threadId (0..2)
    //int j = blockIdx.y;
    int k = (blockDim.x * blockIdx.y) + threadIdx.y;
    printf(" y = %d\n", blockIdx.x + threadIdx.y);
    printf("a[%i] = %i \n", i, a[i]);
    printf("b[%i] = %i \n", j, a[j]);
    if (i < TAMANHO*TAMANHO && k < TAMANHO*TAMANHO)
    {    
        int indexa = i + TAMANHO * k;
        int indexb = k + TAMANHO * i;
        r[indexb] = a[indexa];
    }
    
}


int main()
{

    int m[TAMANHO][TAMANHO];
    int resultado[TAMANHO][TAMANHO];
    
    int* d_a = nullptr;
    int* d_r = nullptr;
  

    //atribuição de valores nos vetores
    printf("===MATRIZ GERADA===\n");
    for (int i = 0; i < TAMANHO; i++)
    {
        for (int j = 0; j < TAMANHO; j++)
        {
            m[i][j] = rand() % 100;
            printf("%d ", m[i][j]);
            
        }
        printf("\n");
    }

    printf("====RESERVA A MEMORIA DA GPU PARA DADOS====\n");
    //reserva espaço na memoria do device
    cudaMalloc((void**)&d_a, TAMANHO * TAMANHO * sizeof(int));
    cudaMalloc((void**)&d_r, TAMANHO * TAMANHO * sizeof(int));

    printf("====ENVIO DOS DADOS NA CPU PARA GPU====\n");
    //envia os dados da CPU para a memória reservada no device
    cudaMemcpy(d_a, m, TAMANHO * TAMANHO * sizeof(int), cudaMemcpyHostToDevice);


    transposta << <BLOCOS, TAMANHO >> > (d_a, d_r);
    cudaDeviceSynchronize();
    //retorna os dados do device para a CPU
    cudaMemcpy(resultado, d_r, TAMANHO * TAMANHO * sizeof(int), cudaMemcpyDeviceToHost);
    printf("=========\n");
    for (int i = 0; i < TAMANHO*TAMANHO; i++)
    {
        printf("c[%d] = %d\n", i, resultado[i]);
    }


    cudaFree(d_a);
    cudaFree(d_r);
  
    cudaDeviceReset();
    printf("====FIM====\n");
}
