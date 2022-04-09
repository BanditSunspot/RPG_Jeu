class Monstres{
  
  Binary_Unbinary Bin;
  
  int x, y, tx, ty, hp, hp_current, hp_prc, xp_drop, gold_drop, Level;
  
  int[] stats;
  
  String nom;
  
  PImage skin, ig;
  
  Monstres(int X, int Y, String Nom, int level){
    
    Bin = new Binary_Unbinary();
    
    x = X;
    y = Y;
    tx = 8;
    ty = 12;
    
    Level = level;
    
    nom = Nom;
    
    xp_drop = 20;
    
    gold_drop = 10;
    
    load_stats();
  }
  
  void load_stats(){
    //stats = int(loadStrings("data/monstres/"+nom+"/stats.txt"));
    
    // Chargement des datas Stats du monstres enregistrées en Binaire.
    
    String[] Load = loadStrings("data/monstres/"+nom+"/stats.txt");
    stats = new int[Load.length];
    stats[0] = 0;
    
    for(int i = 1; i < Load.length; i++){
      stats[i] = Bin.unbin_int(Load[i]);
    }
    
    skin = loadImage("data/monstres/"+nom+"/img.jpg");
    ig = loadImage("data/monstres/"+nom+"/Terrain.png");
    ig.resize(ig.width*2, ig.height*2);
    skin.resize(400,400);
    hp = int((stats[1]+(Level*5))*((Level+1)/2));
    hp_current = hp;
    stats[1] = int(stats[1] + (Level*5/2));
    stats[2] = int(stats[2] + Level/2);
    stats[4] = int(stats[4] * (Level*2)/2);
  }
  
  void center(){
    health();
    aff();
  }
  
  void aff(){
    fill(200);
    structure();
  }
  
  void structure(){
    /*stroke(0);
    ellipse(x,y-ty/2,ty/1.5,ty/1.5);
    line(x,y,x,y+ty/2);
    line(x-tx/2,y,x+tx/2,y);*/
    
    image(ig,x-(ig.width/2),y-(ig.height/2));
    name();
  }
  
  void name(){
    if((mouseX > x-8) && (mouseX < x+8) && (mouseY > y-10) && (mouseY < y+10)){
      stroke(133,6,6);
      fill(0);
      rect(width/2 - 50, 5, 100, 20);
      fill(133,6,6);
      rect(width/2 - 50, 5, hp_prc, 20);
      fill(255);
      stroke(0);
      textAlign(CENTER);
      textSize(12);
      text(nom, width/2, 20);
      textAlign(LEFT);
    }
  }
  
  void health(){
    hp_prc = (hp_current / hp) * 100;
  }
  
  void move(){
    if(stats[1] <= 0){
      x = -100;
      y = 0;
    }
  }
}
