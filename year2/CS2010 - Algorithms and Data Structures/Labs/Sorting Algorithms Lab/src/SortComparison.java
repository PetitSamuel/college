// -------------------------------------------------------------------------
// used in the main method when timing the algorithms
/*
import java.io.IOException;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.Scanner;
*/

/**
 *  This class contains static methods that implementing sorting of an array of numbers
 *  using different sort algorithms.
 *
 *  @author
 *  @version HT 2019
 */

class SortComparison {
/*
All of the values are in Nano Seconds (ns)
	            Insert	 Quick	    Merge Recursive	Merge Iterative Selection
10 random 	    289306	 339874	    787691	        31362	        4378131
100 random 	    1269180	 549439	    811516	        93870	        5919113
1000 random     2915553	 4390529	3584118	        1955128	        7939153
1000 Double	    6334839	 4453739	2898413	        1750547	        11284654
1000 nearly     1087087	 3117460	2341802	        1642361	        10313168
1000 reverse 	5294794	 21576063	2613118	        1003699	        8707638
1000 sorted	    85333	 19926652	2200917	        1169381	        17516292

a. Insertion sort is heavily affected by the order of numbers : it will require no swaps in the case of a sorted array but would have a ton of swaps if the values are
reversed. Quick sort is also affected as in the case of a sorted/reversed array, the values will all be partitioned in a non ideal manner, thus making randomized values
perform better when using quicksort. Algorithms such as merge and selection sort are not really affected by the way values are ordered.
b. insertion sort. It is because of the fact that in a sorted array it requires no swaps. On the other hand it would require a lot of swaps
when sorting a reverse sorted array.
C. although it is one of the worst in terms of times, selection sort only changes by a fractions when increasing the input size. We can also observe that
insertion sort does not scale very well in comparison to the other algorithms.
d. it seems that the iterative version of merge sort is about 2x faster than the recursive version
e. It seems like out of all of the input files the recursive merge is consistently faster
 */
    /**
     * Sorts an array of doubles using InsertionSort.
     * This method is static, thus it can be called as SortComparison.sort(a)
     *
     * @param a: An unsorted array of doubles.
     * @return array sorted in ascending order.
     */
    static double[] insertionSort(double a[]) {
        if (a == null || a.length < 2) return a;
        int N = a.length;
        for (int i = 1; i < N; i++) {
            double val = a[i];
            int j = i;
            while (j > 0 && a[j - 1] > val)
            {
                a[j] = a[j - 1];
                j = j-1;
            }
            a[j] = val;
        }
        return a;
    }
    /**
     * Sorts an array of doubles using Quick Sort.
     * This method is static, thus it can be called as SortComparison.sort(a)
     * @param a: An unsorted array of doubles.
     * @return array sorted in ascending order
     *
     */
    static double [] quickSort (double a[]){
        if (a == null || a.length < 2) return a;
        recursiveQuick(a, 0, a.length-1);
        return a;
    }

    static void recursiveQuick(double a[], int lo, int hi) {
        if(hi <= lo) return;
        int pivotPos = partition(a, lo, hi);
        recursiveQuick(a, lo, pivotPos - 1);
        recursiveQuick(a, pivotPos + 1, hi);
    }

    static private int partition(double a[], int lo, int hi) {
        int i = lo;
        int j = hi+1;
        double pivot = a[lo];
        while(true) {
            while((a[++i] < pivot)) {
                if(i == hi) break;
            }
            while(pivot < a[--j]){
                if(j == lo) break;
            }
            if(i >= j) break;
            double temp = a[i];
            a[i] = a[j];
            a[j] = temp;
        }
        a[lo] = a[j];
        a[j] = pivot;
        return j;
    }
    /**
     * Sorts an array of doubles using Merge Sort.
     * This method is static, thus it can be called as SortComparison.sort(a)
     * @param a: An unsorted array of doubles.
     * @return array sorted in ascending order
     *
     */
    /**
     * Sorts an array of doubles using iterative implementation of Merge Sort.
     * This method is static, thus it can be called as SortComparison.sort(a)
     *
     * @param a: An unsorted array of doubles.
     * @return after the method returns, the array must be in ascending sorted order.
     */

    static double[] mergeSortIterative (double a[]) {
        if(a == null || a.length < 2) return a;
        int size = a.length;
        double [] b = new double[size];
        for(int i = 1; i < size; i = i + i) {
            for(int j = 0; j < size - i; j += i + i) {
                merge(a, b, j, j + i - 1, Math.min(i + i + j - 1, size - 1));
            }
        }
        return a;
    }

    public static void merge(double [] a, double [] b, int lo, int mid, int hi) {
        for (int k = lo; k <= hi; k++)
            b[k] = a[k];


        int i = lo, j = mid + 1;
        for (int k = lo; k <= hi; k++) {
            if (i > mid) {
                a[k] = b[j++];
            } else if (j > hi) {
                a[k] = b[i++];
            } else if (b[j] < b[i]) {
                a[k] = b[j++];
            } else {
                a[k] = b[i++];
            }
        }
    }

    /**
     * Sorts an array of doubles using recursive implementation of Merge Sort.
     * This method is static, thus it can be called as SortComparison.sort(a)
     *
     * @param a: An unsorted array of doubles.
     * @return after the method returns, the array must be in ascending sorted order.
     */
    static double[] mergeSortRecursive (double a[]){
        if (a == null || a.length < 2) return a;
        int size = a.length;
        int mid = size /2;

        double[] arr1 = new double[mid];
        double[] arr2 = new double[size - mid];

        System.arraycopy(a, 0, arr1, 0, mid);
        System.arraycopy(a, mid, arr2, 0, size - mid);

        return merge(mergeSortRecursive(arr1), mergeSortRecursive(arr2));
    }
    static double[] merge (double a[], double b[]) {
        int i = 0;
        int j = 0;
        int size = a.length + b.length;
        double [] merged = new double[size];

        for(int index = 0; index < size; index++) {
            if (i >= a.length) {
                merged[index] = b[j++];
            } else if (j >= b.length) {
                merged[index] = a[i++];
            }
            else if (a[i] < b[j]) {
                merged[index] = a[i++];
            } else {
                merged[index] = b[j++];
            }
        }
        return merged;
    }//end mergeSortRecursive

    /**
     * Sorts an array of doubles using Selection Sort.
     * This method is static, thus it can be called as SortComparison.sort(a)
     * @param a: An unsorted array of doubles.
     * @return array sorted in ascending order
     *
     */
    static double [] selectionSort (double a[]){
        if (a == null || a.length < 2) return a;
        int N = a.length;
        for (int i = 0; i < N - 1; i++) {
            int low = i;
            for(int j = i+1; j < N; j++) {
                if (a[low] > a[j]) {
                    low = j;
                }
            }
            swap(a, low, i);
        }
        return a;
    }

    static void swap (double a[], int i , int j) {
        double tmp = a[i];
        a[i] = a[j];
        a[j] = tmp;
    }
    // I used this function and changed the file used/sort method in order to obtain the times above
    /*
    public static void main(String[] args) {
        Path path = Paths.get("input/numbers10.txt");
        double [] a = new double [1000];
        int i = 0;
        Scanner s = null;
        try {
            s = new Scanner(path);
            while(s.hasNext()) {
                String str = s.next();
                double val = Double.parseDouble(str);
                a[i++] = val;
            }

            s.close();
        } catch (IOException e){
            e.printStackTrace();
        }
        long [] times = new long[3];
        for(int j = 0; j < 3; j++) {
            long start = System.nanoTime();
            a = selectionSort(a);
            long end = System.nanoTime();
            times[j] = end - start;
        }
        long avg = (times [0] + times[1] + times[2]) / 3;
        System.out.println("average running times : " + avg + " in ns");

    }
    */
}