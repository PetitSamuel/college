import java.util.Comparator;

/*@author Jevgenijus Cistiakovas 
 *  06/03 19:00 created Comparator files containing multiple comparators for future sorting
 *  07/07 13:00 added more comparators: dateComparator, businessNameComparator... Made the classes static, so that they don't have to be associated with an instance of the main class
 *  31/03 21:00 J.C - suggestion comparators now are case-insensitive
 */
// Comparators for the use with standard Collections method sort

/*
* returns positive if review1 has more stars than review2, negative if less, 0 if the same
 */

static class AuthorNameComparator implements Comparator<reviewInstance> {
  public int compare(reviewInstance firstReview, reviewInstance secondReview) {
    return firstReview.getUser_name().toLowerCase().compareTo(secondReview.getUser_name().toLowerCase());
  }
}

static class AuthorIdComparator implements Comparator<reviewInstance> {
  public int compare(reviewInstance firstReview, reviewInstance secondReview) {
    return firstReview.getUser_id().compareTo(secondReview.getUser_id());
  }
}

static class AuthorNameSuggestionComparator implements Comparator<reviewInstance> {
  public int compare(reviewInstance firstReview, reviewInstance secondReview) {
    String firstName= firstReview.getUser_name().toLowerCase();
    String secondName = secondReview.getUser_name().toLowerCase();
    if (firstName.length() > secondName.length()) {
      return firstName.substring(0, secondName.length()).toLowerCase().compareTo(secondName.toLowerCase());
    } else {
      return secondName.substring(0, firstName.length()).toLowerCase().compareTo(firstName.toLowerCase());
    }
  }
}

static class BusinessNameComparator implements Comparator<reviewInstance> {
  public int compare(reviewInstance firstReview, reviewInstance secondReview) {
    return firstReview.getBusiness_name().toLowerCase().compareTo(secondReview.getBusiness_name().toLowerCase());
  }
}


static class BusinessIdComparator implements Comparator<reviewInstance> {
  public int compare(reviewInstance firstReview, reviewInstance secondReview) {
    return firstReview.getBusiness_id().compareTo(secondReview.getBusiness_id());
  }
}

static class BusinessNameSuggestionComparator implements Comparator<reviewInstance> {
  public int compare(reviewInstance firstReview, reviewInstance secondReview) {
    String firstName= firstReview.getBusiness_name().toLowerCase();
    String secondName = secondReview.getBusiness_name().toLowerCase();
    if (firstName.length() > secondName.length()) {
      return firstName.substring(0, secondName.length()).toLowerCase().compareTo(secondName.toLowerCase());
    } else {
      return secondName.substring(0, firstName.length()).toLowerCase().compareTo(firstName.toLowerCase());
    }
  }
}

static class DateComparator implements Comparator<reviewInstance> {
  public int compare(reviewInstance firstReview, reviewInstance secondReview) {
    return firstReview.getDate().compareTo(secondReview.getDate());
  }
}

static class DateComparatorReverse implements Comparator<reviewInstance> {
  public int compare(reviewInstance firstReview, reviewInstance secondReview) {
    return secondReview.getDate().compareTo(firstReview.getDate());
  }
}

static class YearComparator implements Comparator<reviewInstance> {
  public int compare(reviewInstance firstReview, reviewInstance secondReview) {
    Calendar cal1 = Calendar.getInstance();
    Calendar cal2 = Calendar.getInstance();
    cal1.setTime(firstReview.getDate());
    cal2.setTime(secondReview.getDate());
    return cal1.get(Calendar.YEAR) -  cal2.get(Calendar.YEAR);
  }
}

static class StarsComparator implements Comparator<reviewInstance> {

  public int compare(reviewInstance firstReview, reviewInstance secondReview) {
    return secondReview.getStars() - firstReview.getStars();
  }
}

static class UsefulnessComparator implements Comparator<reviewInstance> {

  public int compare(reviewInstance firstReview, reviewInstance secondReview) {
    return secondReview.getUseful() - firstReview.getUseful();
  }
}

static class FunnyComparator implements Comparator<reviewInstance> {

  public int compare(reviewInstance firstReview, reviewInstance secondReview) {
    return secondReview.getFunny() - firstReview.getFunny();
  }
}

static class CoolComparator implements Comparator<reviewInstance> {

  public int compare(reviewInstance firstReview, reviewInstance secondReview) {
    return secondReview.getCool() - firstReview.getCool();
  }
}