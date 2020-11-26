//set variable for setup void graphics
PShape cursor;
//setup all pre-created/prerendered graphics and variables for generation
PImage plance, psword, paxe, pcav, parmor, parcher, pmage;
PImage elance, esword, eaxe, ecav, earmor, earcher, emage;
PShape name;
PFont f;
float puc = 0, euc = 0, tc = 0, fc = 0;
int xtemp, ytemp;
int r = height/50;
int c = width/50;
int tilePos[][] = new int[c][r];
Map[][] grid; //new class used for replicating the map and drawing the grid

void setup() {
  size(2000,1200);
  grid = new Map[c][r];
  for(int i=0;i<c;i++) {
    for(int a=0;a<r;a++) {
      grid[i][a] = new Map(i*50,a*50,50,50, 0); //initializing the grid display
    } 
  }
  for(int i=0;i<40;i++) {
   for(int z=0;z<24;z++) {
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
  - Generate Terrain
  - Add Grid
  - Add Gameplay
  - Add screen refreshing
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
    generateEnt();
    placeTiles();
    placeUnits();
  }
  refresh();
  
}

void type(String w, int x, int y, int c) { //for easier typeface on screen
   text(w, x, y);
   fill(c);
}

void generateEnt() { //for making entities and map generation
  puc = random(12) + 5; //generate between 5 and 17 player units
  euc = random(15) + 10; //generate between 10 and 25 enemy units
  tc = random(30); // generate up to 30 forest tiles
  fc = random(10); // generate up to 10 fort tiles
  
  //truncation to ints
  puc = (int) Math.round(puc);
  euc = (int) Math.round(euc);
  tc = (int) Math.round(tc);
  fc = (int) Math.round(fc);
}

void generateUnit() { //for making stats and classes for generated units
  
}

void placeTiles() { // for generating the actual map of tiles
  for(int i=0;i<tc;i++) { //creates a list of forest tiles
    xtemp = (int) Math.round(random(40))*50;
    ytemp = (int) Math.round(random(24))*50;
    tilePos[xtemp/50][ytemp/50] = 2;
    rect(xtemp,ytemp,50,50);
    fill(37,66,36);
  }
  for(int i=0;i<fc;i++) { //creates a list of fort tiles
    xtemp = (int) Math.round(random(40))*50;
    ytemp = (int) Math.round(random(24))*50;
    tilePos[xtemp/50][ytemp/50] = 1;
    rect(xtemp,ytemp,50,50);
    fill(198,201,111);
    System.out.println(tilePos[xtemp/50][ytemp/50]);
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
       
    } 
  }
}

void refresh() { //for screen refreshes for animation
  
}

void placeUnits() { //for generating the actual map of units
  
}
