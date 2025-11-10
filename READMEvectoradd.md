The kernel function here takes in values at the address mentioned by d_A, d_B, d_C and takes integer value N which is the size of array and then threads
are assigned matrix elements to add.
Since the code limits to only 10 threads, the required threads are 10 and so we launch those many threads, the threads take those values and parallely
add the values.
We need to allocate memory on host and device for the arrays as the computer needs to be told where to store the values. GPU and CPU have seperate memory
spaces thus we then need to copy the data from host to device to send the input data to the GPU to add arrays and the added array result needs to be copied
from GPU to CPU (CPU is the host while GPU is device).
BlockSize and GridSize depends on the problem being tackled, the no. of individual threads needed will be constant for a problem as we know how many 
quantities need to be calculated which will be equal to blockSize*gridSize, but the block and grid sizes will simply depend on convenience of defining. 
To verify results one can write the same code in C and corss verify for a few elements incase the calculation is tedious, else manually printing and checking.
