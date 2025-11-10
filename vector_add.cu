#include <stdio.h>
__global__ void vector_add(int *A, int *B, int *C, int N){
    int i=blockIdx.x*blockDim.x+threadIdx.x;
    if (i<N){
        C[i]=A[i]+B[i];
    }
}
int main(){
    const int N=10;
    int h_A[N], h_B[N], h_C[N];
    for (int i=0; i<N;i++){
        h_A[i]=i;
        h_B[i]=2*i;
    }
    int *d_A, *d_B, *d_C;
    cudaMalloc((void**)&d_A,N*sizeof(int));
    cudaMalloc((void**)&d_B,N*sizeof(int));
    cudaMalloc((void**)&d_C,N*sizeof(int));

    cudaMemcpy(d_A,h_A,N*sizeof(int),cudaMemcpyHostToDevice);
    cudaMemcpy(d_B,h_B,N*sizeof(int),cudaMemcpyHostToDevice);
    vector_add<<<1,10>>>(d_A,d_B,d_C,N);
    cudaMemcpy(h_C,d_C,N*sizeof(int),cudaMemcpyDeviceToHost);
    printf("Array A+B=C: \n");
    for (int i=0; i<N; i++){
        printf("%d + %d=%d\n",h_A[i],h_B[i],h_C[i]);
    }
    cudaFree(d_A);
    cudaFree(d_B);
    cudaFree(d_C);
    return 0;
}
