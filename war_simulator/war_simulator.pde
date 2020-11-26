//set variable for setup void graphics
PShape cursor;
//setup all pre-created/prerendered graphics and variables for generation
PImage plance, psword, paxe, pcav, parmor, parcher, pmage;
PImage elance, esword, eaxe, ecav, earmor, earcher, emage;
PShape name;
PFont f;
float puc = 0, euc = 0, tc = 0, fc = 0;
int tilePos[][] = new int[40][24];
int xtemp, ytemp;
int r = 24;
int c = 40;
gameMap grid[][] = new gameMap[40][24]; //new class used for replicating the map and drawing the grid

void setup() {
  size(2000,1200);
  for(int i=0;i<c;i++) {
    for(int a=0;a<r;a++) {
      grid[i][a] = new gameMap(i*50,a*50,50,50, tilePos[i][a]); //initializing the grid display
      System.out.println(grid[i][a].x + " " + grid[i][a].y +"\n");
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
  - ERROR TO FIX:  Map grid entity not refreshing properly, not filling all tiles.
  - Add Gameplay
  - Add screen refreshing for more than that one square
  - Add backend math for combat
  - Add Menu selector
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
    generateEntity();
    generateTiles();
    placeUnits();
  }
  if(!title) {
  for(int i=0;i<c;i++) {
    for(int a=0;a<r;a++) {
       grid[i][a].fullDisplay(); //refresh, seems to be broken
    } 
  }
  
  }
  
  
}

void type(String w, int x, int y, int c) { //for easier typeface on screen
   text(w, x, y);
   fill(c);
}

void generateEntity() { //for making entities and map generation
  puc = random(12) + 5; //generate between 5 and 17 player units
  euc = random(15) + 10; //generate between 10 and 25 enemy units
  tc = random(50); // generate up to 50 forest tiles
  fc = random(20); // generate up to 20 fort tiles
  
  //truncation to ints
  puc = (int) Math.round(puc);
  euc = (int) Math.round(euc);
  tc = (int) Math.round(tc);
  fc = (int) Math.round(fc);
}

void generateUnit() { //for making stats and classes for generated units
  
}

void generateTiles() { // for generating the actual map of tiles
  randomSeed((long)random(1000000));
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
  
}
