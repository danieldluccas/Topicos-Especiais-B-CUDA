
#include "cuda_runtime.h"
#include "device_launch_parameters.h"

#include <stdio.h>

void main(void)
{
	cudaDeviceProp minhaGPU;
	cudaGetDeviceProperties(&minhaGPU, 0);
	//Especificações da minha GPU
	////GEFORCE GTX 1650 (MICROARQUITETURA TURING)
	printf("Nome: %s \n", minhaGPU.name);
	printf("Clock: %.2lf GHz\n", (float) minhaGPU.clockRate/1000000);
	printf("Numero maximo de blocos: %d \n", minhaGPU.maxBlocksPerMultiProcessor);
	printf("Numero max de cada thread por bloco: %d\n", minhaGPU.maxThreadsPerBlock);
	printf("No qtd de multiprocessamento: %d\n", minhaGPU.multiProcessorCount);
	printf("Memoria compartilhada por SM: %.3fKB\n", (float)minhaGPU.sharedMemPerMultiprocessor/1000);
	printf("Memoria global: %.3llf GB\n", (float)minhaGPU.totalGlobalMem / 1000000000);
	printf("Tamanho de warp em threads: %d\n", minhaGPU.warpSize);
	//N cores por SM
	
	//referência: https://docs.nvidia.com/cuda/cuda-runtime-api/structcudaDeviceProp.html
}
