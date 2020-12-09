class Selector {
  int lx,ly;
  PShape cursor;
 Selector(int newx, int newy) {
   lx=newx;
   ly=newy;
 }
 
 public boolean isOccupied() {
   for(int i=0;i<puc;i++) {
     if(this.lx == playoccu[i][1] && this.ly == playoccu[i][2]) {
       return true;
     }
   }
   for(int i=0;i<euc;i++) {
     if(this.lx == occupied[i][0] && this.ly == occupied[i][1]) {
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
public boolean distanceFrom(int n, int s, int m) { //provide as current location x, current location y, and movement of a unit.
//intended as a check that wherever the cursor is, the unit can actually move that far
  int i = 0, x = this.lx, y = this.ly;  //an iterator, the current location of the cursor in x and y
  while(i< m && (n!=x || s!=y)) { //if the iteration is less than the move distance, and we haven't yet reached the unit location from the cursor
     if(x<n && i<m) { //should it be to the left
       x+=50; //^ also includes this security check for perfect diagonals
       i++;
     }
     if(x>n && i<m) { //should it be to the right
      x-=50; 
      i++;
     }
     if(y<s && i<m) { //should it be above
      y+=50; 
      i++;
     }
     if(y>s && i<m) { //should it be beneath
      y-=50; 
      i++;
     }
    //iterates on each if rather than the end because that's how movement works in this game
  }
  if(x!=n || y!=s) { //if either of these isn't there yet, check fails
   return false; 
  }
  else {//if both are in position and range, check passes
    return true;
  }
}

public void Display() {
  strokeWeight(5);
  stroke(230,230,0);
  noFill();
  rect(this.lx, this.ly, 50,50);
}
public void displayForMenu() {
  strokeWeight(2);
  stroke(0);
  fill(230,230,0);
  triangle(this.lx, this.ly, this.lx, this.ly+30, this.lx+10, this.ly+15);
}
}
