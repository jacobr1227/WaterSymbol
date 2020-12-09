import processing.sound.*;
SoundFile file;
String audioName = "will's song.wav";
String path;
//set variable for setup void graphics
//setup all pre-created/prerendered graphics and variables for generation
PImage plance, psword, paxe, pcav, parmor, parcher, pmage;
PImage elance, esword, eaxe, ecav, earmor, earcher, emage;
int r = 16; //set equal to double the height divided by 100
int c = 24; //set equal to double the width divided by 100
PShape name;
PFont f;
int dmval = 0;
int hitrate, critrate;
int rand1=0,rand2=0,rand3=0;
boolean hit = false;
int holdx=0,holdy=0;
int p=0, oops=0;
int selection = 1;
boolean pick = false;
int tilePos[][] = new int[c][r];
int xtemp, ytemp, url, msel=1;
int nearby[][] = new int[12][2];
gameMap grid[][] = new gameMap[c][r]; //new class used for replicating the map and drawing the grid
Selector cursor = new Selector(0,0);
Selector point = new Selector(60, 68);
int puc = (int) Math.round(random(12)+8); //generate between 8 and 20 player units
int euc = (int) Math.round(random(15)+10); //generate between 10 and 25 enemy units
int tc = (int) Math.round(random(50)); // generate up to 50 forest tiles
int fc = (int) Math.round(random(20)); // generate up to 20 fort tiles
Unit plu[] = new Unit[puc];
Unit enu[] = new Unit[euc];

void setup() {
  size(1200,800);
  frameRate(60);
  path = sketchPath(audioName);
  file = new SoundFile(this, path);
  file.loop();
  for(int i=0;i<c;i++) {
    for(int a=0;a<r;a++) {
      grid[i][a] = new gameMap(i*50,a*50,50,50, tilePos[i][a]); //initializing the grid display
    } 
  }
  for(int i=0;i<12;i++) {
    for(int a=0;a<2;a++) {
      nearby[i][a] = -1;
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

boolean title = true, menu = false, fight = false, about = false, hold = false, move = false,once = false, notag=false, eabout=false;
void draw() {
  /*TODO:
  - fix the combat selector display
  - fix the width of crit messages
  - fix the enemy info page
  */
  
  //for the title screen to function
  if(title) {
    int subtitlex = (int) (width*.4);
    int namex = (int) (width*.85);
    int namey = (int) (height*.9);
    shape(name,width*0.28,300);
    type("by Jacob Rogers", namex, namey, 255,255,255,255);
    type("Press any button to continue!", subtitlex, 440, 255,255,255,255);
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
    for(int i=0;i<playoccu.length;i++) {
     playoccu[i][1]=plu[playoccu[i][0]].locx; 
     playoccu[i][2]=plu[playoccu[i][0]].locy;
    }
    for(int i=0;i<occupied.length;i++) {
     occupied[i][1]=enu[occupied[i][0]].locx; 
     occupied[i][2]=enu[occupied[i][0]].locy;
    }
    cursor.Display();
    if(keyPressed) { //moving the cursor when not in combat, and when a unit is not selected
    if(!hold) {
    if(key == CODED && !menu && !fight) {
        hold = true;
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
      if(key == CODED && menu) {
        hold = true;
        if(keyCode == UP) {
          if(point.ly-30 >=68) {
            point.ly-=30;
            msel--;
          }
        }
        if(keyCode == DOWN) {
          if(point.ly+30 <=158) {
            point.ly+=30;
            msel++;
          }
        }
      }
      if(key == CODED && fight && !pick && !hold) {
        hold = true;
          if(keyCode == UP && selection>1|| keyCode == LEFT && selection>1) {
            selection--;
            cursor.lx=nearby[selection][0];
            cursor.ly=nearby[selection][1];
            cursor.Display();
          }
          if(keyCode == DOWN && selection<oops || keyCode == RIGHT && selection<oops) {
            selection++;
            cursor.lx=nearby[selection][0];
            cursor.ly=nearby[selection][1];
            cursor.Display();
          }
          
      }
      if((key == 'z' && !move && menu && !hold) || (key == 'Z' && !move && menu && !hold)) {
        hold=true;
        if(msel==1) {
          if(inRangeFinder()) {
            fight=true;
            menu=false;
            move = false;
            once = false;
          }
          else if(!inRangeFinder()){
            notag=true;
            menu=false;
          }
        }
        if(msel==2) {
          about=true;
          menu=false;
        }
        if(msel==3) {
          plu[url].turn=false;
          menu = false;
          move = false;
        }
        if(msel==4) {
          for(int i=0;i<puc;i++) {
            plu[i].turn = false;
            plu[i].unitDraw();
          }
          menu=false;
        }
      }
      if((key == 'z' && move && !isOnUnit() && !cursor.isOccupied() && cursor.distanceFrom(plu[url].locx, plu[url].locy, plu[url].mv) && !hold) || (key == 'Z' && !isOnUnit() && !cursor.isOccupied() && move && cursor.distanceFrom(plu[url].locx, plu[url].locy, plu[url].mv) && !hold)) {
        hold = true;
        menu = true;
        plu[url].locx = cursor.lx;
        plu[url].locy = cursor.ly;
        plu[url].unitDraw();
        move = false;
        once = false;
      }
      if(key == 'z' && move &&  cursor.lx == plu[url].locx && cursor.ly == plu[url].locy && !hold || key == 'Z' && move &&  cursor.lx == plu[url].locx && cursor.ly == plu[url].locy && !hold) {
        hold = true;
        menu = true;
        move = false;
        once = false;
      }
      if((key == 'z' && !move && !fight && !menu && isOnUnit() && !hold && plu[unitfinder(cursor.lx,cursor.ly)].turn) || (key == 'Z' && !move && !menu && !fight && isOnUnit() && !hold && plu[unitfinder(cursor.lx,cursor.ly)].turn)) {
        hold = true;
        move = true;
      }
      if(key == 'z' && !hold && !pick && !menu && !move && fight || key == 'Z' && !hold && !pick && !move && !menu && fight) {
        hold = true;
          pick = true;
        }
      if(key == 'z' && !move && !menu && !fight && !about && cursor.isOccupied() && !hold || key == 'Z' && !move && !menu && !fight && !about && cursor.isOccupied() && !hold) {
        eabout = true;
        hold = true;
      }
        if(key == 'x' && !hold && !pick && !menu && !move && fight || key == 'x' && !hold && !pick && !menu && !move && fight) {
          hold = true;
          fight = false;
          menu = true;
        }
      
      if((key == 'x' && move && !fight && !hold) || (key == 'X' && move && !hold)) {
        hold = true;
        move = false;
        once = false;
        cursor.lx = holdx;
        cursor.ly = holdy;
      }
      if((key == 'x' && menu && !fight && !move & !hold) || (key == 'X' && menu && !move && !hold)) {
        menu = false;
        move = false;
        hold = true;
        cursor.lx = holdx;
        plu[url].locx = holdx;
        cursor.ly = holdy;
        plu[url].locy = holdy;
        plu[url].unitDraw();
      }
      if((key == 'x' && about && !fight && !hold) || (key == 'X' && about && !fight &&!hold)) {
       about=false;
       menu=true;
       hold = true;
      }
      if((key == 'x' && eabout && !fight && !menu && !move && !hold) || (key == 'X' && about && !fight && !menu && !move && !hold)) {
       eabout=false;
       menu=true;
       hold = true;
      }
    }
  }
  if(notag) {
    if(p<120) {
      p++;
      strokeWeight(5);
      stroke(0);
      fill(255);
      rect(550,370,100,50);
     type("No target!", 555, 395, 0, 0, 0, 255); 
    }
    else {
     p=0;
     notag=false;
     menu=true;
    }
  }
  if(menu) {
        //contains attack, info, and wait buttons, which do the obvious
    stroke(0);
    strokeWeight(1);
    fill(0,0,255,255);
    rect(50,50,100,140);
    type("Attack",75,90,255,255,255,255);
    type("Info",75,120,255,255,255,255);
    type("Wait",75,150,255,255,255,255);
    type("End",75,180,255,255,255,255);
    point.displayForMenu();
  }
  if(move) {
    if(!once) {
      mvrt();
      once = true;
      url = unitfinder(cursor.lx, cursor.ly);
    }
    if(plu[url].typ == "pmage" || plu[url].typ == "parcher") {
      plu[url].displayMaAr(holdx, holdy); 
    }
    else {
      plu[url].displayRange(holdx,holdy);
    }
  }
  if(fight) {
    if(pick) {
        rand1 = (int) Math.round(random(99))+1;
        rand2 = (int) Math.round(random(99))+1;
        rand3 = (int) Math.round(random(99))+1;
        hitrate = plu[url].skl*2+plu[url].lck/2;
        critrate = plu[url].lck/3;
        if((rand1+rand2)/2 <=hitrate) {
          if(rand3 <= critrate) {
            dmval = (plu[url].strMag-enu[enfinder(nearby[selection][0], nearby[selection][1])].def)*3;
            hit = true;
            enu[enfinder(nearby[selection][0], nearby[selection][1])].damage(dmval);
            plu[url].turn = false;
            url=-1;
            fight = false;
            selection = 1;
            nearby[0][0] = -1;
            pick = false;
          }
          else {
            
            dmval = (plu[url].strMag-enu[enfinder(nearby[selection][0], nearby[selection][1])].def);
            enu[enfinder(nearby[selection][0], nearby[selection][1])].damage(dmval);
            plu[url].turn = false;
            hit = true;
            url=-1;
            fight = false;
            selection = 1;
            nearby[0][0] = -1;
            pick = false;
        }
      }
        else {
          plu[url].turn = false;
            url=-1;
            hit = false;
            fight = false;
        }
       }
       
  }
  if(turnOver()) {
    //have enemies approach nearest allies and attack. Don't add priorities, keep it simple
    for(int i=0;i<euc;i++) {
      enu[i].AI();
      enu[i].unitDraw();
      if(enu[i].fightx==-1 ||enu[i].fighty==-1) {
        //do nothing
      }
      else {
        
        rand1 = (int) Math.round(random(99))+1;
        rand2 = (int) Math.round(random(99))+1;
        rand3 = (int) Math.round(random(99))+1;
        hitrate = enu[i].skl*2+enu[i].lck/2;
        critrate = enu[i].lck/3;
        if((rand1+rand2)/2 <=hitrate) {
          if(rand3 <= critrate) {
            dmval =((enu[i].strMag-plu[unitfinder(enu[i].fightx,enu[i].fighty)].def)*3);
            plu[unitfinder(enu[i].fightx,enu[i].fighty)].damage(dmval);
            hit = true;
            fight = false;
          }
          else {
            
            dmval =((enu[i].strMag-plu[unitfinder(enu[i].fightx,enu[i].fighty)].def)*3);
            plu[unitfinder(enu[i].fightx,enu[i].fighty)].damage(dmval);
            hit = true;
        }
      }
        else {
            hit = false;
        }
        
      }
    
  }
  for(int i=0;i<puc;i++) {
   plu[i].turn = true; 
  }
  }
  if(hit) {
    if(p<100) {
    p++;
    if(rand3 <= critrate) {
    strokeWeight(5);
    stroke(0);
    fill(255);
    rect(530,370,130,50);
    type("Crit! " + dmval + " damage.", 535, 395, 0, 0, 0, 255);
    }
    else {
      strokeWeight(5);
      stroke(0);
      fill(255);
      rect(530,370,130,50);
      type(dmval + " damage.", 535, 395, 0, 0, 0, 255);
    }
    }
    else {
    pick = false;
    hit = false;
    p=0;
    
    }
  }
  if((!hit && pick) ||(!hit && turnOver())) {
    if(p<100) {
      p++;
    strokeWeight(5);
    stroke(0);
    fill(255);
    rect(530,370,130,50);
    type("Attack missed.", 535, 395, 0, 0, 0, 255); 
    }
    else {
     p=0; 
     pick = false;
    }
    if(turnOver()) {
     for(int i=0;i<puc;i++) {
      plu[i].turn= true; 
     }
    }
  }
  if(about) { //displays the info screen for units
    strokeWeight(1);
    stroke(0);
    fill(0,0,255);
    rect(0,0,1200,800);
    type(plu[url].getType(),100,100,255,255,255,255);
    type("Str/Mag",100,120,255,255,255,255);
    type(String.valueOf(plu[url].strMag),200,120,255,255,255,255);
    type("HP",300,100,255,255,255,255);
    type(String.valueOf(plu[url].HPNow) + "/",360,100,255,255,255,255);
    type(String.valueOf(plu[url].HPMax),390,100,255,255,255,255);
    type("Def",100,200,255,255,255,255);
    type(String.valueOf(plu[url].def),200,200,255,255,255,255);
    type("Res",100,220,255,255,255,255);
    type(String.valueOf(plu[url].res),200,220,255,255,255,255);
    type("Skill",100,140,255,255,255,255);
    type(String.valueOf(plu[url].skl),200,140,255,255,255,255);
    type("Move",240,120,255,255,255,255);
    type(String.valueOf(plu[url].mv),300,120,255,255,255,255);
    type("Luck",100,180,255,255,255,255);
    type(String.valueOf(plu[url].lck),200,180,255,255,255,255);
    type("Speed",100,160,255,255,255,255);
    type(String.valueOf(plu[url].spd),200,160,255,255,255,255);
  }
  if(eabout) {
    strokeWeight(1);
    stroke(255);
    fill(220,0,55);
    rect(0,0,1200,800);
    type(enu[enfinder(cursor.lx, cursor.ly)].getType(),100,100,0,0,0,255);
    type("Str/Mag",100,120,255,255,255,255);
    type(String.valueOf(enu[enfinder(cursor.lx, cursor.ly)].strMag),200,120,0,0,0,255);
    type("HP",300,100,255,255,255,255);
    type(String.valueOf(enu[enfinder(cursor.lx, cursor.ly)].HPNow) + "/",360,100,0,0,0,255);
    type(String.valueOf(enu[enfinder(cursor.lx, cursor.ly)].HPMax),390,100,255,255,255,255);
    type("Def",100,200,255,255,255,255);
    type(String.valueOf(enu[enfinder(cursor.lx, cursor.ly)].def),200,200,0,0,0,255);
    type("Res",100,220,255,255,255,255);
    type(String.valueOf(enu[enfinder(cursor.lx, cursor.ly)].res),200,220,0,0,0,255);
    type("Skill",100,140,255,255,255,255);
    type(String.valueOf(enu[enfinder(cursor.lx, cursor.ly)].skl),200,140,0,0,0,255);
    type("Move",240,120,255,255,255,255);
    type(String.valueOf(enu[enfinder(cursor.lx, cursor.ly)].mv),300,120,0,0,0,255);
    type("Luck",100,180,255,255,255,255);
    type(String.valueOf(enu[enfinder(cursor.lx, cursor.ly)].lck),200,180,0,0,0,255);
    type("Speed",100,160,255,255,255,255);
    type(String.valueOf(enu[enfinder(cursor.lx, cursor.ly)].spd),200,160,0,0,0,255);
  }
  if(!keyPressed) {
   hold = false; 
  }
}
}//end of draw

public int unitfinder(int x, int y) {
  int n = 0;
  //finds the specified unit
  for(int i=0;i<plu.length;i++) {
    if(plu[i].locx == x && plu[i].locy == y) {
      n = i;
    }
  }
  return n;
}
private int enfinder(int x, int y) {
  int n =0;
  for(int i=0;i<enu.length;i++) {
    if(enu[i].locx == x && enu[i].locy == y) {
     n = i; 
    }
  }
  return n;
}
private boolean turnOver() {
  for(int i=0;i<puc;i++) {
    if(plu[i].turn) {
      return false;
    }
  }
  return true;
}
private boolean inRangeFinder() { //finds enemies on the map
oops = 0;
nearby[0][0]=-1;
     if(plu[url].typ == "pmage" || plu[url].typ == "parcher") {         
       if(czech(plu[url].locx+50,plu[url].locy)) {
         nearby[oops][0] = plu[url].locx+50;
         nearby[oops][1] = plu[url].locy;
         oops++;
       }
       if(czech(plu[url].locx-50,plu[url].locy))  {
         nearby[oops][0] = plu[url].locx-50;
         nearby[oops][1] = plu[url].locy;
         oops++;
       }
       if(czech(plu[url].locx, plu[url].locy+50))  {
         nearby[oops][0] = plu[url].locx;
         nearby[oops][1] = plu[url].locy+50;
         oops++;
       }
       if(czech(plu[url].locx,plu[url].locy-50))  {
         nearby[oops][0] = plu[url].locx;
         nearby[oops][1] = plu[url].locy-50;
         oops++;
       }
       if(czech(plu[url].locx+100,plu[url].locy))  {
         nearby[oops][0] = plu[url].locx+100;
         nearby[oops][1] = plu[url].locy;
         oops++;
       }
       if(czech(plu[url].locx-100,plu[url].locy))  {
         nearby[oops][0] = plu[url].locx-100;
         nearby[oops][1] = plu[url].locy;
         oops++;
       }
       if(czech(plu[url].locx, plu[url].locy+100))  {
         nearby[oops][0] = plu[url].locx;
         nearby[oops][1] = plu[url].locy+100;
         oops++;
       }
       if(czech(plu[url].locx,plu[url].locy-100))  {
         nearby[oops][0] = plu[url].locx;
         nearby[oops][1] = plu[url].locy-100;
         oops++;
       }
       if(czech(plu[url].locx+50,plu[url].locy+50))  {
         nearby[oops][0] = plu[url].locx+50;
         nearby[oops][1] = plu[url].locy+50;
         oops++;
       }
       if(czech(plu[url].locx+50,plu[url].locy-50))  {
         nearby[oops][0] = plu[url].locx+50;
         nearby[oops][1] = plu[url].locy-50;
         oops++;
       }
       if(czech(plu[url].locx-50,plu[url].locy+50))  {
         nearby[oops][0] = plu[url].locx-50;
         nearby[oops][1] = plu[url].locy+50;
         oops++;
       }
       if(czech(plu[url].locx-50,plu[url].locy-50))  {
         nearby[oops][0] = plu[url].locx-50;
         nearby[oops][1] = plu[url].locy-50;
         oops++;
       }
     }
     else {
       if(czech(plu[url].locx+50,plu[url].locy)) {
         nearby[oops][0] = plu[url].locx+50;
         nearby[oops][1] = plu[url].locy;
         oops++;
       }
       if(czech(plu[url].locx-50,plu[url].locy))  {
         nearby[oops][0] = plu[url].locx-50;
         nearby[oops][1] = plu[url].locy;
         oops++;
       }
       if(czech(plu[url].locx, plu[url].locy+50))  {
         nearby[oops][0] = plu[url].locx;
         nearby[oops][1] = plu[url].locy+50;
         oops++;
       }
       if(czech(plu[url].locx,plu[url].locy-50))  {
         nearby[oops][0] = plu[url].locx;
         nearby[oops][1] = plu[url].locy-50;
         oops++;
       }
     }
  if(nearby[0][0] == -1) {
    return false;
  }
  else {
    return true;
  }
}
private boolean czech(int x, int y) { //dependency method for the above, makes it simpler to write
  for(int i=0;i<euc;i++) {
    if(occupied[i][1] == x && occupied[i][2] == y) {
      return true;
    }
  }
  return false;
}
void delay(int delay) {
 int time = millis();
 while(millis()-time<=delay) {}
}
void mvrt() {
  //sets the return point for the cursor, and allows the movement range to remain static, also permits undoing movement for canceled actions
  holdx=cursor.lx;
  holdy=cursor.ly;
}

void type(String w, int x, int y, int c1, int c2, int c3, int ca) { //for easier typeface on screen
   fill(c1,c2,c3,ca);
   text(w, x, y);
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
int occupied[][] = new int[euc][3];
int playoccu[][] = new int[puc][3];
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
       playoccu[i][0] = plu[i].uid;
       playoccu[i][1] = tempx;
       playoccu[i][2] = tempy;
       tempx+=100;
       if(tempx==500) {
         tempx=50;
         tempy+=50;
       }
      if(tempx==450) {
        tempx=0;
        tempy+=50;
      }
    }
  }
  else if(corner == 2) {
    ecornr = 3;
    tempx = width-50; tempy = 0;
    for(int i=0;i<puc;i++) { //top right
       plu[i].setLocation(tempx,tempy);
       playoccu[i][0] = plu[i].uid;
       playoccu[i][1] = tempx;
       playoccu[i][2] = tempy;
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
       playoccu[i][0] = plu[i].uid;
       playoccu[i][1] = tempx;
       playoccu[i][2] = tempy;
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
       playoccu[i][0] = plu[i].uid;
       playoccu[i][1] = tempx;
       playoccu[i][2] = tempy;
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
               tempx= (int)Math.round(random(c));
               tempy= (int)Math.round(random(r*.6));
            }
            if(ecornr==2) {
               tempx= (int)Math.round(random(c));
               tempy= (int)Math.round(random(r*.6));
            }
            if(ecornr==3) {
               tempx= (int)Math.round(random(c)); 
               tempy= (int)Math.round(random(r*.6)+r*.4);
            }
            if(ecornr==4) {
               tempx= (int)Math.round(random(c*.6)+c*.4); 
               tempy= (int)Math.round(random(r));
            }
      
      if(occupied[i][1] == tempx*50 && occupied[i][2] == tempy*50) { //reads off as totally unnecessary, but won't remove for fear it breaks something I can't see.
        repeat = true;
      }
      else {
       repeat = false;
       occupied[i][0] = enu[i].uid;
       occupied[i][1] = tempx*50;
       occupied[i][2] = tempy*50;
       enu[i].setLocation(tempx*50,tempy*50);
      }
    }
    for(int a=0;a<euc;a++) {
      for(int b=0;b<euc;b++) {
        if(occupied[b][1] == occupied[a][1] && b != a) {
          if(occupied[b][2] == occupied[a][2]) {
            if(ecornr==1) {
               tempx= (int)Math.round(random(c));
               tempy= (int)Math.round(random(r*.6));
            }
            if(ecornr==2) {
               tempx= (int)Math.round(random(c));
               tempy= (int)Math.round(random(r*.6));
            }
            if(ecornr==3) {
               tempx= (int)Math.round(random(c)); 
               tempy= (int)Math.round(random(r*.6)+r*.4);
            }
            if(ecornr==4) {
               tempx= (int)Math.round(random(c*.6)+c*.4); 
               tempy= (int)Math.round(random(r*.6)+r*.4);
            }
            enu[b].setLocation(tempx*50,tempy*50);
          }
        }
      }
    }
  }
}
public boolean isOnUnit() {
   for(int i=0;i<puc;i++) {
     if(playoccu[i][1] == cursor.lx && playoccu[i][2] == cursor.ly) {
        return true; 
     }
   }
   return false;
}
public boolean isUnit(int x, int y) {
   for(int i=0;i<puc;i++) {
     if(playoccu[i][1] == x && playoccu[i][2] == y) {
       return true;
     }
   }
   return false;
}
