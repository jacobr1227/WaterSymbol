class Selector {
  int lx,ly;
  PShape cursor;
 Selector(int newx, int newy) {
   lx=newx;
   ly=newy;
 }
 
 public boolean isOccupied() {
   for(int i=0;i<puc;i++) {
     if(this.lx/50 == playoccu[i][0] && this.ly/50 == playoccu[i][1]) {
       return true;
     }
   }
   for(int i=0;i<euc;i++) {
     if(this.lx/50 == occupied[i][0] && this.ly/50 == occupied[i][1]) {
       return true;
     }
   }
   return false;
 }
public void setLocation(int newx, int newy) {
  this.lx = newx;
  this.ly = newy;
}
public int getX() {
  return this.lx;
}
public int getY() {
  return this.ly;
}

public void Display() {
  strokeWeight(5);
  stroke(230,230,0);
  noFill();
  rect(this.lx, this.ly, 50,50);
}

public void displayRange() {
 noStroke();
 fill(255,0,0);
 
}
}
