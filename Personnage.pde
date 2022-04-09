class Perso{
  int x, y, tx, ty, damage, armor, hp, hp_current, hp_prc, mana, mana_current, mana_prc, lvl, lvl_prc, xp, xp_next, xp_prc, gold = 100;
  
  String[] armure_item = new String[3];
  
  String[] armure;
  
  String[] Infos;
  
  String nom;
  
  int[] stats = new int[8];
  
  PImage skin, ig;
  
  boolean out = false;
  
  int outs = 0;
  
  Competences Skills;
  Binary_Unbinary Bin;
  
  Perso(int X, int Y, String[] infos){
    
    Bin = new Binary_Unbinary();
    
    Infos = infos;
    
    armure();
    
    x = X;
    y = Y;
    tx = 8;
    ty = 12;
    
    //armure_item[0] = "";
    //armure_item[1] = "0";
    //armure_item[2] = "";
    
    skin = loadImage("data/images/Player/img.jpg");
    ig = loadImage("data/player/image/Terrain.png");
    ig.resize(ig.width*2, ig.height*2);
    skin.resize(400,400);
    
    Skills = new Competences();
    
    load_stats();
  }
  
  void center(){
    textSize(10);
    health();
    mana();
    level();
    gold();
    level_up();
    aff();
    armure();
    Skills.aff(stats);
  }
  
  void load_stats(){
    if(Infos[0] == "Start"){
      
      // Chargement des datas Stats du joueur enregistrées en Binaire.
      
      String[] Load = loadStrings("data/player/-- stats --.txt");
      stats = new int[Load.length];
      
      for(int i = 0; i < Load.length; i++){
        if((i == 0) || (i == 1)){
          stats[i] = Bin.unbin_int(Load[i])+Skills.Comp[i];
        }else if(i == 3){
          stats[i] = Bin.unbin_int(Load[i])+Skills.Comp[i-1];
        }else{
          stats[i] = Bin.unbin_int(Load[i]);
        }
      }
      hp = stats[0];
      mana = stats[2];
      
      nom = "Player";
    }else{
      lvl = 1;
      stats[4] = lvl;
      
      hp = 50 + (lvl * 5);
      stats[0] = hp;
      
      mana = 15;
      stats[2] = mana;
      
      damage = 2;
      stats[3] = damage + lvl;
      
      xp = 1;
      stats[5] = xp;
      
      xp_next = 100;
      stats[6] = int(xp_next * pow(1.2, lvl));
      
      gold = 0;
      stats[7] = gold;
      
      nom = "Player";
      
      // Save des datas Stats du joueur Convertie en Binaire.
      
      String[] Save = new String[stats.length];
      
      for(int i = 0; i < stats.length; i++){
        Save[i] = Bin.bin_int(stats[i]);
      }
      saveStrings("data/player/-- stats --.txt", Save);
    }
  }
  
  void armure(){
    if(Infos[0] == "Start"){
      armure = loadStrings("data/player/use/armure.txt");
      
      if(armure.length > 0){
        String[] Load = loadStrings("data/armures/"+armure[0]+".txt");
        armure_item = new String[Load.length];
        
        for(int i = 0; i < Load.length; i++){
          if(i == 1){
            armure_item[i] = str(Bin.unbin_int(Load[i]));
          }else{
            armure_item[i] = Bin.unbin(Load[i]);
          }
        }
      
        stats[1] = 1 + int(armure_item[1]) + stats[4]-1;
      }else{
        armure_item = new String[2];
        armure_item[1] = "0";
        stats[1] = 1 + stats[4]-1;
      }
    }else{
      String[] reset = new String[0];
      saveStrings("data/player/use/armure.txt", reset);
      saveStrings("data/player/armures.txt", reset);
    }
  }
  
  void aff(){
    fill(150);
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
    fill(255);
    stroke(0);
    textAlign(CENTER);
    text("Player Name: "+nom, width/2, height-25);
    textAlign(LEFT);
  }
  
  void health(){
    hp_prc = (stats[0] * 100) / hp;
    
    fill(255);
    text("Health: ",0,height-43);
    stroke(133,6,6);
    fill(0);
    rect(70, height-55, 200, 20);
    fill(133,6,6);
    rect(70, height-55, hp_prc*2, 20);
    fill(200);
    textAlign(CENTER);
    text(stats[0] + " / " + hp,170,height-43);
    textAlign(LEFT);
  }
  
  void mana(){
    mana_prc = (stats[2] * 100) / mana;
    
    fill(255);
    text("Mana: ",0,height-13);
    stroke(0,0,150);
    fill(0);
    rect(70, height-25, 200, 20);
    fill(0,0,150);
    rect(70, height-25, mana_prc*2, 20);
    fill(200);
    textAlign(CENTER);
    text(stats[2] + " / " + mana,170,height-13);
    textAlign(LEFT);
  }
  
  void level(){
    xp_prc = (stats[5] * 100) / stats[6];
    
    fill(255);
    text("Level: "+stats[4],width/2+200,height-40);
    stroke(0,0,150);
    fill(0);
    rect(width/2+260, height-30, 200, 20);
    fill(0,150,150);
    rect(width/2+260, height-30, xp_prc*2, 20);
    fill(200);
    textSize(10);
    text("Xp: ",width/2+200, height-20);
    textAlign(CENTER);
    text(stats[5] + " / " + stats[6],width/2+360,height-20);
    textAlign(LEFT);
  }
  
  void gold(){
    fill(255);
    text("Gold: "+stats[7],width/2+500,height-40);
  }
  
  void level_up(){
    if(stats[5] > stats[6]){
      stats[3] = stats[3] + 1;
      stats[4] = stats[4] + 1;
      stats[5] -= stats[6];
      stats[6] = int(stats[6] * 1.2);
      hp += 5;
      stats[0] = hp;
    }
  }
  
  void move(int dir){
    if(dir == 1){
      player.x -= carte.t_X;
      if(player.x < 25){
        outs = 1;
        out = true;
      }
    }
    if(dir == 2){
      player.x += carte.t_X;
      if(player.x > width-diffX){
        outs = 2;
        out = true;
      }
    }
    if(dir == 3){
      player.y -= carte.t_Y;
      if(player.y < 25){
        outs = 3;
        out = true;
      }
    }
    if(dir == 4){
      player.y += carte.t_Y;
      if(player.y > height-50){
        outs = 4;
        out = true;
      }
    }
    keyPressed = false;
  }
}
