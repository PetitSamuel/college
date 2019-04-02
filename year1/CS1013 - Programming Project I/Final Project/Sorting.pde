import java.util.Collections;
/*  @author: Jevgenijus Cistiakovas,Shengyuan Liu
 *  07/03 19:00 created the sorting class that provides static methods for sorting an ArrayList based on some characteristics
 */

public static void sortByBusinessName(ArrayList<reviewInstance> dataBase) {
  Collections.sort(dataBase, new BusinessNameComparator());
}
public static void sortByBusinessId(ArrayList<reviewInstance> dataBase) {
  Collections.sort(dataBase, new BusinessIdComparator());
}
public static void sortByAuthorName(ArrayList<reviewInstance> dataBase)
{
  Collections.sort(dataBase, new AuthorNameComparator());
}
public static void sortByAuthorId(ArrayList<reviewInstance> dataBase)
{
  Collections.sort(dataBase, new AuthorIdComparator());
}
public static void sortByDate(ArrayList<reviewInstance> dataBase)
{
  Collections.sort(dataBase, new DateComparator());
}

public static void sortByMostRecentDate(ArrayList<reviewInstance> dataBase)
{
  Collections.sort(dataBase, new DateComparatorReverse());
}

public static void sortByYear(ArrayList<reviewInstance> dataBase) {
  Collections.sort(dataBase, new YearComparator());
}
public static void sortByStars(ArrayList<reviewInstance> dataBase)
{
  Collections.sort(dataBase, new StarsComparator());
}
public static void sortByUsefulness(ArrayList<reviewInstance> dataBase)
{
  Collections.sort(dataBase, new UsefulnessComparator());
}
public static void sortByFunny(ArrayList<reviewInstance> dataBase)
{
  Collections.sort(dataBase, new FunnyComparator());
}
public static void sortByCool(ArrayList<reviewInstance> dataBase)
{
  Collections.sort(dataBase, new CoolComparator());
}


//public static int[] getIndicesForName(){

//}