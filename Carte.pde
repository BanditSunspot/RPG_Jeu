class Carte{
  int x, y, sx, sy;
  
  PImage[] texture = new PImage[6];
  
  int carte_max = 5;
  
  String[] monde;
  
  //PImage[] terrain;
  
  //PImage carte;
  
  int t_X = 50;
  int t_Y = 50;
  
  int text_app[][];
  
  Carte(int X, int Y, int sX, int sY){
    //text_app = new int[int(sX/t_X)][int(sX/t_Y)];
    
    //terrain = new PImage[3];
    
    //for(int i = 1; i < terrain.length+1; i++){
    //  if(i < 10){
    //    terrain[i-1] = loadImage("data/cartes/0" + i +".tif");
    //  }else{
    //    terrain[i-1] = loadImage("data/cartes/" + i +".tif");
    //  }
    //}
    
    //carte = terrain[int(random(3))];
    
    x = X;
    y = Y;
    sx = sX;
    sy = sY;
    
    //for(int i = 0; i < texture.length; i++){
    //  texture[i] = loadImage("data/images/carte/N1/"+(i+1)+".png");
    //  println("Texture["+(i+1)+"] Successfully loaded...");
    //  texture[i].resize(t_X,t_Y);
    //}
    
    
    // Pour un monde aléatoire
    
    int map = int(random(1,carte_max+1));
    
    monde = loadStrings("data/images/carte/N"+map+"/nom.txt");
    
    text_app = new int[int(sX/t_X)][int(sX/t_Y)];
    
    for(int i = 0; i < texture.length; i++){
      texture[i] = loadImage("data/images/carte/N"+map+"/"+(i+1)+".png");
      texture[i].resize(t_X,t_Y);
    }
    
    for(int i = 0; i < text_app.length; i++){
      for(int o = 0; o < text_app[i].length; o++){
        text_app[i][o] = int(random(0,texture.length));
      }
    }
  }
  
  void command_center(){
    aff();
  }
  
  void aff(){
    //image(carte,0,0);
    
    for(int i = 0; i < text_app.length; i++){
      for(int o = 0; o < text_app[i].length; o++){
        image(texture[text_app[i][o]],x+(i*t_X),y+(o*t_Y));
        //stroke(80,40,0);
        //line(x+(i*t_X),y+(o*t_Y),x+((i+1)*t_X),y+(o*t_Y));
        //line(x+(i*t_X),y+(o*t_Y),x+(i*t_X),y+((o+1)*t_Y));
      }
    }
  }
}
