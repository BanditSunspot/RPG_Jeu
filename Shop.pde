class Shop{
  
  Binary_Unbinary Bin;
  
  boolean select = false;
  
  String[] inventaire;
  
  String[] armures;
  
  boolean own = false;
  
  int X, Y, sX, sY, T;
  
  Shop(int x, int y, int sx, int sy, int t){
    
    Bin = new Binary_Unbinary();
    
    X = x;
    Y = y;
    sX = sx;
    sY = sy;
    T = t;
    load();
  }
  
  void load(){
    
    String[] Load_armures = loadStrings("data/armures/- liste -.txt");
    String[] Load_inv = loadStrings("data/player/armures.txt");
    
    armures = new String[Load_armures.length];
    
    for(int i = 0; i < Load_armures.length; i++){
      armures[i] = Bin.unbin(Load_armures[i]);
    }
    
    inventaire = new String[Load_inv.length];
    
    for(int i = 0; i < Load_inv.length; i++){
      inventaire[i] = Bin.unbin(Load_inv[i]);
    }
  }
  
  void center(){
    boutton();
  }
  
  void boutton(){
    armure();
    //rect(X+(sX/2),Y+(T*2),100,30);
    //fill(255);
    //text("ARMURE",X+(sX/2)+50,Y+(T*2)+25);
  }
  
  void armure(){
    textAlign(LEFT);
    int o = 1;
    for(int i = 0; i < armures.length; i++){
      
      String[] Load = loadStrings("data/armures/"+armures[i]+".txt");
      String[] infos = new String[Load.length];
      
      for(int u = 0; u < Load.length; u++){
        if(u == 0){
          infos[u] = Bin.unbin(Load[u]);
        }else{
          infos[u] = str(Bin.unbin_int(Load[u]));
        }
        //println("Info["+u+"]: "+infos[u]);
      }
      
      for(int u = 0; u < inventaire.length; u++){
        if(infos[0].equals(inventaire[u]) == true){
          own = true;
        }
      }
      
      if(own != true){
        /*fill(0,255,0);
        rect((X+T), (Y+(T*(o+0.5))), sX-T*2, T);*/
        if(int(infos[2]) <= player.stats[7]){
          fill(0,255,0);
          rect(X+T,Y+(T*(o+0.5)),sX-T*2,T);
        }else{
          fill(255,0,0);
          rect(X+T,Y+(T*(o+0.5)),sX-T*2,T);
        }
        fill(0);
        text(infos[0] + " (Defence: " + infos[1] + " Price: " + infos[2] + " Gold)",X+T,Y+(T*(o+1)));
        if(mousePressed == true){
          if((mouseX >= (X+T)) && (mouseX <= (X+sX-T*2)) && (mouseY >= (Y+(T*(o+0.5)))) && (mouseY <= (Y+(T*(o+1.5)))) && (int(infos[2]) <= player.stats[7])){            
            // Le joueur doit recevoir son armure || Fait ||
            if(inventaire.length == 0){
              inventaire = new String[1];
              inventaire[0] = Bin.bin(infos[0]);
            }else{
              String[] save = inventaire;
              inventaire = new String[(inventaire.length+1)];
              for(int u = 0; u < save.length; u++){
                inventaire[u] = Bin.bin(save[u]);
              }
              inventaire[inventaire.length-1] = Bin.bin(infos[0]);
            }
            player.stats[7] = player.stats[7] - int(infos[2]);
            saveStrings("data/player/armures.txt", inventaire);
            // Cet armure doit être rajouté dans son inventaire || fait ||
            
            // Elle doit disparaître du Shop || fait ||
            
            load();
            
            mousePressed = false;
          }
        }
        o++;
      }
      own = false;
    }
  }
  
}
