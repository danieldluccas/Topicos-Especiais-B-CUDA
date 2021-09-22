
#include "cuda_runtime.h"
#include "device_launch_parameters.h"

#include <stdio.h>

#define TAMANHO 10
#define BLOCOS 1
#define THREADS 1


__global__ void addVetor(int *c, int *a, int *b)
{
    int i = threadIdx.x;
    c[i] = a[i]+b[i];
    

 /*   printf("teste addkernel %i\n", blockIdx.x * blockDim.x + threadIdx.x);
    int i = threadIdx.x;
    int teste = blockIdx.x * blockDim.x + threadIdx.x;
    printf("i = %i\n", i);
    printf("teste m[%i] = %i\n", i, a[teste]);
  */

}



int main()
{
 
 int m[TAMANHO];
 int n[TAMANHO];
 int resultado[TAMANHO];
 const int teste[TAMANHO] = { 1,2,3,4,5 };
 int testando = 3;
 int* d_a = nullptr;
 int* d_b = nullptr;
 int* d_c = nullptr;

 int* d_t = nullptr;
 
 
 
//atribuição de valores nos vetores
     for (int i = 0; i < TAMANHO; i++)
     {
         m[i] = i;
         n[i] = 2*i;   
     }
     
     printf("====RESERVA A MEMORIA DA GPU PARA DADOS====\n");
//reserva espaço na memoria do device
     cudaMalloc((void**)&d_a, TAMANHO * sizeof(int));
     cudaMalloc((void**)&d_b, TAMANHO * sizeof(int));
     cudaMalloc((void**)&d_c, TAMANHO * sizeof(int));
     //cudaMalloc((void**)&d_t, sizeof(int));

     printf("====ENVIO DOS DADOS NA CPU PARA GPU====\n");
//envia os dados da CPU para a memória reservada no device
     cudaMemcpy(d_a, m, TAMANHO * sizeof(int), cudaMemcpyHostToDevice);
     cudaMemcpy(d_b, n, TAMANHO * sizeof(int), cudaMemcpyHostToDevice);
     //cudaMemcpy(d_t, &testando, sizeof(int), cudaMemcpyHostToDevice);
     
     
     
     addVetor << <1, TAMANHO >> > (d_c, d_a, d_b);
     cudaDeviceSynchronize();
//retorna os dados do device para a CPU
     cudaMemcpy(resultado, d_c, TAMANHO * sizeof(int), cudaMemcpyDeviceToHost);

     for (int i = 0; i < TAMANHO; i++)
     {
         printf("c[%d] = %d\n",i, resultado[i]);
     }

     
     cudaFree(d_a);
     cudaFree(d_b);
     cudaFree(d_c);
     
     cudaDeviceReset();
     printf("====FIM====\n");
}
