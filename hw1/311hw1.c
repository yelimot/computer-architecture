// Yaşar Polatlı 250201075

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>

//# arrays for storing the contents of text file.
    char char_array[10000000];
    int numbers[300]; // you can change this size depend on number of elements in text file.
    int bst[1000000];

//# function for construct the tree.
void construct_tree(int child, int parent_index){
        if (child > bst[parent_index]){
            if (bst[(parent_index*2)+2] != 0) {
                construct_tree(child, ((parent_index*2)+2));
            }
            else {
                bst[(parent_index*2)+2] = child;
            }
        }
            
    else if (child < bst[parent_index]){
            if (bst[(parent_index*2)+1] != 0) {
                construct_tree(child, ((parent_index*2)+1));
            }
            else {
                bst[(parent_index*2)+1] = child;
            }
        }
    }

// function that writes element of sorted bst.
void write_file(int parent_index){
    FILE *fpointer;
    fpointer = fopen("inorder_traversal_300.txt", "a");
    fprintf(fpointer, "%d ", bst[parent_index]);
    fclose(fpointer);
}

// function that makes sorting (inorder traversal).
void inorder_tr(int parent_index){
    if (bst[parent_index] == '\0') {
        return;
    }
    inorder_tr((parent_index*2)+1);
    write_file(parent_index);
    inorder_tr((parent_index*2)+2);
}


int main() {
    
    // reading contents from the text file.
    FILE *fpointer; 
    fpointer = fopen("random_numbers_300.txt","r"); // you can change the text file to read different number of elements.
    fscanf(fpointer, "%[^\n]", char_array);
    fclose(fpointer); 

    int j = 0;
    int count = 0;
    char tempStr[3];
    
    for (int i = 0; i<strlen(char_array); i++){ 
        if(char_array[i] == ' '||char_array[i] =='\0') {
         tempStr[j] = '\0';
         j=0;
         int x = atoi(tempStr);
         numbers[count] = x;
         count++;
        }
        else {
           tempStr[j] = char_array[i];
           j++;
        }
    }
    
    // #time measurements
    struct timespec tstart={0,0}, tend={0,0};
    clock_gettime(CLOCK_MONOTONIC, &tstart);
    
    bst[0] = numbers[0];
    
    for (int i = 1; i < count; i++) {
        construct_tree(numbers[i], 0);
    }
    
    clock_gettime(CLOCK_MONOTONIC, &tend);
    
    printf("the operation we want to measure is %.9f seconds\n",
           ((double)tend.tv_sec + 1.0e-9*tend.tv_nsec) - 
           ((double)tstart.tv_sec + 1.0e-9*tstart.tv_nsec));
     
    // function call for sorting and writing bst.
    inorder_tr(0);
        
    return 0;
}