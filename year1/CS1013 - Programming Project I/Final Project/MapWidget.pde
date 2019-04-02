/*  @author: Jevgenijus Cistiakovas 25/03/2018
 *   MapWidget class is a widget that holds an instance of Unfolding map.
 *   MapWidget should be called from the main or the main PApplet should be passed to the constructor
 *   MapWidget extends Button directly and Widget indirectly and has redundant fields sch as label/widgetColour. They might be used in the future.
 *   It extends Button to fit into polymorphic handling of buttons in the screen class
 *
 *   Example of usage:
 *   MapWidget map = new MapWidget(this, 100, 100, 200, 200, "TCD, Dublin", color(255),color(200,200,0),fontForTextDisplay,EVENT_NULL,53.3438f,-6.2546f);  // TCD coordinates
 *   map.show();
 *   map.setLat(latitude);
 *   map.setLong(longitude);
 *
 *  Modifications:
 *    J.C. 28/03 - Added border for the map container
 */

final class MapWidget extends Button {

  private UnfoldingMap map;
  private float longitude;        //vertical  coordinate
  private float latitude;       // horizontal coordinate
  private float maxPanningDistance;
  private int defaultZoom, minZoom, maxZoom;
  private color markerColour;
  private AbstractMapProvider provider;
  private processing.core.PApplet p;
  private int borderSize;

  MapWidget(processing.core.PApplet p, int x, int y, int width, int height, String label, color widgetColor, color labelColor, PFont font, int event) { 
    this(p, x, y, width, height, label, widgetColor, labelColor, font, event, 30.0f, 31.0f);
  }

  MapWidget(processing.core.PApplet p, int x, int y, int width, int height, String label, color widgetColor, color labelColor, PFont font, int event, float latitude, float longitude) { 
    super(x, y, label, widgetColor, labelColor, height, width, font, event);
    this.longitude = longitude;
    this.latitude = latitude;
    this.provider = new OpenStreetMap.OpenStreetMapProvider();
    this.p = p;
    this.defaultZoom = 17;
    this.minZoom = 7;
    this.maxZoom = 20;
    this.maxPanningDistance = 1; //in km
    this.markerColour = color(255, 0, 0, 200);
    this.borderSize = 2;
    setUpMap();
  }


  // a standard draw() method, but named as show() to make it work polymorphically
  void show() {
    stroke(getWidgetColor());
    strokeWeight(borderSize);
    fill(255);
    rect(getX(),getY(), getWidgetWidth(), getWidgetHeight());
    map.draw();
    // draw a label underneath the map, be aware - label is drawn below the specified height
    strokeWeight(1);
    noStroke();
    fill(getTextColor());
    textFont(getFont(), 20);    //harcoded size, add setter?
    textAlign(CENTER, BOTTOM);
    text(getWidgetText(), getX() + 0.23*textWidth(getWidgetText()), getY() + getWidgetHeight() + 2*textAscent());
    //println(height - getX() + 0.23*textWidth(getWidgetText()));
  }

  private void setUpMap() {
    map = new UnfoldingMap(p, "map", getX(), getY(), getWidgetWidth(), getWidgetHeight(), true, false, provider);
    Location location = new Location(latitude, longitude);
    map.zoomAndPanTo(location,defaultZoom);
    map.setPanningRestriction(location, maxPanningDistance);
    map.setZoomRange(minZoom, maxZoom);
    SimplePointMarker marker = new SimplePointMarker(location);
    marker.setColor(markerColour);
    map.addMarker(marker);
    MapUtils.createDefaultEventDispatcher(p, map);
  }


  void setLong(float longitude) {
    this.longitude = longitude;
    setUpMap();
  }

  void setLat(float latitude) {
    this.latitude = latitude;
    setUpMap();
  }

  float getMaxPanningDistance() {
    return maxPanningDistance;
  }
  void setMaxPanningDistance(float maxPanningDistance) {
    if (maxPanningDistance >= 0) {
      this.maxPanningDistance = maxPanningDistance;
    }
  }
  int getDefaultZoom() {
    return defaultZoom;
  }
  void setDefaultZoom(int defaultZoom) {
    if (defaultZoom >= 0) {
      this.defaultZoom = defaultZoom;
    }
  }
  int getMinZoom() {
    return minZoom;
  }
  void setMinZoom(int minZoom) {
    if (minZoom >= 0) {
      this.minZoom = minZoom;
    }
  }
  int getMaxZoom() {
    return maxZoom;
  }
  void setMaxZoom(int maxZoom) {
    if (maxZoom >= 0) {
      this.maxZoom = maxZoom;
    }
  }
  color getMarkerColour() {
    return markerColour;
  }
  void setMarkerColour(color markerColour) {
    this.markerColour = markerColour;
  }
  void setProvider(AbstractMapProvider provider) {//potentially might break the code
    this.provider = provider;
  }
  
  void setBorderSize(int borderSize){
    this.borderSize = borderSize;
  }
  
  int getBorderSize(){
    return this.borderSize;
  }
}