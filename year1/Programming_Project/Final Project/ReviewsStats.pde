/*  @author: Jevgenijus Cistiakovas
 * 08/03 20:00 created Business class to represent a single business. Will be used to represent businesses on business page as well as for accessing statistics
 * 11/03 15:00 added a getDateStats() function that returns HashMap with dates on which reviews were written and the number of reviews written on a specific date, 
 *              this is to be used when drawing a graph
 * 12/03 21:00 added new constructor that allows for passing of ArrayList with reviews as parameters
 *              Merged Business and Author classes together as they share the same functionality. Renamed the class to ReviewsStats to better reflect its purpose
 * 13/03 15/03  J.C. added functions to provide stats for graphs.
 */

import java.util.Calendar;
static class ReviewsStats {
  private ArrayList<reviewInstance> reviews;
  private final String name;
  private final String id;
  private double averageStars;
  private double averageCool;
  private double averageUseful;
  private double averageFunny;
  private double averageReviewLength;
  static final double DEFAULT = -10;
  private HashMap<String, Integer> dateStats;
  private ArrayList<Integer> starsStats;
  private ArrayList< Integer> coolStats;
  private ArrayList< Integer> usefulStats;
  private ArrayList< Integer> funnyStats;

  ReviewsStats(String name, String id) {
    this(name, id, new ArrayList<reviewInstance>());
  }

  ReviewsStats(String name, String id, ArrayList<reviewInstance> reviews) {
    this.name = name;
    this.id = id;
    this.reviews = reviews;
    this.averageStars = DEFAULT;
    this.averageCool = DEFAULT;
    this.averageUseful = DEFAULT;
    this.averageFunny = DEFAULT;
    this.averageReviewLength = DEFAULT;
    dateStats = new HashMap<String, Integer>();
    starsStats = new ArrayList< Integer>();
    coolStats = new ArrayList< Integer>();
    usefulStats = new ArrayList< Integer>();
    funnyStats = new ArrayList< Integer>();
  }

  ArrayList<reviewInstance> getReviews() {
    return reviews;
  }

  void addReview(reviewInstance review) {
    if (review != null) {
      reviews.add(review);
      this.averageStars = DEFAULT;
      this.averageCool = DEFAULT;
      this.averageUseful = DEFAULT;
      this.averageFunny = DEFAULT;
      dateStats.clear();
      starsStats.clear();
      coolStats.clear();
      usefulStats.clear();
      funnyStats.clear();
    }
  }

  String getId() {
    return id;
  }

  String getName() {
    return name;
  }

  int getNumberOfReviews() {
    return reviews.size();
  }

  double getAverageStars() {
    if (averageStars == DEFAULT) {
      double sum = 0;
      for (int i = 0; i < reviews.size(); i++) {
        sum+= reviews.get(i).getStars();
      }
      averageStars =  sum/reviews.size();
    }
    return this.averageStars;
  }

  double getAverageCool() {
    if (averageCool == DEFAULT) {
      double sum = 0;
      for (int i = 0; i < reviews.size(); i++) {
        sum+= reviews.get(i).getCool();
      }
      averageCool =  sum/reviews.size();
    }
    return averageCool;
  }

  double getAverageUseful() {
    double sum = 0;
    if (averageUseful == DEFAULT) {
      for (int i = 0; i < reviews.size(); i++) {
        sum+= reviews.get(i).getUseful();
      }
      averageUseful =  sum/reviews.size();
    }
    return averageUseful;
  }

  double getAverageFunny() {

    double sum = 0;
    if (averageFunny == DEFAULT) {
      for (int i = 0; i < reviews.size(); i++) {
        sum+= reviews.get(i).getFunny();
      }
      averageFunny = sum/reviews.size();
    }
    return averageFunny;
  }

  double getAverageReviewLength() {
    if (averageReviewLength == DEFAULT) {
      double sum =0;
      ArrayList<reviewInstance> reviews = getReviews();
      for (int i = 0; i < reviews.size(); i++) {
        sum += reviews.get(i).getText().length();
      }
      averageReviewLength = sum / reviews.size();
    }
    return averageReviewLength;
  }

  // returns a HashMap with each unique date when reviews were written as a key and number of reviews written on that day as a value.
  HashMap<String, Integer> getDateStats() {
    if (dateStats.size() == 0) {
      calculateDateStats();
    }
    return dateStats;
  }

  private void calculateDateStats() {
    for (int i = 0; i < reviews.size(); i++) {
      Date reviewDate = reviews.get(i).getDate();
      Integer occurences = dateStats.get(reviewDate);
      if (occurences == null) {
        dateStats.put(reviewDate.toString(), 1);
      } else {
        dateStats.put(reviewDate.toString(), occurences+1);
      }
    }
  }

  ArrayList<Integer> getMonthsStats() {
    ArrayList<Integer> stats = setUpList(12);
    Calendar cal = Calendar.getInstance();
    for (int i = 0; i < reviews.size(); i++) {
      Date date = reviews.get(i).getDate();
      cal.setTime(date);
      int month = cal.get(Calendar.MONTH);
      if (month >= 0 && month < stats.size()) {
        stats.set(month, stats.get(month)+1);
      }
    }
    return stats;
  }

  // stars are 0-indexed, i.e. 1 star is at index 0, 5 stars at index 4
  ArrayList<Integer> getStarsStats() {
    ArrayList<Integer> stats = setUpList(5);
    for (int i = 0; i < reviews.size(); i++) {
      int noOfStars = reviews.get(i).getStars();
      if (noOfStars >= 0 && noOfStars - 1 < stats.size()) {
        stats.set(noOfStars-1, stats.get(noOfStars-1)+1);
      }
    }
    return stats;
  }

  private ArrayList<Integer> setUpList(int size) {
    ArrayList<Integer> list = new ArrayList<Integer>();
    for (int i = 0; i < size; i++) {
      list.add(0);
    }
    return list;
  }

  ArrayList<ArrayList<Integer>> getYearChangeStats(int scaleX, int scaleY) {
    ArrayList<ArrayList<Integer>> list = new ArrayList<ArrayList<Integer>>();
    for (int y = 2007; y <= 2017; y++) {
      list.add(new ArrayList<Integer>());
      list.get(y-2007).add(y);
      ArrayList<reviewInstance> yearReviews = getReviewsByYear(y, reviews);
      ReviewsStats stats = new ReviewsStats("", "", yearReviews);
      int averageStarsInYear = (int)(stats.getAverageStars()*scaleX);        // use scale factor of 10
      list.get(y-2007).add(averageStarsInYear);
    }
    return list;
  }
}