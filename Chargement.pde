class Chargement{
  int load_time = 5, sec, time = 0, count;
  
  String[] Loads = new String[6];
  
  boolean load;
  
  PImage img;

  Load progress;
  
  Chargement(){
    load = true;
    
    img = loadImage("data/images/load/LoadingBis.png");
    img.resize(800,400);
    
    Loads[0] = "Loading Font and Images";
    Loads[1] = "Loading Map and Starter Settings";
    Loads[2] = "Loading Player and Monsters";
    Loads[3] = "Loading Inventory and Starter Armor";
    Loads[4] = "Loading Shop and Images";
    Loads[5] = "Loading Done";
    
    String[] args = {"TwoFrameTest"};
    progress = new Load();
    progress.giveImg(img);
    PApplet.runSketch(args, progress);
    
  }
  
  void aff(){
    //image(img,0,0);
    //sec = second();
    //load();
    if(progress.loading == false){
      load();
    }
  }
  
  void load(){
    if((sec > time) || (sec < time)){
      time = sec;
      count++;
      if(load_time == count){
        load = false;
      }
    }
    fill(150,0,0);
    rect(width/2-150,height/2-15,count*60,50);
    fill(255);
    textSize(34);
    textAlign(CENTER);
    text("Chargement",width/2, height/2+20);
    textSize(24);
    text(Loads[count],width/2,height/2+70);
    textAlign(LEFT);
    surface.setVisible(true);
    load = false;
  }
}

public class Load extends PApplet {
  int load_time = 5, sec, time = 0, count;
  int p = 0, m = 0, w = int(random(10));
  
  boolean loading = true, title = false;
  
  int l = 0;
  
  PImage l_img;
  
  String[] Loads = new String[7];
  
  public void settings(){
    size(800,400);
    Loads[0] = "Loading Font and Images";
    Loads[1] = "Loading Map and Starter Settings";
    Loads[2] = "Loading Player and Monsters";
    Loads[3] = "Loading Inventory and Starter Armor";
    Loads[4] = "Loading Shop and Images";
    Loads[5] = "Loading Done";
    Loads[6] = "Loading Done";
  }
  
  public void giveImg(PImage give){
    l_img = give;
    l_img.resize(800,400);
  }
  
  public void draw(){
    //surface.setVisible(false);
    //keyPressed();
    background(0);
    if(title == false){
      surface.setTitle("The Dream End");
      title = true;
    }
    image(l_img,0,0);
    if((p >= 0) && (p < 4)){
      textAlign(CENTER);
      text("Welcome To my Game:\nThe Dream End",width/2,height/2);
      sec = second();
      if((sec > time) || (sec < time)){
        time = sec;
        p ++;
      }
    }else if((p >= 4) && (loading == true)){
      textAlign(LEFT);
      sec = second();
      load();
    }
  }
  
  public void keyPressed(){
    if(key == ESC){
      key = 0;
    }
  }
  
  void load(){
    if(((sec > time) || (sec < time)) && (count < 120)){
      time = sec;
      count += 20;
      //l = height - count*10;
      p++;
      if(count >= 120){
        surface.setVisible(false);
        loading = false;
      }
    }
    //for(int i = count; i > 0; i--){
    //  text("Loading In Progress: "+i+"%",0,l+i*10);
    //}
    fill(150,0,0);
    rect(width/2-100,height/2-10,count*2,40);
    fill(255);
    textSize(24);
    textAlign(CENTER);
    text("Chargement",width/2, height/2+20);
    textSize(24);
    text(Loads[int(count/20)],width/2,height/2+70);
  }
}
