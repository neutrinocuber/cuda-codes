#include <stdio.h>
__global__ void matMulmkn(int *A, int *B, int *C, int M, int K, int N) {
    int row= threadIdx.y+blockIdx.y*blockDim.y;
    int col= threadIdx.x+blockIdx.x*blockDim.x;
    if (row<M && col<N) {
        int sum=0;
        for (int i=0; i<K; i++){
            sum+=A[row*K+i]*B[i*N+col];
        }
        C[row*N+col]=sum;
    }
}
int main(){
    const int M=4;
    const int K=2;
    const int N=3;
    int h_A[M*K]={0, -3,
                2, 1,
                -1, 8,
                4, 2};
    int h_B[K*N]={-2, 9, 7,
                  2, 5, 3};
    int h_C[M*N];
    int *d_A, *d_B, *d_C;
    cudaMalloc((void**)&d_A,M*K*sizeof(int));
    cudaMalloc((void**)&d_B,K*N*sizeof(int));
    cudaMalloc((void**)&d_C,M*N*sizeof(int));

    cudaMemcpy(d_A,h_A,M*K*sizeof(int),cudaMemcpyHostToDevice);
    cudaMemcpy(d_B,h_B,K*N*sizeof(int),cudaMemcpyHostToDevice);
    dim3 thr(N,M);
    dim3 numb(1,1);
    matMulmkn<<<numb,thr>>>(d_A,d_B,d_C,M,K,N);
    cudaDeviceSynchronize();
    cudaMemcpy(h_C,d_C,M*N*sizeof(int),cudaMemcpyDeviceToHost);
    printf("Matrix C=A*B :\n");
    for (int i=0; i<M; i++){
        for (int j=0; j<N; j++){
            printf("%d ",h_C[i*N+j]);
        }
        printf("\n");
    }
    cudaFree(d_A);
    cudaFree(d_B);
    cudaFree(d_C);
    return 0;
}
