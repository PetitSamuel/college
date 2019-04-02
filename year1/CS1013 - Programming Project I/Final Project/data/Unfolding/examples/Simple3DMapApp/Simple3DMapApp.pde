import de.fhpotsdam.unfolding.*;
import de.fhpotsdam.unfolding.geo.*;
import de.fhpotsdam.unfolding.utils.*;

UnfoldingMap map;
float rotateX = 0.9f;
float rotateZ = (float) 0;
float rotateVelocityZ = 0.003f;

public void setup() {
  size(800, 800, P3D);

  map = new UnfoldingMap(this);
  map.zoomAndPanTo(13, new Location(51.5, -0.1));
  hint(ENABLE_DEPTH_TEST);
  hint(ENABLE_DEPTH_SORT);
}

public void draw() {
  background(40);

  translate(width / 2, height / 3, 0);
  rotateX(rotateX);
  rotateZ(rotateZ);
  translate(-map.getWidth() / 2, -map.getHeight() / 2);
  map.draw();
  
  // Dome at position of St. Paul's Cathedral
  ScreenPosition pos = map.getScreenPosition(new Location(51.513611, -0.098056));
  translate(pos.x, pos.y);
  fill(255, 0, 0, 100);
  noStroke();
  sphere(25);

  rotateZ += rotateVelocityZ;
}