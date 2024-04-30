---
layout: post
title:  algorithm notes 
date:   2024-04-30 09:08 
categories: tech 
---

Whenever I am re-learning algorithm, I am preparing on interview. That is a pity for me or for the industry.

# merge sort

<https://stackoverflow.com/questions/10502533/explanation-of-merge-sort-for-dummies>

```py
def merge(left, right):
    result = []
    i ,j = 0, 0
    while i < len(left) and j < len(right):
        if left[i] <= right[j]:
            result.append(left[i])
            i += 1
        else:
            result.append(right[j])
            j += 1
    result += left[i:]
    result += right[j:]
    return result

def mergesort(list):
    if len(list) < 2:
        return list
    middle = len(list) / 2
    left = mergesort(list[:middle])
    right = mergesort(list[middle:])
    return merge(left, right)
```

## quick sort

```py
def sort(array):
    """Sort the array by using quicksort."""

    less = []
    equal = []
    greater = []

    if len(array) > 1:
        pivot = array[0]
        for x in array:
            if x < pivot:
                less.append(x)
            elif x == pivot:
                equal.append(x)
            elif x > pivot:
                greater.append(x)
        # Don't forget to return something!
        return sort(less)+equal+sort(greater)  # Just use the + operator to join lists
    # Note that you want equal ^^^^^ not pivot
    else:  # You need to handle the part at the end of the recursion - when you only have one element in your array, just return the array.
        return array
```

## insertion sort

https://stackoverflow.com/questions/12755568/how-does-python-insertion-sort-work

```py
def insertion_sort(seq):
    for i in range(1, len(seq)):
        j = i
        while j > 0 and seq[j - 1] > seq[j]:
            seq[j - 1], seq[j] = seq[j], seq[j - 1]
            j -= 1
```

## selection sort

https://www.geeksforgeeks.org/python-program-for-selection-sort/

```py
def selectionSort(array, size):
    
    for ind in range(size):
        min_index = ind
        for j in range(ind + 1, size):
            # select the minimum element in every iteration
            if array[j] < array[min_index]:
                min_index = j
         # swapping the elements to sort the array
        array[ind], array[min_index] = array[min_index], array[ind]
```