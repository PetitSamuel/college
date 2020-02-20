/*
  Author Samuel Petit : functions which converts a string into a date and a date into a string (using the required and wanted formats to display them).

*/
String convertStringToDateWithYear(Date inputDate)
{
  String date = null;
  SimpleDateFormat df = new SimpleDateFormat("dd MMM yyyy");
  try {
    date = df.format(inputDate);
  }
  catch (Exception ex ) {
    // System.out.println("Problem converting date to string");
  }
  return date;
}
String convertStringToDate(Date inputDate)
{
  String date = null;
  SimpleDateFormat df = new SimpleDateFormat("MMM");
  SimpleDateFormat df2 = new SimpleDateFormat("yyyy");  
  try {
    date = df.format(inputDate) + " " + df2.format(inputDate);
  }
  catch (Exception ex ) {
    //   System.out.println("Problem converting date to string");
  }
  return date;
}

//checks, when the user has clicked on the search bar, if the current text is the defaul text, if it is then erase it.
public void checkSearchBoxDisplayMessage() {
  if (searchBox.getText().trim().equals(DEFAULT_SEARCH_PROMPT)) searchBox.widgetText = "";
}