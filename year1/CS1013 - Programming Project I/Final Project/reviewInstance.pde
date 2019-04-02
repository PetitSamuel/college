/*
  Author :  David Hooban and Samuel Petit  : gets information & creates an object that contains that information.
*/

import java.text.SimpleDateFormat;
import java.util.Date;
static class reviewInstance
{
  private String user_id;
  private String user_name;
  private String business_id;
  private String business_name;
  private int stars;
  private Date date;
  private String text;
  private int useful;
  private int funny;
  private int cool;
  private int b_reviews_count;
  private int u_reviews_count;
  private String b_categories;
  private boolean b_open;  
  private double longitude;
  private double latitude;
  private String address;
  private String [] hours;
  

  //            map.put(i, new reviewInstance(u_id, u_name, b_id, b_name, text, date, stars, useful, funny, cool));
  reviewInstance(String user_id, String user_name, String business_id, String business_name, String text, String dateReviewPosted, int stars, int useful, int funny, int cool)
  {   
    SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");
    Date birthDate = null;
    try {
      birthDate = formatter.parse(dateReviewPosted);
    } 
    catch (Exception e) {
      e.printStackTrace();
    }
    this.user_id = user_id;
    this.user_name = user_name;
    this.business_id = business_id;
    this.business_name = business_name;
    this.stars = stars;
    this.date = birthDate;
    this.text = text;
    this.useful = useful;
    this.funny = funny;
    this.cool = cool;
    this.u_reviews_count = 0;
    this.b_reviews_count = 0;
    this.b_categories = "";
    this.b_open = false;  
    this.longitude = 0.0;
    this.latitude = 0.0;
    this.address = ""; 
    this.hours = null;
  }
  reviewInstance(String user_id, String business_id, String text, String dateReviewPosted, int stars, int useful, int funny, int cool)
  {   
    SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
    Date birthDate = null;
    try {
      birthDate = formatter.parse(dateReviewPosted);
    } 
    catch (Exception e) {
      e.printStackTrace();
    }
    this.user_id = user_id;
    this.user_name = "username";
    this.business_id = business_id;
    this.business_name = "business name";
    this.stars = stars;
    this.date = birthDate;
    this.text = text;
    this.useful = useful;
    this.funny = funny;
    this.cool = cool;
    this.u_reviews_count = 0;
    this.b_reviews_count = 0;
    this.b_categories = "";
    this.b_open = false;  
    this.longitude = 0.0;
    this.latitude = 0.0;
    this.address = ""; 
    this.hours = null;
  }  
  public String getUser_id() {
    return user_id;
  }
  public String getUser_name() {
    return user_name;
  }
  public String getBusiness_id() {
    return business_id;
  }
  public String getBusiness_name() {
    return business_name;
  }
  public int getStars() {
    return stars;
  }
  public Date getDate() {
    return date;
  }
  public String getText() {
    return text;
  }
  public int getUseful() {
    return useful;
  }
  public int getFunny() {
    return funny;
  }
  public int getCool() {
    return cool;
  }
      public int getB_reviews_count() {
        return b_reviews_count;
    }

    public int getU_reviews_count() {
        return u_reviews_count;
    }

    public String getB_categories() {
        return b_categories;
    }

    public boolean isB_open() {
        return b_open;
    }

    public double getLongitude() {
        return longitude;
    }

    public double getLatitude() {
        return latitude;
    }

    public String getAddress() {
        return address;
    }
    
    public void setUser_id(String user_id) {
        this.user_id = user_id;
    }

    public void setUser_name(String user_name) {
        this.user_name = user_name;
    }

    public void setBusiness_id(String business_id) {
        this.business_id = business_id;
    }

    public void setBusiness_name(String business_name) {
        this.business_name = business_name;
    }

    public void setStars(int stars) {
        this.stars = stars;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    public void setText(String text) {
        this.text = text;
    }

    public void setUseful(int useful) {
        this.useful = useful;
    }

    public void setFunny(int funny) {
        this.funny = funny;
    }

    public void setCool(int cool) {
        this.cool = cool;
    }

    public void setB_reviews_count(int b_reviews_count) {
        this.b_reviews_count = b_reviews_count;
    }

    public void setU_reviews_count(int u_reviews_count) {
        this.u_reviews_count = u_reviews_count;
    }

    public void setB_categories(String b_categories) {
        this.b_categories = b_categories;
    }

    public void setB_open(boolean b_open) {
        this.b_open = b_open;
    }

    public void setLongitude(double longitude) {
        this.longitude = longitude;
    }

    public void setLatitude(double latitude) {
        this.latitude = latitude;
    }

    public void setAddress(String address) {
        this.address = address;
    }

  void setNames(String uname, String bname) {
    this.user_name = uname; 
    this.business_name = bname;
  }
  void setReviewsCount(int bcount, int ucount) {
    this.u_reviews_count = ucount;
    this.b_reviews_count = bcount;
  }
      public String[] getHours() {
        return hours;
    }

    public void setHours(String[] hours) {
        this.hours = hours;
    }
  void setExtraInfo(String cat, boolean open, double longitude, double latitude, String state, String city, String address){
    /*
 
    this.state = "";
    this.city = "";
    this.address = ""; 
    */
    this.b_open = open;
    this.b_categories = cat;
    this.longitude = longitude;
    this.latitude = latitude;
    this.address = address +", " + city + " " + state;
    
    println("open : " + open + "categories : " + this.b_categories + " long" + this.longitude + "lat " + this.latitude + "address : " + this.address);
  }

  @Override
    public String toString() {
    return "Reviews{" +
      "user_id='" + user_id + '\'' +
      ", user_name='" + user_name + '\'' +
      ", business_id='" + business_id + '\'' +
      ", business_name='" + business_name + '\'' +
      ", stars=" + stars +
      ", date='" + date + '\'' +
      ", text='" + text + '\'' +
      ", useful=" + useful +
      ", funny=" + funny +
      ", cool=" + cool +
      '}';
  }
}