
#include "common.h"
#include "timer.h"

__global__ void mm_kernel(float* A, float* B, float* C, unsigned int M, unsigned int N, unsigned int K) {

    // TODO

unsigned int row = blockIdx.y*blockDim.y + threadIdx.y;
unsigned int col = blockIdx.x*blockDim.x + threadIdx.x;
float temp_sum = 0.0f;

if (row < M && col < N) {
    for (unsigned int i = 0; i < K; i++) {
        float op1 = A[row*K + i];
        float op2 = B[i*N + col];
        temp_sum += op1*op2;
    }
    C[row*N + col] = temp_sum;
    }
}



void mm_gpu(float* A, float* B, float* C, unsigned int M, unsigned int N, unsigned int K) {

    Timer timer;

    // Allocate GPU memory
    startTime(&timer);

    // TODO

    float *A_d, *B_d, *C_d;
    cudaMalloc((void**) &A_d, M*K*sizeof(float));
    cudaMalloc((void**) &B_d, M*K*sizeof(float));
    cudaMalloc((void**) &C_d, M*K*sizeof(float));


    cudaDeviceSynchronize();
    stopTime(&timer);
    printElapsedTime(timer, "Allocation time");

    // Copy data to GPU
    startTime(&timer);

    // TODO

    cudaMemcpy(A_d, A, M*K*sizeof(float), cudaMemcpyHostToDevice);
    cudaMemcpy(B_d, B, N*K*sizeof(float), cudaMemcpyHostToDevice);



    cudaDeviceSynchronize();
    stopTime(&timer);
    printElapsedTime(timer, "Copy to GPU time");

    // Call kernel
    startTime(&timer);

    // TODO

    dim3 numThreadsPerBlock(M,N);
    dim3 numBlocks((N+numThreadsPerBlock.x - 1)/numThreadsPerBlock.x, (M + numThreadsPerBlock.x - 1)/numThreadsPerBlock.x);



    cudaDeviceSynchronize();
    stopTime(&timer);
    printElapsedTime(timer, "Kernel time", GREEN);

    // Copy data from GPU
    startTime(&timer);

    // TODO

    cudaMemcpy(C, C_d, M*N*sizeof(float), cudaMemcpyDeviceToHost);



    cudaDeviceSynchronize();
    stopTime(&timer);
    printElapsedTime(timer, "Copy from GPU time");

    // Free GPU memory
    startTime(&timer);

    // TODO

    cudaFree(A_d);
    cudaFree(B_d);
    cudaFree(C_d);


    cudaDeviceSynchronize();
    stopTime(&timer);
    printElapsedTime(timer, "Deallocation time");

}

