The use of 2D thread indexing is simply convenience, the same can be achieved with 1D thread indexing too, it just will be tedious when it comes to assigning values to each thread.
In order to do 2D thread indexing, we need matrix dimensions lets say (M,N) now in code we define rows with y coordinate and col with x coordinate, hence the threads per block that we are launching is of dimension (N,M).
Thus we can see there are N columns and M rows. Then each thread in this M*N config has been assigned a for loop which does multiplication of individual elements from A and B and then sums them.
The sum is then written in the C matrix indices. The Array indexing is of the format in the code as we define a 1D array and play around with the index to make it 'effectively' a 2D matrix.
We only need to use the no. of threads needed for resultant matrix C. The memory copying of matrices will have different dimensions each and each one has to be allocated correctly.
We copy the result from device(GPU) to the host(CPU) of the matrix C as CPU and GPU have different memory space and then we can print it from CPU. 
The result can be directly printed from GPU also, but incase the further code requires this data for further calculation then we have to copy the data back to host.
