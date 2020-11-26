class gameMap {
  private float x,y,w,h;
  private int t;
  
  gameMap(float tempx, float tempy, float tempw, float temph, int tempt) { //simple constructor for location, size, and terrain type
    x = tempx;
    y = tempy;
    w = tempw;
    h = temph;
    t = tempt;
  }
  
  public void associate(int typ) { //for associating all of the map tiles with a tile class, such as forest, fort, or plain
   this.t = typ;
  }
  
  public void fullDisplay() { //for redrawing on all frames
    stroke(0);
    if(t == 0) {
      fill(40,180,40);
      rect(x,y,w,h);
    }
    else if(t == 1) {
      fill(198,201,111);
      rect(x,y,w,h);
    }
    else if(t == 2) {
      fill(37,66,36);
      rect(x,y,w,h);
    }
  }
}
