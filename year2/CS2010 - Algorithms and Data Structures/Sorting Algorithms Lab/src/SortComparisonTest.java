import org.junit.Test;
import org.junit.runner.RunWith;
import org.junit.runners.JUnit4;

import static org.junit.Assert.*;

//-------------------------------------------------------------------------
/**
 *  Test class for SortComparison.java
 *
 *  @author Samuel Petit
 *  @version HT 2019
 */
@RunWith(JUnit4.class)
public class SortComparisonTest
{
    //~ Constructor ........................................................
    @Test
    public void testConstructor()
    {
        new SortComparison();
    }

    @Test
    public void testMergeRecursive(){
        double a[] = {12.0,505.0,1.0,0.0,-10.0,50.3,101.0,5000.0,-2000.0,12.12};

        double c[] = {1};
        double d[] = null;
        a = SortComparison.mergeSortRecursive(a);
        isOrdered(a);
        assertNull(SortComparison.mergeSortRecursive(d));
        assertEquals(c, SortComparison.mergeSortRecursive(c));
    }

    void isOrdered (double a[]) {
        for(int i = 0; i < a.length - 1; i++) {
            assertTrue(a[i] < a[i+1]);
        }
    }

    @Test
    public void testMergeIterative(){
        double a[] = {12.0,505.0,1.0,0.0,-10.0,50.3,101.0,5000.0,-2000.0,12.12};

        double c[] = {1};
        double d[] = null;
        a = SortComparison.mergeSortIterative(a);
        isOrdered(a);
        assertNull(SortComparison.mergeSortIterative(d));
        assertEquals(c, SortComparison.mergeSortIterative(c));
    }

    @Test
    public void testInsertion(){
        double a[] = {12.0,505.0,1.0,0.0,-10.0,50.3,101.0,5000.0,-2000.0,12.12};

        double c[] = {1};
        double d[] = null;
        a = SortComparison.insertionSort(a);
        isOrdered(a);
        assertNull(SortComparison.insertionSort(d));
        assertEquals(c, SortComparison.insertionSort(c));
    }

    @Test
    public void testQuickSort(){
        double a[] = {12.0,505.0,1.0,0.0,-10.0,50.3,101.0,5000.0,-2000.0,12.12};

        double c[] = {1};
        double d[] = null;
        a = SortComparison.quickSort(a);
        isOrdered(a);
        assertNull(SortComparison.quickSort(d));
        assertEquals(c, SortComparison.quickSort(c));
    }
    @Test
    public void testSelectionSort(){
        double a[] = {12.0,505.0,1.0,0.0,-10.0,50.3,101.0,5000.0,-2000.0,12.12};
        double c[] = {1};
        double d[] = null;
        a = SortComparison.selectionSort(a);
        isOrdered(a);
        assertNull(SortComparison.selectionSort(d));
        assertEquals(c, SortComparison.selectionSort(c));
    }
}
