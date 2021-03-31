# Yaşar Polatlı 250201075

import datetime

# list for storing the contents of text file.
numbers = []

# open the file and store the contents.
with open('random_numbers_200.txt') as fr:

    for line in fr:
        numbers.extend([int(i) for i in line.split()])

bst = [None] * 1000000

# assignment of the first node of the binary search tree
bst[0] = numbers[0]

# function for construct the tree.
def construct_tree(child, parent):
    if (child > parent):
        index = bst.index(parent)
        if(bst[index*2 + 2] != None):
            construct_tree(child, bst[index*2 + 2])
        else:
            bst[index*2 + 2] = child

    elif (child < parent):
        index = bst.index(parent)
        if(bst[index*2 + 1] != None):
            construct_tree(child, bst[index*2 + 1])
        else:
            bst[index*2 + 1] = child

# time measurements
start_time = datetime.datetime.now()

for i in numbers:
    construct_tree(i, bst[0])

end_time = datetime.datetime.now()

print(end_time-start_time)

# first creation of text file to saving content
fa = open("inorder_traversal_200.txt", "w")
fa.close()

# reopen it for append the inordered numbers
fa = open("inorder_traversal_200.txt", "a")

# function for traversals and writing operations on bst array.
def inorder_tr(parent):
    if (parent == None):
        return
    index = bst.index(parent)
    inorder_tr(bst[(2*index)+1])
    fa.write((str(bst[index])) + " ")
    inorder_tr(bst[(2*index)+2])

inorder_tr(bst[0])

fa.close()

