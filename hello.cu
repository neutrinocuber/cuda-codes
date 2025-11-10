#include <stdio.h>
__global__ void hello_from_GPU()
{
    printf("Hello from GPU \n");
}

int main()
{ 
    hello_from_GPU <<<1,1>>>();
    cudaDeviceSynchronize();
    printf("Hello from CPU \n");
    cudaDeviceReset();
    return 0;
}
