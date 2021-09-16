
#include "cuda_runtime.h"
#include "device_launch_parameters.h"

#include <stdio.h>


__global__ void callID(void)
{
    printf("Block Dim: %d | Block ID: %d | Thread ID: %d\n", blockDim.x, blockIdx.x, threadIdx.x);
}

int main()
{
    callID << <3, 5 >> > ();
    cudaDeviceSynchronize();
    cudaDeviceReset();
    return 0;
}
