class Settings{
  
  int x, y;
  
  Settings(int X, int Y){
    x = X;
    y = Y;
  }
  
  void aff(String Message, int T){
    rectMode(CENTER);
    fill(200,0,0);
    rect(x,y-5,T*20,25);
    fill(0);
    text("* "+Message+" *", x, y-4);
    rectMode(CORNER);
    cliquer(T, Message);
  }
  
  void cliquer(int T, String msg){
    if(mousePressed == true){
      if((mouseX >= x-(T*10)) && (mouseX <= x+(T*10)) && (mouseY >= y-17) && (mouseY <= y+7)){
        if(msg == "Quit"){
          exit();
        }
        if(msg == "CANCEL"){
          battle.result = "CAN";
        }
        mousePressed = false;
      }
    }
  
  }
  
}
