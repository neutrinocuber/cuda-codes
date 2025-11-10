__global__ command is to declare a function to be executed by GPU. It requires the kernel launch to be called from CPU.
printf works differently in kernel as it will simultaneously print multiple 'hello from gpu' if more than 1 threads are launched while in main function it needs to be put in a for loop which prints sequencially.

the running code commands are
1) in linux terminal
   > nvcc -O2 -arch=sm_75 hello.cu  
   >./a.out
2) in google colab
   >!pip install nvcc4jupyter
      
   >%load_ext nvcc4jupyter
      
   >%%cuda -c "-I/does/not/exist -arch sm_75"   
     //rest of the code
