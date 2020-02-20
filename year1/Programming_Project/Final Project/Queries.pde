import java.util.Map;
/*@author Jevgenijus Cistiakovas 
 *  06/03 19:00 created Queries file containing different queries
 *
 *  07/03 14:00 added new queries, 19:00 fixed typos, incorrect method calls
 *  15/03 11:00 J.C. changed implemetaation of queries to use simple linear search, as it is the fastest method. Binary search requires sorting beforehand and previous implementation
 *               had to do sorting during each query call, which was very inefficient.#
 *  22/03       J.Cistiakovas added a query that returns the recommended names for searching
 *  01/04 11:30 J.Cistiakovas - added a query that returns the recommended names for searching from the MySQL database rather than local list
 */

public static ArrayList<reviewInstance> getAuthorsReviews(String reviewerName, ArrayList<reviewInstance> dataBase) {
  ArrayList<reviewInstance> reviewsOfBusiness = new ArrayList<reviewInstance>();
  // perhaps change class to static, check if creating main_project will output something
  reviewInstance sampleInstance = new reviewInstance("", reviewerName, "", "", "", "01/01/2000", 0, 0, 0, 0);
  for (int i = 0; i < dataBase.size(); i++) {
    reviewInstance nextItem = dataBase.get(i);
    if (new AuthorNameComparator().compare(sampleInstance, nextItem) == 0) {
      reviewsOfBusiness.add(nextItem);
    }
  }
  return reviewsOfBusiness;
}

public static ArrayList<reviewInstance> getAuthorsReviewsById(String reviewerId, ArrayList<reviewInstance> dataBase) {
  ArrayList<reviewInstance> reviewsOfBusiness = new ArrayList<reviewInstance>();
  reviewInstance sampleInstance = new reviewInstance(reviewerId, "", "", "", "", "01/01/2000", 0, 0, 0, 0);
  for (int i = 0; i < dataBase.size(); i++) {
    reviewInstance nextItem = dataBase.get(i);
    if (new AuthorIdComparator().compare(sampleInstance, nextItem) == 0) {
      reviewsOfBusiness.add(nextItem);
    }
  }
  return reviewsOfBusiness;
}

public static ArrayList<String> getSuggestionsBusiness(String input, MySQL dataBase){
  ArrayList<String> suggestions = new ArrayList<String>();
  String query = "SELECT name FROM yelp_business WHERE name LIKE '" + input +"%' ORDER BY name LIKE '"+input +"' DESC LIMIT 5;"; 
  dataBase.query(query);
  while(dataBase.next()){
    String name = dataBase.getString("name");
    suggestions.add(name); 
  }
  return suggestions;
}

public static ArrayList<String> getSuggestionsStrings(String input, ArrayList<reviewInstance> dataBase) {
  ArrayList<String> reviewsOfBusiness = new ArrayList<String>();
  HashMap<String, String> namesMap = new HashMap<String, String>();
  reviewInstance sampleInstance = new reviewInstance("", input, "", input, "", "01/01/2000", 0, 0, 0, 0);
  for (int i = 0; i < dataBase.size(); i++) {
    reviewInstance nextItem = dataBase.get(i);
    if (new AuthorNameSuggestionComparator().compare(sampleInstance, nextItem) == 0) {

      String name = nextItem.getUser_name();
      String mapName = namesMap.get(name);
      if (mapName==null) {
        namesMap.put(name, name);
        println(name);
      }
    } else if (new BusinessNameSuggestionComparator().compare(sampleInstance, nextItem) == 0) {
      String name = nextItem.getBusiness_name();
      String mapName = namesMap.get(name);
      if (mapName==null) {
        namesMap.put(name, name);
        println(name);
      }
    }
  }
  reviewsOfBusiness = new ArrayList<String>(namesMap.values());
  return reviewsOfBusiness;
}

public static ArrayList<reviewInstance> getSuggestions(String input, ArrayList<reviewInstance> dataBase) {
  ArrayList<reviewInstance> reviewsOfBusiness = new ArrayList<reviewInstance>();
  reviewInstance sampleInstance = new reviewInstance("", input, "", input, "", "01/01/2000", 0, 0, 0, 0);
  for (int i = 0; i < dataBase.size(); i++) {
    reviewInstance nextItem = dataBase.get(i);
    if (new AuthorNameSuggestionComparator().compare(sampleInstance, nextItem) == 0) {
      reviewsOfBusiness.add(nextItem);
    } else if (new BusinessNameSuggestionComparator().compare(sampleInstance, nextItem) == 0) {
      reviewsOfBusiness.add(nextItem);
    }
  }
  return reviewsOfBusiness;
}
public static ArrayList<reviewInstance> getAuthorReviewsSuggestion(String startingOfName, ArrayList<reviewInstance> dataBase) {
  ArrayList<reviewInstance> reviewsOfBusiness = new ArrayList<reviewInstance>();
  // perhaps change class to static, check if creating main_project will output something
  reviewInstance sampleInstance = new reviewInstance("", startingOfName, "", "", "", "01/01/2000", 0, 0, 0, 0);
  for (int i = 0; i < dataBase.size(); i++) {
    reviewInstance nextItem = dataBase.get(i);
    if (new AuthorNameSuggestionComparator().compare(sampleInstance, nextItem) == 0) {
      reviewsOfBusiness.add(nextItem);
    }
  }
  return reviewsOfBusiness;
}

public static ArrayList<reviewInstance> getBusinessReviews(String businessName, ArrayList<reviewInstance> dataBase) {
  ArrayList<reviewInstance> reviewsOfBusiness = new ArrayList<reviewInstance>();
  reviewInstance sampleInstance = new reviewInstance("", "", "", businessName, "", "01/01/2000", 0, 0, 0, 0);
  for (int i = 0; i < dataBase.size(); i++) {
    reviewInstance nextItem = dataBase.get(i);
    if (new BusinessNameComparator().compare(sampleInstance, nextItem) == 0) {
      reviewsOfBusiness.add(nextItem);
    }
  }
  return reviewsOfBusiness;
}

public static ArrayList<reviewInstance> getBusinessReviewsById(String businessId, ArrayList<reviewInstance> dataBase) {
  ArrayList<reviewInstance> reviewsOfBusiness = new ArrayList<reviewInstance>();
  reviewInstance sampleInstance = new reviewInstance("", "", businessId, "", "", "01/01/2000", 0, 0, 0, 0);
  for (int i = 0; i < dataBase.size(); i++) {
    reviewInstance nextItem = dataBase.get(i);
    if (new BusinessIdComparator().compare(sampleInstance, nextItem) == 0) {
      reviewsOfBusiness.add(nextItem);
    }
  }
  return reviewsOfBusiness;
}

public static ArrayList<reviewInstance> getBusinessReviewsSuggestion(String businessName, ArrayList<reviewInstance> dataBase) {
  ArrayList<reviewInstance> reviewsOfBusiness = new ArrayList<reviewInstance>();
  reviewInstance sampleInstance = new reviewInstance("", "", "", businessName, "", "01/01/2000", 0, 0, 0, 0);
  for (int i = 0; i < dataBase.size(); i++) {
    reviewInstance nextItem = dataBase.get(i);
    if (new BusinessNameSuggestionComparator().compare(sampleInstance, nextItem) == 0) {
      reviewsOfBusiness.add(nextItem);
    }
  }
  return reviewsOfBusiness;
}

public static ArrayList<reviewInstance> getReviewsByStars(int noOfStars, ArrayList<reviewInstance> dataBase) {
  ArrayList<reviewInstance> starsReviews = new ArrayList<reviewInstance>();
  reviewInstance sampleInstance = new reviewInstance("", "", "", "", "", "01/01/2000", noOfStars, 0, 0, 0);
  for (int i = 0; i < dataBase.size(); i++) {
    reviewInstance nextItem = dataBase.get(i);
    if (new StarsComparator().compare(sampleInstance, nextItem) == 0) {
      starsReviews.add(nextItem);
    }
  }
  return starsReviews;
}

public static ArrayList<reviewInstance> getReviewsAboveStars(int minNoOfStars, ArrayList<reviewInstance> dataBase) {
  ArrayList<reviewInstance> starsReviews = new ArrayList<reviewInstance>();
  // perhaps change class to static, check if creating main_project will output something
  reviewInstance sampleInstance = new reviewInstance("", "", "", "", "", "01/01/2000", minNoOfStars, 0, 0, 0);
  for (int i = 0; i < dataBase.size(); i++) {
    reviewInstance nextItem = dataBase.get(i);
    if (new StarsComparator().compare(nextItem, sampleInstance) >= 0) {
      starsReviews.add(nextItem);
    }
  }
  return starsReviews;
}


public static ArrayList<reviewInstance> getReviewsByUsefulness(int usefulnessScore, ArrayList<reviewInstance> dataBase) {
  ArrayList<reviewInstance> usefulReviews = new ArrayList<reviewInstance>();
  reviewInstance sampleInstance = new reviewInstance("", "", "", "", "", "01/01/2000", 0, usefulnessScore, 0, 0);
  for (int i = 0; i < dataBase.size(); i++) {
    reviewInstance nextItem = dataBase.get(i);
    if (new UsefulnessComparator().compare(nextItem, sampleInstance) == 0) {
      usefulReviews.add(nextItem);
    }
  }
  return usefulReviews;
}

public static ArrayList<reviewInstance> getReviewsByFunnyness(int funnynessScore, ArrayList<reviewInstance> dataBase) {
  ArrayList<reviewInstance> funnyReviews = new ArrayList<reviewInstance>();
  reviewInstance sampleInstance = new reviewInstance("", "", "", "", "", "01/01/2000", 0, 0, funnynessScore, 0);
  for (int i = 0; i < dataBase.size(); i++) {
    reviewInstance nextItem = dataBase.get(i);
    if (new FunnyComparator().compare(nextItem, sampleInstance) == 0) {
      funnyReviews.add(nextItem);
    }
  }
  return funnyReviews;
}

public static ArrayList<reviewInstance> getReviewsByCoolness(int coolnessScore, ArrayList<reviewInstance> dataBase) {
  ArrayList<reviewInstance> coolReviews = new ArrayList<reviewInstance>();
  reviewInstance sampleInstance = new reviewInstance("", "", "", "", "", "01/01/2000", 0, 0, 0, coolnessScore);
  for (int i = 0; i < dataBase.size(); i++) {
    reviewInstance nextItem = dataBase.get(i);
    if (new CoolComparator().compare(nextItem, sampleInstance) == 0) {
      coolReviews.add(nextItem);
    }
  }
  return coolReviews;
}

public static ArrayList<reviewInstance> getReviewsByDate(Date date, ArrayList<reviewInstance> dataBase) {
  ArrayList<reviewInstance> dateReviews = new ArrayList<reviewInstance>();
  SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");
  reviewInstance sampleInstance = new reviewInstance("", "", "", "", "", formatter.format(date), 0, 0, 0, 0);
  for (int i = 0; i < dataBase.size(); i++) {
    reviewInstance nextItem = dataBase.get(i);
    if (new DateComparator().compare(nextItem, sampleInstance) == 0) {
      dateReviews.add(nextItem);
    }
  }
  return dateReviews;
}


public static ArrayList<reviewInstance> getReviewsByDate(Date smallerDate, Date largerDate, ArrayList<reviewInstance> dataBase) {
  ArrayList<reviewInstance> dateReviews = new ArrayList<reviewInstance>();
  SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");
  reviewInstance sampleInstanceSmaller = new reviewInstance("", "", "", "", "", formatter.format(smallerDate), 0, 0, 0, 0);
  reviewInstance sampleInstanceLarger = new reviewInstance("", "", "", "", "", formatter.format(largerDate), 0, 0, 0, 0);
  for (int i = 0; i < dataBase.size(); i++) {
    reviewInstance nextItem = dataBase.get(i);
    if (new DateComparator().compare(nextItem, sampleInstanceSmaller) >= 0 && new DateComparator().compare(nextItem, sampleInstanceLarger) <= 0) {
      dateReviews.add(nextItem);
    }
  }
  return dateReviews;
}

public static ArrayList<reviewInstance> getReviewsByYear(int year, ArrayList<reviewInstance> dataBase) {
  ArrayList<reviewInstance> dateReviews = new ArrayList<reviewInstance>();
  try {
    SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");
    Date date = formatter.parse("21/12/"+year);
    reviewInstance sampleInstance = new reviewInstance("", "", "", "", "", formatter.format(date), 0, 0, 0, 0);
    for (int i = 0; i < dataBase.size(); i++) {
      reviewInstance nextItem = dataBase.get(i);
      if (new YearComparator().compare(nextItem, sampleInstance) == 0) {
        dateReviews.add(nextItem);
      }
    }
  } 
  catch (java.text.ParseException e) {
    e.printStackTrace();
  }
  return dateReviews;
}
public Date getOldestReviewDate(ArrayList <reviewInstance> dataBase) {
  Date oldestDate = null; 
  for (int i = 0; i < dataBase.size(); i++) {
    Date instanceDate = dataBase.get(i).getDate();
    if (oldestDate == null) {
      oldestDate = instanceDate;
    }
    if (instanceDate.compareTo(oldestDate) < 0) {
      oldestDate = instanceDate;
    }
  }

  return oldestDate;
}