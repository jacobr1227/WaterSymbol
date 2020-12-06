class Unit {
 private int uid, HPMax, HPNow, strMag, spd, skl, lck, def, res, mv, locx, locy; 
 private boolean turn;
 private String typ;
  Unit(int newUid, String newtype, int newHPMax, int newStrMag, int newSpd, int newSkl, int newLck, int newDef, int newRes, int newMv) {
    //lengthy, but creates all stats for each new playerunit
    uid=newUid;
    typ = newtype;
    HPMax=newHPMax;
    HPNow=HPMax;
    strMag=newStrMag;
    spd=newSpd;
    skl=newSkl;
    lck=newLck;
    def=newDef;
    res=newRes;
    mv=newMv;
    locx = 0;
    locy = 0;
    turn = true;
  }
  
  public int[] combat() { //for call on combat
    int stats[] = new int[8];
    stats[0]=this.HPNow;
    stats[1]=this.strMag;
    stats[2]=this.spd;
    stats[3]=this.skl;
    stats[4]=this.def;
    stats[5]=this.res;
    stats[6]=this.lck;
    stats[7]=this.uid;
    return stats;
  }
  
  public void displayMaAr(int x, int y) {
    noStroke();
    fill(0,50,200, 100);
    rect(x,y,50,50);
    for(int i=1;i<=this.mv;i++) {
      //movement range in blue
      //displays main axes
      rect(x+(i*50),y,50,50);
      rect(x-(i*50),y,50,50);
      rect(x,y+(i*50),50,50);
      rect(x,y-(i*50),50,50);
      //displays difficult diagonals
      for(int a=1;a<=this.mv-i;a++) {
        rect(x+(a*50),y+(i*50),50,50);
        rect(x-(a*50),y+(i*50),50,50);
        rect(x-(i*50),y-(a*50),50,50);
        rect(x+(i*50),y-(a*50),50,50);
      }
    }
    //combat range in red
    fill(200,50,50, 100);
    //cardinal axes
    rect(x+((this.mv+1)*50),y,50,50);
    rect(x-((this.mv+1)*50),y,50,50);
    rect(x,y+((this.mv+1)*50),50,50);
    rect(x,y-((this.mv+1)*50),50,50);
    rect(x+((this.mv+2)*50),y,50,50);
    rect(x-((this.mv+2)*50),y,50,50);
    rect(x,y+((this.mv+2)*50),50,50);
    rect(x,y-((this.mv+2)*50),50,50);
    for(int i=1;i<=this.mv;i++) {
        rect(x+(i*50),y+((this.mv-i+1)*50),50,50);
        rect(x+(i*50),y-((this.mv-i+1)*50),50,50);
        rect(x-(i*50),y+((this.mv-i+1)*50),50,50);
        rect(x-(i*50),y-((this.mv-i+1)*50),50,50);
        rect(x+(i*50),y+((this.mv-i+2)*50),50,50);
        rect(x+(i*50),y-((this.mv-i+2)*50),50,50);
        rect(x-(i*50),y+((this.mv-i+2)*50),50,50);
        rect(x-(i*50),y-((this.mv-i+2)*50),50,50);
      }
     rect(x+((this.mv+1)*50),y+(1*50),50,50);
     rect(x+((this.mv+1)*50),y-(1*50),50,50);
     rect(x-((this.mv+1)*50),y+(1*50),50,50);
     rect(x-((this.mv+1)*50),y-(1*50),50,50);
  }
  public void displayRange(int x, int y) {
    noStroke();
    fill(0,50,200, 100);
    rect(x,y,50,50);
    for(int i=1;i<=this.mv;i++) {
      //movement range in blue
      //displays main axes
      rect(x+(i*50),y,50,50);
      rect(x-(i*50),y,50,50);
      rect(x,y+(i*50),50,50);
      rect(x,y-(i*50),50,50);
      //displays difficult diagonals
      for(int a=1;a<=this.mv-i;a++) {
        rect(x+(a*50),y+(i*50),50,50);
        rect(x-(a*50),y+(i*50),50,50);
        rect(x-(i*50),y-(a*50),50,50);
        rect(x+(i*50),y-(a*50),50,50);
      }
    }
    //combat range in red
    fill(200,50,50, 100);
    //cardinal axes
    rect(x+((this.mv+1)*50),y,50,50);
    rect(x-((this.mv+1)*50),y,50,50);
    rect(x,y+((this.mv+1)*50),50,50);
    rect(x,y-((this.mv+1)*50),50,50);
    for(int i=1;i<=this.mv;i++) {
        rect(x+(i*50),y+((this.mv-i+1)*50),50,50);
        rect(x+(i*50),y-((this.mv-i+1)*50),50,50);
        rect(x-(i*50),y+((this.mv-i+1)*50),50,50);
        rect(x-(i*50),y-((this.mv-i+1)*50),50,50);
      }
  }
  public void damage(int damage) {
     this.HPNow -= damage;
  }
  public int getMv() {
   return this.mv; 
  }
  public void setLocation(int x, int y) {
     this.locx=(int) x;
     this.locy=(int) y;
   }
  public String advantage() { //a complement to combat(), because muh variable type, java bad
   return this.typ; 
  }
  
  public void unitDraw() {
    if(turn) {
      tint(255);
    if(this.typ=="plance") {
      image(plance,(float)locx,(float)locy); 
    }
    if(this.typ=="psword") {
      image(psword,(float)locx,(float)locy); 
    }
    if(this.typ=="paxe") {
      image(paxe,(float)locx,(float)locy); 
    }
    if(this.typ=="pcav") {
      image(pcav,(float)locx,(float)locy); 
    }
    if(this.typ=="parmor") {
      image(parmor,(float)locx,(float)locy); 
    }
    if(this.typ=="parcher") {
      image(parcher,(float)locx,(float)locy); 
    }
    if(this.typ=="pmage") {
      image(pmage,(float)locx,(float)locy); 
    }
    if(this.typ=="elance") {
      image(elance,(float)locx,(float)locy); 
    }
    if(this.typ=="esword") {
      image(esword,(float)locx,(float)locy); 
    }
    if(this.typ=="eaxe") {
      image(eaxe,(float)locx,(float)locy); 
    }
    if(this.typ=="ecav") {
      image(ecav,(float)locx,(float)locy); 
    }
    if(this.typ=="earmor") {
      image(earmor,(float)locx,(float)locy); 
    }
    if(this.typ=="earcher") {
      image(earcher,(float)locx,(float)locy); 
    }
    if(this.typ=="emage") {
      image(emage,(float)locx,(float)locy); 
    }
    }
    else if(!turn) {
    tint(100);
      if(this.typ=="plance") {
      image(plance,(float)locx,(float)locy); 
    }
    if(this.typ=="psword") {
      image(psword,(float)locx,(float)locy); 
    }
    if(this.typ=="paxe") {
      image(paxe,(float)locx,(float)locy); 
    }
    if(this.typ=="pcav") {
      image(pcav,(float)locx,(float)locy); 
    }
    if(this.typ=="parmor") {
      image(parmor,(float)locx,(float)locy); 
    }
    if(this.typ=="parcher") {
      image(parcher,(float)locx,(float)locy); 
    }
    if(this.typ=="pmage") {
      image(pmage,(float)locx,(float)locy); 
    }
    if(this.typ=="elance") {
      image(elance,(float)locx,(float)locy); 
    }
    if(this.typ=="esword") {
      image(esword,(float)locx,(float)locy); 
    }
    if(this.typ=="eaxe") {
      image(eaxe,(float)locx,(float)locy); 
    }
    if(this.typ=="ecav") {
      image(ecav,(float)locx,(float)locy); 
    }
    if(this.typ=="earmor") {
      image(earmor,(float)locx,(float)locy); 
    }
    if(this.typ=="earcher") {
      image(earcher,(float)locx,(float)locy); 
    }
    if(this.typ=="emage") {
      image(emage,(float)locx,(float)locy); 
    }
    }
   }
   public String getType() {
    if(this.typ=="plance") {
      return "Soldier";
    }
    if(this.typ=="psword") {
      return "Swordsman";
    }
    if(this.typ=="paxe") {
      return "Warrior";
    }
    if(this.typ=="pcav") {
      return "Cavalier";
    }
    if(this.typ=="parmor") {
      return "Armor Knight";
    }
    if(this.typ=="parcher") {
      return "Archer";
    }
    if(this.typ=="pmage") {
      return "Mage";
    }
    return "Recruit";
   }
   
}
