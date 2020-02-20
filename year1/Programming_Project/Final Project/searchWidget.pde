/*  searchWidget class represents a box/widget in which a user can type in text. searchWidget is capable of displaying search suggestions
 *    beneath the search field. The user should be able to choose the suggestion.
 *
 */
// 14/03/2018    Shengyuan Liu create the class to build up the searchBox.
// 15/03 18:00 J.Cistiakovas - fixed searchWidget class. It had problems with not using getter/setters of super class.
// 22/03 J.Cistiakovas  - added a function that draws suggestion promts for the user, given that the user input is focused on the search widget
//                        added a function for interaction with the user. The user can select one of the suggested names.
// 26/03 J.Cistiakovas - added some documentation and null-pointer checks
class searchWidget extends Button//create the searchBox Widget
{
  String focused;
  int maxlen, event, maxNumberOfSuggestions;
  PFont widgetFont;
  String label;
  ArrayList<String> suggestions;

  searchWidget(int x, int y, int width, int height, 
    String label, color widgetColor, color labelColor, PFont font, int event, int
    maxlen) { 
    super(x, y, label, widgetColor, labelColor, height, width, font, event);
    this.focused=null;
    this.event=event;
    this.maxlen=maxlen;
    this.maxNumberOfSuggestions = 5;
  }

  void show() {
    noStroke();
    if (getFocus()) {
      fill(255);
    } else {
      fill(getWidgetColor());
    }
    rectMode(CORNER);
    strokeWeight(1);
    stroke(200);
    rect(getX(), getY(), getWidgetWidth(), getWidgetHeight());
    fill(getTextColor());
    textFont(getFont(), 20);
    textAlign(LEFT, TOP);
    rectMode(CORNER);
    text(widgetText + (getFocus() ? "|":""), getX()+10, getY()+10);
    if (getFocus()) {
      //      println("draw suggestions");
      drawSuggestions();
      //setSuggestionClicked(mouseX, mouseY);
    }
  }

  void drawSuggestions() {
    if (suggestions != null) {
      int numberToShow = 0;
      if (suggestions.size() > maxNumberOfSuggestions) {
        numberToShow = maxNumberOfSuggestions;
      } else {
        numberToShow = suggestions.size();
      }
      if (numberToShow != 0) {
        for (int i = 0; i < numberToShow; i++) {
          String suggestedName = suggestions.get(i);
          fill(getWidgetColor(), 200);
          stroke(1);
          float x = searchBox.getX();
          float y =  searchBox.getY()+(i+1)*searchBox.getWidgetHeight();
          float width = searchBox.getWidgetWidth();
          float height = searchBox.getWidgetHeight();
          //rect(searchBox.getX(), searchBox.getY()+(i+1)*searchBox.getWidgetHeight(), searchBox.getWidgetWidth(), searchBox.getWidgetHeight());
          rect(x, y, width, height);
          fill(getTextColor(), 200);
          text(suggestedName, x+10, y+10, width, height);
        }
      }
    }
  }


  void setSuggestionClicked(int mX, int mY) {
    if (suggestions != null && getFocus()) {
      int numberToShow = 0;
      if (suggestions.size() > 5) {
        numberToShow = 5;
      } else {
        numberToShow = suggestions.size();
      }
      for (int i = 0; i < numberToShow; i++) {
        float x = searchBox.getX();
        float y =  searchBox.getY()+(i+1)*searchBox.getWidgetHeight();
        float width = searchBox.getWidgetWidth();
        float height = searchBox.getWidgetHeight();
        if (mX > x && mX < x + width && mY > y && mY < y + height) {
          setText(suggestions.get(i));
          setFocus(false);
          processSearch();          // TODO: move it to main?
        }
      }
    }
  }

  void setSuggestions(ArrayList<String> suggestions) {
    if (suggestions != null) {
      this.suggestions = suggestions;
    }
  }

  void clearSuggestions() {
    this.suggestions = null;
  }

  void append(char s) {
    if (s==BACKSPACE) {
      if (!getWidgetText().equals(""))
        setWidgetText(getWidgetText().substring(0, getWidgetText().length()-1));
    } else if (getWidgetText().length() <maxlen && getWidgetText().length()==0) {
      setWidgetText(str(s).toUpperCase());
    } else if (getWidgetText().length() <maxlen)
      setWidgetText(getWidgetText()+str(s));
  }

  void setText(String text) {
    if (text != null) {
      setWidgetText(text);
    }
  }


  String getText() {
    return getWidgetText();
  }

  void setMaxNumberOfSuggestions(int maxNumberOfSuggestions) {
    if (maxNumberOfSuggestions >= 0) {
      this.maxNumberOfSuggestions = maxNumberOfSuggestions;
    }
  }
}