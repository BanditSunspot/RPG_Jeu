class Window{
  
  int X, Y, sX, sY, T, slot_size, usedX, usedY;
  
  String Name, Classe;
  
  boolean open, setComp = false, compSet = false, levelOk = false;
  
  int bonus_left = 1;
  
  int[] bonusSet = new int[3];
  
  PImage[][] img;
  
  boolean[][] used;
  
  Settings Quitter;
  Settings MainMenu;
  Shop Boutique;
  
  Binary_Unbinary Bin;
  
  Settings Play;
  
  Window(int x, int y, int sx, int sy, int t, String name, String classe){
    
    Bin = new Binary_Unbinary();
    
    X = x;
    Y = y;
    sX = sx;
    sY = sy;
    T = t;
    Name = name;
    Classe = classe;
    if(Classe == "Menu"){
      open = true;
      slot_size = 20;
    }else if(Classe == "Start"){
      open = true;
      slot_size = 20;
      
      Play = new Settings(X+(sx/2), y+(2*(sY/4)));
      
    }else if(Classe == "Option"){
      open = false;
      slot_size = 20;
    
      MainMenu = new Settings(X+(sx/2), y+(sY/4));
      Quitter = new Settings(X+(sx/2), y+(2*(sY/4)));
      
    }else if(Classe == "Shop"){
      Boutique = new Shop(X, Y, sX, sY, T);
    }else if(Classe == "Control"){
      open = true;
      img = new PImage[4][1];
      img[0][0] = loadImage("data/images/pannelcontrol/Caracter.png");
      img[1][0] = loadImage("data/images/pannelcontrol/Stats.png");
      img[2][0] = loadImage("data/images/pannelcontrol/Storage.png");
      img[3][0] = loadImage("data/images/pannelcontrol/Shop.png");
    }
  }
  
  void center(){
    if(open == true){
      aff();
    }
  }
  
  void aff(){
    
    structure();
    
    if(Classe == "Storage"){
      content_storage();
    }else if(Classe == "Inventory"){
      content_inventory();
    }else if(Classe == "Shop"){
      content_shop();
    }else{
      content();
    }
  }
  
  void structure(){
    noStroke();
    if((Classe == "Storage") || (Classe == "Shop")  || (Classe == "Inventory") || (Classe == "Competences") || (Classe == "setStats")){
      //Structure fenêtre
      fill(#4D4C4C);
      rect(X,Y,sX,sY);
      fill(150);
      rect(X+T,Y+T,sX-2*T,sY-2*T);     
      
      //cross
      if(Classe != "setStats"){
        fill(150,0,0);
        rect(X+T/8,Y+T/8,T/1.2,T/1.2);
        stroke(255);
        line(X+T/4,Y+T/4,(X+T/4)+T/2,(Y+T/4)+T/2);
        line(X+T/4,(Y+T/4)+T/2,(X+T/4)+T/2,(Y+T/4));
      }
      stroke(255);
        
      //name
      textSize(12);
      fill(0);
      text(Name, (X+T/8)+T, Y+T/2);
      if(Classe != "setStats"){
        if(mousePressed == true){
          if((mouseX >= X+T/8) && (mouseX <= X+T/8+T/1.2) && (mouseY >= Y+T/8) && (mouseY <= Y+T/8+T/1.2)){
            open_close();
            mousePressed = false;
          }
        }
      }
      textSize(14);
    }
    if(Classe == "Control"){
      fill(150);
      rect(X,Y,sX,sY);
      stroke(0);
      for(int i = 0; i < img.length; i++){
        if(i > 0){
          line(X+i*50,Y,X+i*50,Y+40);
        }
        image(img[i][0],X+i*50+i*1,Y+1);
        if(mousePressed == true){
          if((mouseX >= X+i*50) && (mouseX <= X+(i+1)*50) && (mouseY >= Y) && (mouseY <= Y+40)){
            if(i == 0){
              Equipped.open_close();
            }else if(i == 1){
              player.Skills.Affichage.open_close();
            }else if(i == 2){
              Inventory.open_close();
            }else if(i == 3){
              Shop.open_close();
            }
            mousePressed = false;
          }
        }
      }
    }
    if((Classe == "Menu") || (Classe == "Start")){
      fill(#4D4C4C);
      rect(X,Y,sX,sY);
      fill(255,0,0);
    }
    if(Classe == "Option"){
      fill(#4D4C4C);
      rect(X,Y,sX,sY);
      //name
      textAlign(CENTER);
      textSize(15);
      fill(0);
      text(Name, X+(sX/2), Y+T/2);
      textAlign(LEFT);
    }
    if(Classe == "Levelup"){
      fill(#4D4C4C);
      rect(X,Y,sX,sY);
      Levelup();
    }
  }
  
  void Levelup(){
    textAlign(CENTER);
    fill(255);
    text("You level up:\nLevel "+(player.stats[4]-1)+" ---> "+player.stats[4],X+sX/2,Y+T);
    fill(0);
    rect(X+sX/2-25,Y+sY-T,50,T);
    fill(255);
    text("OK",X+sX/2,Y+sY-0.5*T);
    fill(0);
    if(mousePressed == true){
      if((mouseX >= X+sX/2-25) && (mouseX <= X+sX/2+25) && (mouseY >= Y+sY-T) && (mouseY <= Y+sY)){
        open = false;
        levelOk = true;
      }
    }
    textAlign(LEFT);
  }
  
  void content_Competences(int[] stats, int[] player_stats, int armor){
    String[] txt = loadStrings("data/player/-- Info Competences --.txt");
    String[] txt_player = loadStrings("data/player/-- Info Stats --.txt");
    //Stats Player
    text("Player Stats : ",X+T,Y+2*T);
    for(int i = 0; i < player_stats.length; i++){
      if(i == 0){
        text(txt_player[i]+" : "+player_stats[i],X+T,Y+(3+i)*T);
      }else{
        text(txt_player[i]+" : "+(player_stats[i]-stats[i-1]),X+T,Y+(3+i)*T);
      }
    }
    //Stats Réincarnation
    text("Bonus Reincarnation : ",X+T,Y+8*T);
    for(int i = 0; i < stats.length; i++){
      text("Bonus "+txt[i]+" : "+stats[i],X+T,Y+(9+i)*T);
    }
    //Stats Armure
    text("Bonus Equipment : ",X+T,Y+13*T);
    text("Bonus armor : "+player.armure_item[1],X+T,Y+14*T);
    //Stats Total
    text("Total Stats : ",X+T,Y+16*T);
    for(int i = 0; i < stats.length; i++){
      if(i == 1){
        text(txt[i]+" : "+(player_stats[i+1]+armor),X+T,Y+(17+i)*T);
      }else{
        text(txt[i]+" : "+player_stats[i+1],X+T,Y+(17+i)*T);
      }
    }
  }
  
  void setCompetences(int[] competences){
    String[] txt = loadStrings("data/player/-- Info Competences --.txt");
    
    String[] bin_stats = new String[3];
    
    text("Reincanation point left : "+bonus_left,X+T,Y+2*T);
    text("Bonus Reincarnation : ",X+T,Y+3*T);
    
    // Pour mettre des points
    
    for(int i = 0; i < txt.length; i++){
      text("Bonus "+txt[i]+" : "+(competences[i]+bonusSet[i]),X+T,Y+(4+i)*T);
      fill(0);
      rect(X+sX-3*T, Y+(3.5+i)*T,15,15);
      fill(255);
      text("+", X+sX-3*T+2.5, Y+(3.5+i)*T+7.5);
      fill(0);
      if(mousePressed == true){
        if((mouseX >= X+sX-3*T) && (mouseX <= X+sX-3*T+15) && (mouseY >= Y+(3.5+i)*T) && (mouseY <= Y+(3.5+i)*T+15) && (compSet == false)){
          bonusSet[i] += 1;
          bonus_left -= 1;
          compSet = true;
          mousePressed = false;
        }
      }
    }
    
    // Pour confirmer
    
    rect(X+sX/2-3*T, Y+sY-3*T,6*T, T);
    fill(255);
    textAlign(CENTER);
    text("CONFIRM",X+sX/2,Y+sY-2.5*T);
    textAlign(LEFT);
    fill(0);
    if(mousePressed == true){
      if((mouseX >= X+sX/2-3*T) && (mouseX <= X+sX/2+3*T) && (mouseY >= Y+sY-3*T) && (mouseY <= Y+sY-2*T) && (compSet == true)){
        setComp = true;
        compSet = false;
        for(int i = 0; i < bonusSet.length; i++){
          competences[i] = competences[i]+bonusSet[i];
          bin_stats[i] = Bin.bin_int(competences[i]);
        }
        bonus_left += 1;
        for(int i = 0; i < bonusSet.length; i++){
          bonusSet[i] = 0;
        }
        open = false;
        saveStrings("data/player/-- Competences --.txt", bin_stats);
        mousePressed = false;
      }
    }
    
    // Pour annuler
    
    rect(X+sX/2-3*T, Y+sY-4*T,6*T, T);
    fill(255);
    textAlign(CENTER);
    text("CANCEL",X+sX/2,Y+sY-3.5*T);
    textAlign(LEFT);
    fill(0);
    if(mousePressed == true){
      if((mouseX >= X+sX/2-3*T) && (mouseX <= X+sX/2+3*T) && (mouseY >= Y+sY-4*T) && (mouseY <= Y+sY-3*T) && (compSet == true)){
        compSet = false;
        bonus_left += 1;
        for(int i = 0; i < bonusSet.length; i++){
          bonusSet[i] = 0;
        }
        mousePressed = false;
      }
    }
  }
  
  void content_shop(){
    textAlign(CENTER);
    Boutique.center();
    textAlign(LEFT);
  }
  
  void content_storage(){
    String[] Load_inv = loadStrings("data/player/armures.txt");
    String[] armor_inv = new String[Load_inv.length];
    
    for(int i = 0; i < Load_inv.length; i++){
      armor_inv[i] = Bin.unbin(Load_inv[i]);
    }
    
    //String[] Load_equip = loadStrings("data/player/use/armure.txt");
    String[] equip = loadStrings("data/player/use/armure.txt");
    
    /*for(int i = 0; i < Load_equip.length; i++){
      equip[i] = Bin.unbin(Load_equip[i]);
    }*/
    
    if(armor_inv.length >= 0){
      for(int i = 0; i < armor_inv.length; i++){
        String[] Load = loadStrings("data/armures/"+armor_inv[i]+".txt");
        String[] armure_item = new String[Load.length];
        
        for(int o = 0; o < Load.length; o++){
          if(o == 0){
            armure_item[o] = Bin.unbin(Load[o]);
          }else{
            armure_item[o] = str(Bin.unbin_int(Load[o]));
          }
        }
        if(equip.length > 0){
          if(equip[0].equals(armure_item[0]) == true){
            fill(0,255,0);
            rect(X+T, Y+((i+0.75)*2)*T, sX-T*2, T);
            fill(0);
            //fill(150,0,0);
            text("Armor: "+armure_item[0]+" ("+armure_item[1]+" Defence)",X+2*T,Y+((i+1)*2)*T);
          }
        }else{
          fill(0);
          text("Armor: "+armure_item[0]+" ("+armure_item[1]+" Defence)",X+2*T,Y+((i+1)*2)*T);
        }
        if(mousePressed == true){
          if((mouseX >= X+T) && (mouseX <= X+sX-T) && (mouseY >= Y+((i+0.75)*2)*T) && (mouseY <= Y+((i+0.75)*2)*T+T)){
            if(equip.length > 0){
              if(equip[0].equals(armure_item[0]) == true){
                equip = new String[0];
                saveStrings("data/player/use/armure.txt", equip);
                //println("Already equip");
              }else if((equip[0].equals("") == true) || (equip[0].equals(armure_item[0]) == false)){
                equip = new String[1];
                equip[0] = armure_item[0];
                saveStrings("data/player/use/armure.txt", equip);
                //println("Equip: "+armure_item[0]+" at the following destination: data/player/use/armure.txt");
              }
            }else{
              equip = new String[1];
              equip[0] = armure_item[0];
              saveStrings("data/player/use/armure.txt", equip);
            }
            mousePressed = false;
          }
        }
      }
    }else{
      text("Armure: None",X+2*T,Y+2*T);
    }
    
    //grille();
  }
  
  void content_inventory(){
    String[] armure = loadStrings("data/player/use/armure.txt");
    if(armure.length == 0){
      text("Armor: None",X+2*T,Y+2*T);
    }else{
      text("Armor: "+armure[0],X+2*T,Y+2*T);
    }
  }
    
  void content(){
    if(Classe == "Option"){
      textAlign(CENTER);
      textSize(15);
      //MainMenu.aff("Back to main menu",14);
      Quitter.aff("Quit",5);
      textAlign(LEFT);
    }
    if(Classe == "Start"){
      textAlign(CENTER);
      Play.aff("Press Y to play",16);
      textAlign(LEFT);
    }
  }
  
  void update_contain(int x, int y){
    if((x > usedX) || (y > usedY) || (x < 0) || (y < 0)){
      println("error no contain at this position...\nPosition give is: ["+x+"]["+y+"]");
    }
  }
  
  void grille(){
    fill(150);
    stroke(0);
    for(int x = 0; x < (sX-T-T)/slot_size; x++){
      for(int y = 0; y < (sY-T-T)/slot_size; y++){
        if((used[x][y] == true) && (Classe == "Storage")){
          rect((X+T)+(x*slot_size), (Y+T)+(y*slot_size), slot_size, slot_size);
          image(img[x][y], (X+T)+(x*slot_size), (Y+T)+(y*slot_size));
        }if((used[x][y] == false) && (Classe == "Storage")){
          rect((X+T)+(x*slot_size), (Y+T)+(y*slot_size), slot_size, slot_size);
        }
      }
    }
  }
  
  
  void open_close(){
    if(Name != "SideMenu"){
      open = !open;
    }
  }
}
