#include <stdio.h>
__global__ void add_arrays(int *A, int *B, int *C, int N){
    int i=blockIdx.x*blockDim.x+threadIdx.x;
    if (i<N){
        C[i]=A[i]+B[i];
    }
}
int main(){
    const int N=10;
    int *h_A, *h_B, *h_C;
    h_A=(int*) malloc(N*sizeof(int));
    h_B=(int*) malloc(N*sizeof(int));
    h_C=(int*) malloc(N*sizeof(int));
    if (h_A==NULL){
        printf("memory not allocated");
        return 1;
    }
    h_A[0]=-1;
    h_A[1]=3;
    h_A[2]=10;
    h_A[3]=2;
    h_A[4]=-20;
    h_A[5]=2;
    h_A[6]=7;
    h_A[7]=7;
    h_A[8]=6;
    h_A[9]=-3;
    h_B[0]=4,
    h_B[1]=1,
    h_B[2]=-2,
    h_B[3]=12,
    h_B[4]=7, 
    h_B[5]=-1,
    h_B[6]=0,
    h_B[7]=-1,
    h_B[8]=9,
    h_B[9]=0;
    int *d_A, *d_B, *d_C;
    cudaMalloc((void**)&d_A,N*sizeof(int));
    cudaMalloc((void**)&d_B,N*sizeof(int));
    cudaMalloc((void**)&d_C,N*sizeof(int));

    cudaMemcpy(d_A,h_A,N*sizeof(int),cudaMemcpyHostToDevice);
    cudaMemcpy(d_B,h_B,N*sizeof(int),cudaMemcpyHostToDevice);
    add_arrays<<<1,N>>>(d_A,d_B,d_C,N);
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
