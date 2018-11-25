//
//  main.m
//  SortAlgorithm
//
//  Created by XL Yuen on 2018/11/20.
//  Copyright © 2018 XL Yuen. All rights reserved.
//

#import <Foundation/Foundation.h>

#define ARRAY_SIZE(x) (sizeof(x)/sizeof((x)[0]))

void showArray(int arr[], int length) {
    NSMutableString *string = [NSMutableString string];
    for (int i = 0; i < length; i++) {
        int a = arr[i];
        [string appendFormat:@"%d, ", a];
    }
    NSLog(@"数组排序结果：");
    NSLog(@"%@", string);
}

void swap(int arr[], int i, int j) {
    int temp = arr[i];
    arr[i] = arr[j];
    arr[j] = temp;
}
/**
 * 普通排序
 */
int * normalSort(int arr[], int length) {
    for (int i = 0; i < length - 1; i++) {
        for (int j = i + 1; j < length; j++) {
            if (arr[j] < arr[i]) {
                swap(arr, i, j);
            }
        }
    }
    return arr;
}

/**
 * 冒泡排序
 */
int * bubbleSort(int arr[], int length) {
    for (int i = 0; i < length - 1; i++) {
        bool flag = false;
        for (int j = length - 1; j > i; j--) {
            if (arr[j] < arr[j - 1]) {
                swap(arr, j - 1, j);
                flag = true;
            }
        }
        if (!flag) {
            break;
        }
    }
    return arr;
}

/**
 * 插入排序
 */
int * insertSort(int arr[], int length) {
    for (int i = 1; i < length; i++) {
        if (arr[i] > arr[i - 1]) {
            continue;
        }
        int temp = arr[i];
        int j;
        for (j = i - 1; j >= 0; j--) {
            if (temp < arr[j]) {
                arr[j+1] = arr[j];
            } else {
                break;
            }
        }
        if (temp != arr[i]) {
            arr[j+1] = temp;
        }
    }
    return arr;
}

/**
 * 选择排序
 */
int * selectSort(int arr[], int length) {
    for (int i = 0; i < length - 1; i++) {
        int min = i;
        for (int j = i + 1; j < length; j++) {
            if (arr[j] < arr[min]) {
                min = j;
            }
        }
        if (min != i) {
            swap(arr, min, i);
        }
    }
    return arr;
}


/**
 * 快速排序
 */

void adjustQuickArray(int arr[], int left, int right);

int *quickSort(int arr[], int length) {
    adjustQuickArray(arr, 0, length - 1);
    return arr;
}

void adjustQuickArray(int arr[], int left, int right) {
    if (left >= right) {
        return;
    }
    int i = left;
    int j = right;
    int pivot = arr[left];
    while (i < j) {
        while (i < j && arr[j] >= pivot) {
            j--;
        }
        arr[i] = arr[j];
        
        while (i < j && arr[i] <= pivot) {
            i++;
        }
        arr[j] = arr[i];
    }
    arr[i] = pivot;
    adjustQuickArray(arr, left, i - 1);
    adjustQuickArray(arr, i + 1, right);
}


/**
 * 希尔排序
 */
int * shellSort(int arr[], int length) {
    for (int gap = length/2; gap >= 1; gap/=2) {
        for (int i = gap; i < length; i++) {
            if (arr[i] < arr[i - gap]) {
                int temp = arr[i];
                int j = i - gap;
                
//                while (temp < arr[j] && j >= 0) {
//                    arr[j + gap] = arr[j];
//                    j-=gap;
//                }
                
                for (; j >= 0; j-=gap) {
                    if (temp < arr[j]) {
                        arr[j + gap] = arr[j];
                    } else {
                        break;
                    }
                }
                arr[j + gap] = temp;
            }
        }
    }
    return arr;
}

/**
 * 堆排序
 * 一般都用数组来表示堆，i结点的父结点下标就为(i – 1) / 2。它的左右子结点下标分别为2 * i + 1 和 2 * i + 2。
 */
void adjustMaxHeap(int arr[], int length, int index);

int * heapSort(int arr[], int length) {
    for (int i = length / 2 - 1; i >= 0; i--) {
        adjustMaxHeap(arr, length, i);
    }
    for (int i = length - 1; i > 0; i--) {
        swap(arr, 0, i);
        adjustMaxHeap(arr, i, 0);
    }
    return arr;
}

/**
 * 在当前结点自上到下
 * 在叶子结点中从左到右
 */
void adjustMaxHeap(int arr[], int length, int index) {
    
    int i = index;
    int j = 2 * i + 1;
    int temp = arr[i];
    
//    while (j < length) {
//
//        if (j + 1 < length && arr[j + 1] > arr[j]) {
//            j++;
//        }
//
//        if (arr[j] > temp) {
//            arr[i] = arr[j];
//            i = j;
//            j = 2 * j + 1;
//        } else {
//            break;
//        }
//    }
    
    for (; j < length; i = j, j = 2 * j + 1) {
        if (j + 1 < length && arr[j + 1] > arr[j]) {
            j++;
        }
        if (arr[j] > temp) {
            arr[i] = arr[j];
        } else {
            break;
        }
    }
    arr[i] = temp;
}

/**
 * 归并排序
 */
void resolveArray(int arr[], int tempArr[], int first, int last); // 先分解
void mergeArray(int arr[], int tempArr[], int first, int middle, int last); // 在合并:第一种
void mergeArray2(int arr[], int tempArr[], int first, int last); // 在合并:第二种

void * mergeSort(int arr[], int length) {
    
    int tempArray[length];
    resolveArray(arr, tempArray, 0, length - 1);
    return arr;
}

void resolveArray(int arr[], int tempArr[], int first, int last) {
    if (first < last) {
        int middle = (first + last) / 2;
        resolveArray(arr, tempArr, first, middle);
        resolveArray(arr, tempArr, middle + 1, last);
//        mergeArray(arr, tempArr, first, middle, last);
        mergeArray2(arr, tempArr, first, last);
    }
}

void mergeArray(int arr[], int tempArr[], int first, int middle, int last) {
    
    int i = first;
    int j = middle + 1;
    int k = first;
    
    while (i <= middle && j <= last) {
        if (arr[i] <= arr[j]) {
            tempArr[k++] = arr[i++];
        } else {
            tempArr[k++] = arr[j++];
        }
    }
    
    while (i <= middle) {
        tempArr[k++] = arr[i++];
    }
    
    while (j <= last) {
        tempArr[k++] = arr[j++];
    }
    
    for (int h = first; h < k; h++) {
        arr[h] = tempArr[h];
    }
    
}

void mergeArray2(int arr[], int tempArr[], int first, int last) {
    
    int middle = (first + last) / 2;
    int i = first;
    int j = middle + 1;
    int k = first;
    
    while (i <= middle && j <= last) {
        if (arr[i] <= arr[j]) {
            tempArr[k++] = arr[i++];
        } else {
            tempArr[k++] = arr[j++];
        }
    }
    
    while (i <= middle) {
        tempArr[k++] = arr[i++];
    }
    
    while (j <= last) {
        tempArr[k++] = arr[j++];
    }
    
    for (int n = first; n < k; n++) {
        arr[n] = tempArr[n];
    }
    
}

/**
 * 合并有序数组
 */
void mergeOrderedArray(int a[], int aLength, int b[], int bLength, int mergeArray[]) {
    
    int i = 0;
    int j = 0;
    int k = 0;
    while (i < aLength && j < bLength) {
        
        if (a[i] <= b[j]) {
            mergeArray[k++] = a[i++];
        } else {
            mergeArray[k++] = b[j++];
        }
    }
    while (i < aLength) {
        mergeArray[k++] = a[i++];
    }
    while (j < bLength) {
        mergeArray[k++] = b[j++];
    }
    
}

int * array() {
    static int *newArray;
    int arr[] = {2, 1, 4, 6, 5, 9, 8, 7, 0, 3};
    newArray = malloc(sizeof(arr));
    memcpy(newArray, arr, sizeof(arr));
    return newArray;
}

int main(int argc, const char * argv[]) {
    @autoreleasepool {

        int *newArr;
        int count = 10;
        
        NSLog(@"普通排序-------------");
        newArr = normalSort(array(), count);
        showArray(newArr, count);

        NSLog(@"冒泡排序-------------");
        newArr = bubbleSort(array(), count);
        showArray(newArr, count);

        NSLog(@"插入排序-------------");
        newArr = insertSort(array(), count);
        showArray(newArr, count);

        NSLog(@"选择排序-------------");
        newArr = selectSort(array(), count);
        showArray(newArr, count);

        NSLog(@"希尔排序-------------");
        newArr = shellSort(array(), count);
        showArray(newArr, count);
        
        NSLog(@"堆排序-------------");
        newArr = heapSort(array(), count);
        showArray(newArr, count);

        NSLog(@"快速排序-------------");
        newArr =  quickSort(array(), count);
        showArray(newArr, count);
        
        NSLog(@"归并排序-------------");
        newArr =  mergeSort(array(), count);
        showArray(newArr, count);
        
        int a[] = {2,4,4,4,4};
        int b[] = {0,4,6,8,10};
        int c[10];
        mergeOrderedArray(a, 5, b, 5, c);
        showArray(c, 10);
    }
    return 0;
}
