//set variable for setup void graphics
//setup all pre-created/prerendered graphics and variables for generation
PImage plance, psword, paxe, pcav, parmor, parcher, pmage;
PImage elance, esword, eaxe, ecav, earmor, earcher, emage;
int r = 16; //set equal to double the height divided by 100
int c = 24; //set equal to double the width divided by 100
PShape name;
PFont f;
int holdx=0,holdy=0;
int tilePos[][] = new int[c][r];
int xtemp, ytemp;
gameMap grid[][] = new gameMap[c][r]; //new class used for replicating the map and drawing the grid
Selector cursor = new Selector(1000,600);
int puc = (int) Math.round(random(12)+8); //generate between 8 and 20 player units
int euc = (int) Math.round(random(15)+10); //generate between 10 and 25 enemy units
int tc = (int) Math.round(random(50)); // generate up to 50 forest tiles
int fc = (int) Math.round(random(20)); // generate up to 20 fort tiles
Unit plu[] = new Unit[puc];
Unit enu[] = new Unit[euc];

void setup() {
  size(1200,800);
  for(int i=0;i<c;i++) {
    for(int a=0;a<r;a++) {
      grid[i][a] = new gameMap(i*50,a*50,50,50, tilePos[i][a]); //initializing the grid display
    } 
  }
  for(int i=0;i<c;i++) {
   for(int z=0;z<r;z++) {
   tilePos[i][z] = -1;
   }
  }
  hint(ENABLE_STROKE_PURE);
  background(20, 97, 207);
  //load images
  f = createFont("SourceSansPro-Regular.otf", 20);
  textFont(f);
  name = loadShape("titletext.svg");
  plance = loadImage("plance.png");
  psword = loadImage("psword.png");
  paxe = loadImage("paxe.png");
  pcav = loadImage("pcav.png");
  parmor = loadImage("parmor.png");
  parcher = loadImage("parcher.png");
  pmage = loadImage("pmage.png");
  elance = loadImage("elance.png");
  esword = loadImage("esword.png");
  eaxe = loadImage("eaxe.png");
  ecav = loadImage("ecav.png");
  earmor = loadImage("earmor.png");
  earcher = loadImage("earcher.png");
  emage = loadImage("emage.png");

}

boolean title = true, menu = false, fight = false, about = false, hold = false, move = false,once = false;
void draw() {
  /*TODO:
  - Add Gameplay
  - Add combat
  - Add Menus/UI
  */
  
  //for the title screen to function
  if(title) {
    int subtitlex = (int) (width*.4);
    int namex = (int) (width*.85);
    int namey = (int) (height*.9);
    shape(name,width*0.28,300);
    type("by Jacob Rogers", namex, namey, 255);
    type("Press any button to continue!", subtitlex, 440, 255);
  }
  if(title && mousePressed || title && keyPressed) { //recognize "any button", then begin worldgen
    title = false;
    background(0);
    generateTiles();
    generateUnit();
    placeUnits();
  }
  if(!title) {
    for(int i=0;i<c;i++) {
      for(int a=0;a<r;a++) {
         grid[i][a].fullDisplay(); //refresh
      } 
    }
    for(int i=0;i<puc;i++) {
      plu[i].unitDraw();
    }
    for(int i=0;i<euc;i++) {
      enu[i].unitDraw();
    }
    cursor.Display();
  }
  if(keyPressed) { //moving the cursor when not in combat, and when a unit is not selected
    if(!hold) {
      hold = true;
      if(key == CODED) {
        if(keyCode == UP) {
          if(cursor.getY()-50 >=0) {
            cursor.setLocation(cursor.getX(), cursor.getY()-50);
          }
        }
        if(keyCode == LEFT) {
          if(cursor.getX()-50 >=0) {
            cursor.setLocation(cursor.getX()-50, cursor.getY());
          }
        }
        if(keyCode == DOWN) {
          if(cursor.getY()+50 <=height-50) {
            cursor.setLocation(cursor.getX(), cursor.getY()+50);
          }
        }
        if(keyCode == RIGHT) {
          if(cursor.getX()+50 <=width-50) {
            cursor.setLocation(cursor.getX()+50, cursor.getY());
          }
        }
      }
      if(key == 'z' && !move || key == 'Z' && !move) {
        move = true;
      }
      
      
    }
  }
  if(menu) {
        //add attack, info and wait buttons
        if(keyPressed) {
          if(key == 'x' || key == 'X') {
             menu = false;
             move = false;
             cursor.lx = holdx;
             cursor.ly = holdy;
          }
        }
      }
  if(move) {
    if(!once) {
      mvrt();
      once = true;
    }
        plu[unitfinder()].displayRange(holdx,holdy);
        
        if(keyPressed) {
          if(!hold) {
            if(key == 'x' || key == 'X') {
              move = false;
              once = false;
              cursor.lx = holdx;
              cursor.ly = holdy;
            }
            if(key == 'z' || key == 'Z') {
              menu = true;
              move = false;
              once = false;
            }
          }
        }
      }
  if(!keyPressed) {
   hold = false; 
  }
}

private int unitfinder() {
  int n = 0;
  //finds the specified unit
  for(int i=0;i<plu.length;i++) {
    if(plu[i].locx == cursor.lx && plu[i].locy == cursor.ly) {
      n = i;
    }
  }
  return n;
}
void mvrt() {
  //sets the return point for the cursor, and allows the movement range to remain static
  holdx=cursor.lx;
  holdy=cursor.ly;
}

void type(String w, int x, int y, int c) { //for easier typeface on screen
   text(w, x, y);
   fill(c);
}
void generateUnit() { //for making stats and classes for generated units
  //player unit cycle
  
  int classchooser;
  String unitclass="";
  for(int i=0;i<(int)puc;i++) {
     classchooser = (int)Math.round(random(6)+1);
     switch(classchooser) {
      case(1):
        unitclass="plance";
        plu[i] = new Unit(i, unitclass, (int) Math.round(random(45)+20) /*hp*/, (int) Math.round(random(25)+15)/*str or mag*/, (int) Math.round(random(35))/*speed*/, (int) Math.round(random(30)+10)/*skill*/, (int) Math.round(random(40)) /*luck*/, (int) Math.round(random(35)+5)/*defense*/, (int) Math.round(random(40))/*resistance*/, 5);
        break;
      case(2):
        unitclass="psword";
        plu[i] = new Unit(i, unitclass, (int) Math.round(random(45)+20) /*hp*/, (int) Math.round(random(30)+10)/*str or mag*/, (int) Math.round(random(30)+10)/*speed*/, (int) Math.round(random(25)+15)/*skill*/, (int) Math.round(random(40)) /*luck*/, (int) Math.round(random(40))/*defense*/, (int) Math.round(random(35)+5)/*resistance*/, 5);
        break;
      case(3):
        unitclass="paxe";
        plu[i] = new Unit(i, unitclass, (int) Math.round(random(45)+25) /*hp*/, (int) Math.round(random(20)+20)/*str or mag*/, (int) Math.round(random(30))/*speed*/, (int) Math.round(random(20))/*skill*/, (int) Math.round(random(40)) /*luck*/, (int) Math.round(random(20))/*defense*/, (int) Math.round(random(20))/*resistance*/, 5);
        break;
      case(4):
        unitclass="pcav";
        plu[i] = new Unit(i, unitclass, (int) Math.round(random(35)+20) /*hp*/, (int) Math.round(random(30)+10)/*str or mag*/, (int) Math.round(random(35)+5)/*speed*/, (int) Math.round(random(30))/*skill*/, (int) Math.round(random(40)) /*luck*/, (int) Math.round(random(30)+5)/*defense*/, (int) Math.round(random(40))/*resistance*/, 7);
        break;
      case(5):
        unitclass="parmor";
        plu[i] = new Unit(i, unitclass, (int) Math.round(random(45)+35) /*hp*/, (int) Math.round(random(30)+10)/*str or mag*/, (int) Math.round(random(20))/*speed*/, (int) Math.round(random(30))/*skill*/, (int) Math.round(random(40)) /*luck*/, (int) Math.round(random(25)+15)/*defense*/, (int) Math.round(random(20))/*resistance*/, 4);
        break;
      case(6):
        unitclass="parcher";
        plu[i] = new Unit(i, unitclass, (int) Math.round(random(30)+15) /*hp*/, (int) Math.round(random(35)+5)/*str or mag*/, (int) Math.round(random(35)+5)/*speed*/, (int) Math.round(random(35)+5)/*skill*/, (int) Math.round(random(40)) /*luck*/, (int) Math.round(random(30))/*defense*/, (int) Math.round(random(30)+10)/*resistance*/, 5);
        break;
      case(7):
        unitclass="pmage";
        plu[i] = new Unit(i, unitclass, (int) Math.round(random(35)+10) /*hp*/, (int) Math.round(random(35)+15)/*str or mag*/, (int) Math.round(random(40))/*speed*/, (int) Math.round(random(40))/*skill*/, (int) Math.round(random(40)) /*luck*/, (int) Math.round(random(20))/*defense*/, (int) Math.round(random(25)+15)/*resistance*/, 5);
       break;  
     }
  }
  //enemy unit cycle
  
  for(int i=0;i<(int)euc;i++) {
    classchooser = (int)Math.round(random(6)+1);
     switch(classchooser) {
      case(1):
        unitclass="elance";
        enu[i] = new Unit(i, unitclass, (int) Math.round(random(45)+20) /*hp*/, (int) Math.round(random(25)+15)/*str or mag*/, (int) Math.round(random(35))/*speed*/, (int) Math.round(random(30)+10)/*skill*/, (int) Math.round(random(40)) /*luck*/, (int) Math.round(random(35)+5)/*defense*/, (int) Math.round(random(40))/*resistance*/, 5);
        break;
      case(2):
        unitclass="esword";
        enu[i] = new Unit(i, unitclass, (int) Math.round(random(45)+20) /*hp*/, (int) Math.round(random(30)+10)/*str or mag*/, (int) Math.round(random(30)+10)/*speed*/, (int) Math.round(random(25)+15)/*skill*/, (int) Math.round(random(40)) /*luck*/, (int) Math.round(random(40))/*defense*/, (int) Math.round(random(35)+5)/*resistance*/, 5);
        break;
      case(3):
        unitclass="eaxe";
        enu[i] = new Unit(i, unitclass, (int) Math.round(random(45)+25) /*hp*/, (int) Math.round(random(20)+20)/*str or mag*/, (int) Math.round(random(30))/*speed*/, (int) Math.round(random(20))/*skill*/, (int) Math.round(random(40)) /*luck*/, (int) Math.round(random(20))/*defense*/, (int) Math.round(random(20))/*resistance*/, 5);
        break;
      case(4):
        unitclass="ecav";
        enu[i] = new Unit(i, unitclass, (int) Math.round(random(35)+20) /*hp*/, (int) Math.round(random(30)+10)/*str or mag*/, (int) Math.round(random(35)+5)/*speed*/, (int) Math.round(random(30))/*skill*/, (int) Math.round(random(40)) /*luck*/, (int) Math.round(random(30)+5)/*defense*/, (int) Math.round(random(40))/*resistance*/, 7);
        break;
      case(5):
        unitclass="earmor";
        enu[i] = new Unit(i, unitclass, (int) Math.round(random(45)+35) /*hp*/, (int) Math.round(random(30)+10)/*str or mag*/, (int) Math.round(random(20))/*speed*/, (int) Math.round(random(30))/*skill*/, (int) Math.round(random(40)) /*luck*/, (int) Math.round(random(25)+15)/*defense*/, (int) Math.round(random(20))/*resistance*/, 4);
        break;
      case(6):
        unitclass="earcher";
        enu[i] = new Unit(i, unitclass, (int) Math.round(random(30)+15) /*hp*/, (int) Math.round(random(35)+5)/*str or mag*/, (int) Math.round(random(35)+5)/*speed*/, (int) Math.round(random(35)+5)/*skill*/, (int) Math.round(random(40)) /*luck*/, (int) Math.round(random(30))/*defense*/, (int) Math.round(random(30)+10)/*resistance*/, 5);
        break;
      case(7):
        unitclass="emage";
        enu[i] = new Unit(i, unitclass, (int) Math.round(random(35)+10) /*hp*/, (int) Math.round(random(35)+15)/*str or mag*/, (int) Math.round(random(40))/*speed*/, (int) Math.round(random(40))/*skill*/, (int) Math.round(random(40)) /*luck*/, (int) Math.round(random(20))/*defense*/, (int) Math.round(random(25)+15)/*resistance*/, 5);
       break;  
     }
  }
}

void generateTiles() { // for generating the actual map of tiles
  randomSeed((long)random(100000000));
  for(int i=0;i<tc;i++) { //creates a list of forest tiles
    xtemp = (int) Math.round(random(c-1))*50;
    ytemp = (int) Math.round(random(r-1))*50;
    tilePos[xtemp/50][ytemp/50] = 2;
    fill(37,66,36);
    rect(xtemp,ytemp,50,50);
  }
  for(int i=0;i<fc;i++) { //creates a list of fort tiles
    xtemp = (int) Math.round(random(c-1))*50;
    ytemp = (int) Math.round(random(r-1))*50;
    tilePos[xtemp/50][ytemp/50] = 1;
    fill(198,201,111);
    rect(xtemp,ytemp,50,50);
  }
  for(int i=0;i<c;i++) { //ensures all remaining tiles are plains.
    for(int z=0;z<r;z++) {
      if(tilePos[i][z] == -1) {
        tilePos[i][z] = 0;
        rect(i*50,z*50,50,50);
        fill(40,180,40);
      }
    }
  }
  for(int i=0;i<c;i++) {
    for(int a=0;a<r;a++) {
       grid[i][a].associate(tilePos[i][a]); //calling association
    } 
  }
}
int occupied[][] = new int[euc][2];
int playoccu[][] = new int[puc][2];
void placeUnits() { //for generating the actual map of units
  int corner = (int) Math.round(random(3)+1);
  int ecornr = 1;
  int tempx = 0, tempy = 0;
  //randomly picks a start position for the player team, then places enemies opposite that corner
  if(corner == 1) {
    ecornr=4;
    tempx = 0; tempy = 0;
    for(int i=0;i<puc;i++) { //places the player team in an organized fashion within a certain zone, top left
       plu[i].setLocation(tempx,tempy);
       playoccu[i][0] = tempx;
       playoccu[i][1] = tempy;
       tempx+=100;
       if(tempx==500) {
         tempx=50;
         tempy+=50;
       }
      if(tempx==450) {
        tempx=0;
        tempy+=100;
      }
    }
  }
  else if(corner == 2) {
    ecornr = 3;
    tempx = width-50; tempy = 0;
    for(int i=0;i<puc;i++) { //top right
       plu[i].setLocation(tempx,tempy);
       playoccu[i][0] = tempx;
       playoccu[i][1] = tempy;
       tempx-=100;
       if(tempx==width-450) {
         tempx=width-100;
         tempy+=50;
       }
      if(tempx==width-500) {
        tempx=width-50;
        tempy+=50;
      }
    }
  }
  else if(corner == 3) {
    ecornr = 2;
    tempx = 0; tempy = height-50;
    for(int i=0;i<puc;i++) { //bottom left
       plu[i].setLocation(tempx,tempy);
       playoccu[i][0] = tempx;
       playoccu[i][1] = tempy;
       tempx+=100;
       if(tempx==500) {
         tempx=50;
         tempy-=50;
       }
      if(tempx==450) {
        tempx=0;
        tempy-=50;
      }
    }
  }
  else if(corner == 4) {
    ecornr = 1;
    tempx = width-50; tempy = height-50;
    for(int i=0;i<puc;i++) { //bottom right
       plu[i].setLocation(tempx,tempy);
       playoccu[i][0] = tempx;
       playoccu[i][1] = tempy;
       tempx-=100;
       if(tempx==width-450) {
         tempx=width-100;
         tempy-=50;
       }
      if(tempx==width-500) {
        tempx=width-50;
        tempy-=50;
      }
    }
  }
  boolean repeat = true;
  
  tempx = 0; tempy = 0;
  for(int i=0;i<euc;i++) { //places enemies randomly, but not occupying the player unit zone
  repeat = true;
    while(repeat) {
      if(ecornr==1) {
         tempx= (int)Math.round(random(c*.75));
         tempy= (int)Math.round(random(r*.75));
      }
      if(ecornr==2) {
         tempx= (int)Math.round(random(c*.75+c*.25));
         tempy= (int)Math.round(random(r*.75));
      }
      if(ecornr==3) {
         tempx= (int)Math.round(random(c*.75)); 
         tempy= (int)Math.round(random(r*.75+r*.25));
      }
      if(ecornr==4) {
         tempx= (int)Math.round(random(c*.75+c*.25)); 
         tempy= (int)Math.round(random(r*.75+r*.25));
      }
      
      if(occupied[i][0] == tempx && occupied[i][1] == tempy) {
        repeat = true;
      }
      else {
       repeat = false;
       occupied[i][0] = tempx;
       occupied[i][1] = tempy;
       enu[i].setLocation(tempx*50,tempy*50);
      }
    }
    for(int a=0;a<euc;a++) {
      for(int b=0;b<euc;b++) {
        if(occupied[b][0] == occupied[a][0] && b != a) {
          if(occupied[b][1] == occupied[a][1]) {
            if(ecornr==1) {
               tempx= (int)Math.round(random(c*.75));
               tempy= (int)Math.round(random(r*.75));
            }
            if(ecornr==2) {
               tempx= (int)Math.round(random(c*.75+c*.25));
               tempy= (int)Math.round(random(r*.75));
            }
            if(ecornr==3) {
               tempx= (int)Math.round(random(c*.75)); 
               tempy= (int)Math.round(random(r*.75+r*.25));
            }
            if(ecornr==4) {
               tempx= (int)Math.round(random(c*.75+c*.25)); 
               tempy= (int)Math.round(random(r*.75+r*.25));
            }
            enu[b].setLocation(tempx*50,tempy*50);
          }
        }
      }
    }
  }
  
}
