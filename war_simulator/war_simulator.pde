//set variable for setup void graphics
PShape cursor;
//setup all pre-created/prerendered graphics and variables for generation
PImage plance, psword, paxe, pcav, parmor, parcher, pmage;
PImage elance, esword, eaxe, ecav, earmor, earcher, emage;
PShape name;
PFont f;
int tilePos[][] = new int[40][24];
int xtemp, ytemp;
int r = 24;
int c = 40;
gameMap grid[][] = new gameMap[40][24]; //new class used for replicating the map and drawing the grid
int puc = (int) Math.round(random(12)+5); //generate between 5 and 17 player units
int euc = (int) Math.round(random(15)+10); //generate between 10 and 25 enemy units
int tc = (int) Math.round(random(50)); // generate up to 50 forest tiles
int fc = (int) Math.round(random(20)); // generate up to 20 fort tiles
Unit plu[] = new Unit[puc];
Unit enu[] = new Unit[euc];

void setup() {
  size(2000,1200);
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
  f = createFont("SourceSansPro-Regular.otf", 16);
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
  //create the cursor shape
  cursor = createShape();
  cursor.beginShape();
  
  cursor.endShape(CLOSE);
}

boolean title = true;
void draw() {
  /*TODO:
  - Add Gameplay
  - Add combat
  - Add Menus/UI
  */
  
  //for the title screen to function
  if(title) {
    shape(name,width*0.37,300);
    type("by Jacob Rogers", 1820, 1140, 255);
    type("Press any button to continue!", 920, 440, 255);
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
  }
  
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
    xtemp = (int) Math.round(random(39))*50;
    ytemp = (int) Math.round(random(23))*50;
    tilePos[xtemp/50][ytemp/50] = 2;
    fill(37,66,36);
    rect(xtemp,ytemp,50,50);
  }
  for(int i=0;i<fc;i++) { //creates a list of fort tiles
    xtemp = (int) Math.round(random(39))*50;
    ytemp = (int) Math.round(random(23))*50;
    tilePos[xtemp/50][ytemp/50] = 1;
    fill(198,201,111);
    rect(xtemp,ytemp,50,50);
  }
  for(int i=0;i<40;i++) { //ensures all remaining tiles are plains.
    for(int z=0;z<24;z++) {
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
       tempx+=100;
       if(tempx==400) {
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
    tempx = 1950; tempy = 0;
    for(int i=0;i<puc;i++) { //top right
       plu[i].setLocation(tempx,tempy);
       tempx-=100;
       if(tempx==1550) {
         tempx=1900;
         tempy+=50;
       }
      if(tempx==1500) {
        tempx=1950;
        tempy+=50;
      }
    }
  }
  else if(corner == 3) {
    ecornr = 2;
    tempx = 0; tempy = 1150;
    for(int i=0;i<puc;i++) { //bottom left
       plu[i].setLocation(tempx,tempy);
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
    tempx = 1950; tempy = 1150;
    for(int i=0;i<puc;i++) { //bottom right
       plu[i].setLocation(tempx,tempy);
       tempx-=100;
       if(tempx==1550) {
         tempx=1900;
         tempy-=50;
       }
      if(tempx==1500) {
        tempx=1950;
        tempy-=50;
      }
    }
  }
  boolean repeat = true;
  int occupied[][] = new int[euc][2];
  tempx = 0; tempy = 0;
  for(int i=0;i<euc;i++) { //places enemies randomly, but not occupying the player unit zone
  repeat = true;
    while(repeat) {
      if(ecornr==1) {
         tempx= (int)Math.round(random(30));
         tempy= (int)Math.round(random(18));
      }
      if(ecornr==2) {
         tempx= (int)Math.round(random(30+10));
         tempy= (int)Math.round(random(18));
      }
      if(ecornr==3) {
         tempx= (int)Math.round(random(30)); 
         tempy= (int)Math.round(random(18+8));
      }
      if(ecornr==4) {
         tempx= (int)Math.round(random(30+10)); 
         tempy= (int)Math.round(random(18+8));
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
            tempx= (int)Math.round(random(30+10)); 
            tempy= (int)Math.round(random(18+8));
            enu[b].setLocation(tempx*50,tempy*50);
          }
        }
      }
    }
  }
  
}
