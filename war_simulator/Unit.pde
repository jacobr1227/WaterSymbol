class Unit {
 public int uid, HPMax, HPNow, strMag, spd, skl, lck, def, res, mv, locx, locy;
 private String type;
  Unit(int newUid, String newtype, int newHPMax, int newStrMag, int newSpd, int newSkl, int newLck, int newDef, int newRes, int newMv) {
    //lengthy, but creates all stats for each new playerunit
    uid=newUid;
    type = newtype;
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
  
  public void damage(int damage) {
     this.HPNow -= damage;
  }
  public void setLocation(int x, int y) {
     this.locx=(int) x;
     this.locy=(int) y;
   }
  public String advantage() { //a complement to combat(), because muh variable type, java bad
   return this.type; 
  }
  
  public void unitDraw() {
    if(this.type=="plance") {
      image(plance,(float)locx,(float)locy); 
    }
    if(this.type=="psword") {
      image(psword,(float)locx,(float)locy); 
    }
    if(this.type=="paxe") {
      image(paxe,(float)locx,(float)locy); 
    }
    if(this.type=="pcav") {
      image(pcav,(float)locx,(float)locy); 
    }
    if(this.type=="parmor") {
      image(parmor,(float)locx,(float)locy); 
    }
    if(this.type=="parcher") {
      image(parcher,(float)locx,(float)locy); 
    }
    if(this.type=="pmage") {
      image(pmage,(float)locx,(float)locy); 
    }
    if(this.type=="elance") {
      image(elance,(float)locx,(float)locy); 
    }
    if(this.type=="esword") {
      image(esword,(float)locx,(float)locy); 
    }
    if(this.type=="eaxe") {
      image(eaxe,(float)locx,(float)locy); 
    }
    if(this.type=="ecav") {
      image(ecav,(float)locx,(float)locy); 
    }
    if(this.type=="earmor") {
      image(earmor,(float)locx,(float)locy); 
    }
    if(this.type=="earcher") {
      image(earcher,(float)locx,(float)locy); 
    }
    if(this.type=="emage") {
      image(emage,(float)locx,(float)locy); 
    }
   }
   
}
