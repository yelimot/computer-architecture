// C program to multiply two square matrices. 
#include <stdio.h> 
#include <stdlib.h>
#define N 1000
  
// This function multiplies mat1 and mat2, 
// and stores the result in res 
void multiply(double **mat1, double **mat2, double **res) 
{ 
    int i, j, k; 
    for (i = 0; i < N; i++) 
    { 
        for (j = 0; j < N; j++) 
        { 
            res[i][j] = 0; 
            for (k = 0; k < N; k++) 
                res[i][j] += mat1[i][k]*mat2[k][j]; 
        } 
    } 
} 
  
int main() 
{ 
    double *mat1[N]; 
    double *mat2[N]; 
    double *res[N]; // To store result 

    int i, j;

    for (i = 0; i < N; i++) 
    { 
        mat1[i] = (double *) malloc(N * sizeof(double));
	mat2[i] = (double *) malloc(N * sizeof(double)); 
 	res[i] = (double *) malloc(N * sizeof(double)); 
        for (j = 0; j < N; j++) 
        { 
            mat1[i][j]= i+1; 
	    mat2[i][j]= j+1; 
        } 
    } 
    
    
    multiply(mat1, mat2, res); 
    
    printf("Matrix multiplication complete \n"); 
    printf("Result matrix is \n"); 
    for (i = 0; i < N; i++) 
    { 
        for (j = 0; j < N; j++) 
           printf("%f ", res[i][j]); 
        printf("\n"); 
    }
  
    return 0; 
} 
