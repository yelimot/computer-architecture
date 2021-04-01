# 250201075
# Yaşar Polatlı

.data
# -9999 marks the end of the list
firstList: .word 8, 3, 6, 10, 13, 7, 4, 5
size: .word 8

# other examples for testing your code
secondList: .word 8, 3, 6, 6, 10, 13, 7, 4, 5, -9999
thirdList: .word 8, 3, 6, 10, 13, -9999, 7

# assertEquals data
failf: .asciiz " failed\n"
passf: .asciiz " passed\n"
buildTest: .asciiz " Build test"
insertTest: .asciiz " Insert test"
findTest: .asciiz " Find test"
asertNumber: .word 0

.text
main:
    la $t6, firstList
    move $t0, $zero
    lw $a1, size

build:
    sll $t1, $t0, 2 # loop index for iteration on the list
    add $t2, $t6, $t1 # like $t2 = array[i]
    lw $t4, 0($t2) # value of the elements saved to t4 register iteratively

    beq $t0, $zero, parentNode
    bne $t0, $zero, insert

parentNode: # iteratively determines the parent 
    li $a0, 16 # 16 byte of memory for a0 register 
    li $v0, 9 # system call for allocate this memory
    syscall
    add $t5, $t4, $zero # t5 register will be the root node to use it ** later **
    move $s3, $t5 
    move $s0, $v0
    sw $t4, 0($s0) # store the first value to (0)th byte of first node address
    move $s5, $s0 # storing address of parent for ** later ** use
    j indexIncrement

indexIncrement:
    move $s0, $s5
    sw $zero, 0($t2)
    addi $t0, $t0, 1 # index incremented
    slt $t3, $t0, $a1
    bne $t3, $zero, build
    j findInput # after building the tree you can try to find any value then program finishes.

insert:
    blt $t4, $t5, insertLeft
    bgt $t4, $t5, insertRight

insertLeft:
    lw $t7, 4($s0) 
    bne $t7, $zero, newParent # control; whether the address 4($s0) is empty or not
    li $a0, 16 # 16 byte of memory for a0 register 
    li $v0,9 # system call for allocate this memory
    syscall
    move $s1, $v0
    sw $t4, 0($s1) # value of node
    sw $s1, 4($s0) # address of the left child
    sw $s0, 12($s1) # address of the parent
    move $t5, $s3  
    j indexIncrement

newParent:
    move $s0, $t7 # address of the left or right node (which will be new parent) update
    lw $t5, 0($s0)
    j insert

insertRight:
    lw $t4, 8($s0) # only difference is addressing
    bne $t7, $zero, newParent 
    li $a0, 16 
    li $v0,9
    syscall
    move $s2, $v0 # and this register
    sw $t4, 0($s2) # value of node
    sw $s1, 8($s0) # address of the right child
    sw $s0, 12($s1) # address of the parent
    move $t5, $s3  
    j indexIncrement

findInput:
    li $v0,5
    syscall
    move $s4, $v0
    j find

find:
    move $s6, $a0 # search value moved to the s6 register
    lw $s4, 0($s0)
    
    blt $s6, $s4, findLeft # searching operations
    bgt $s6, $s4, findRight

    li $v0, 1
    move $a0, $v0
    syscall
    j exit

findLeft:
    lw $s7, 4($s0) # left node exist in 4th byte index
    lw $s0, 0($s7)
    beq $s0, $zero, exit
    move $s0, $s7
    j find

findRight:
    lw $s7, 8($s0) # only difference is addressing 
    lw $s0, 0($s7)
    beq $s0, $zero, exit
    move $s0, $s7
    j find

exit:
    li $v0, 10
    syscall
