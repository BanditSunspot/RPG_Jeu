class Starter{
  
  int nb = 3, sec, time, timer = 0, current = 0;
  
  PImage[] screen = new PImage[nb];
  
  Window start;
  
  String[] Histoire;
  
  Starter(){
    for(int i = 0; i < screen.length; i++){
      screen[i] = loadImage("data/images/starter/0"+(i+1)+".tif");
    }
    start = new Window(width/2-200, 10, 400, 80, 0, "Starter", "Start");
    Histoire = loadStrings("data/histoire/Francais.txt");
  }
  
  void aff(){
    sec = second();
    
    if((time < sec) || (time > sec)){
      time = sec;
      timer += 1;
    }
    if(timer == 20){
      timer = 0;
      if(current > nb-2){
        current = 0;
      }else{
        current += 1;
      }
    }
    image(screen[current],0,0);
    start.center();
    textSize(14);
    fill(0);
    rect(200,180,width-400,400);
    fill(255);
    textAlign(CENTER);
    text("Synopsis",width/2,200);
    for(int i = 0; i < Histoire.length; i++){
      text(Histoire[i],width/2,220+i*20);
    }
  }
}
