class Map {
  float x,y,w,h,t;
  
  Map(float tempx, float tempy, float tempw, float temph, float tempt) {
    x = tempx;
    y = tempy;
    w = tempw;
    h = temph;
    t = tempt;
  }
  
  void lineDisplay() { //purely for consistency on ONE frame :(
    stroke(0);
    rect(x,y,w,h);
  }
  
  void associate(int typ) { //for associating all of the map tiles with a tile class, such as forest, fort, or plain
   this.t = typ;
  }
  void fullDisplay() { //for redrawing on all frames
    stroke(0);
    if(t == 0) {
      rect(x,y,w,h);
      fill(40,180,40);
    }
    else if(t == 1) {
      rect(x,y,w,h);
      fill(198,201,111);
    }
    else if(t == 2) {
      rect(x,y,w,h);
      fill(37,66,36);
    }
  }
}
