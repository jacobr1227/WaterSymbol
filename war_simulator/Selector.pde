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
public int distanceFrom(int n, int s, int m) {
  int i = 0, x = this.lx/50, y = this.ly/50;
  n/=50;
  s/=50;
  while(i< m && n!=x && s!=y) {
     if(x<n) {
       x++;
     }
     if(x>n) {
      x--; 
     }
     if(y<s) {
      y++; 
     }
     if(y>s) {
      y--; 
     }
     i++;
  }
  if(x!=n || y!=s) {
   return i+1; 
  }
  else {
    return i;
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
