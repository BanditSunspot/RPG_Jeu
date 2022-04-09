import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;

Minim minim;
AudioPlayer song;

boolean inv_open = false, setComp = false, levelup;

String[] tracks = new String[5];
String[] tracks_names;
int play = 0;
int level_save = 1;
boolean paused = false, music_see = false, start = true, load = true;

int nb_monstres = int(random(1,10));

int pl_dir = 0;
//int screen = 0;

String sound_extension = ".wav";

String[] monstres_noms;

String[] logs = new String[1];

int diffX, diffY;

PFont police;

Starter Start;

Window Inventory;
Window Equipped;
Window SideMenu;
Window Option;
Window Shop;
Window PannelControl;
Window Levelup;

Sorts sorts;

Carte carte;

Perso player;

Battle battle;

Chargement Load;

Monstres[] monstres =  new Monstres[10];

void settings(){

  fullScreen();    
}

void setup(){
  surface.setVisible(false);
  
  logs[0] = "Start";
  
  saveStrings("data/log.txt", logs);
  
  //fullScreen();
  
  println("Width: "+width, "Height: "+height);
  
  //size(displayWidth, displayHeight);
  
  load_tracks();
  
  minim = new Minim(this);
  song = minim.loadFile(tracks[play]);
  song.play();
  
  Load = new Chargement();
  
  police = createFont("data/Text_font/game-font/game-font.ttf",24);
  textFont(police);
  
  
  diffX = 50-(width%50);
  diffY = 50-(height%50);
  
  settings_load();
}

void settings_load(){
  
  settings();
  
  //surface.setSize(displayWidth,displayHeight);
  
  Start = new Starter();
  
  if(width == 1280){
    Inventory = new Window(width/2-500, height/2-400, 500, 400, 20, "Storage", "Storage");
    Equipped = new Window(width/2+100, height/2-400, 400, 300, 20, "Inventory", "Inventory");
    Shop = new Window(width/2-500, height/2, 500, 400, 20, "Shop", "Shop");
    SideMenu = new Window(0, height-60, width, 60, 20, "SideMenu", "Menu");
    Option = new Window(width/2-200, height/2-300, 400, 200, 20, "Options", "Option");
    PannelControl = new Window(width/2-100, height-100, 200, 40, 0, "PannelControl", "Control");
    Levelup = new Window(width/2-100, height/2-50, 200, 100, 20, "You Level up", "Levelup");
  }else{
    Inventory = new Window(width/2-300, height/2-400, 600, 400, 20, "Storage", "Storage");
    Equipped = new Window(width/2+300, height/2-200, 600, 400, 20, "Inventory", "Inventory");
    Shop = new Window(width/2-300, height/2, 600, 400, 20, "Shop", "Shop");
    SideMenu = new Window(0, height-60, width, 60, 20, "SideMenu", "Menu");
    Option = new Window(width/2-200, height/2-300, 400, 200, 20, "Options", "Option");
    PannelControl = new Window(width/2-100, height-100, 200, 40, 0, "PannelControl", "Control");
    Levelup = new Window(width/2-100, height/2-50, 200, 100, 20, "You Level up", "Levelup");
  }
  
  battle = new Battle();
  
  game_load();
}

void game_load(){
  load_perso();
  
  load_carte();
  
  Shop.Boutique.load();
  
  sorts = new Sorts();
}

void load_carte(){
  
  carte = new Carte(0,0,width+diffX,height+diffY);
  
  nb_monstres = int(random(1,10));
  
  monstres_noms = loadStrings("data/mondes/"+carte.monde[0]+"/monstres.txt");
  
  for(int i = 0; i < nb_monstres; i++){
    int r = int(random(monstres_noms.length));
    if(r == 0){
      monstres[i] = new Monstres((int(random(1900/50))*50)+25, (int(random(850/50))*50)+25, monstres_noms[r].substring(0,monstres_noms[r].length()), player.stats[4]);
    }else{
      monstres[i] = new Monstres((int(random(1900/50))*50)+25, (int(random(850/50))*50)+25, monstres_noms[r], player.stats[4]);
    }
  }
}

void load_perso(){
  player = new Perso(25,25,logs);
  level_save = player.stats[4];
}

void draw(){
  background(0);
  fill(255);
  music_key();
  if(Load.load == true){
    Load.aff();
  }else{
    textSize(16);
    if(load == true){
      settings_load();
      load = false;
    }
    if(setComp == false){
      if(start == false){
        if(levelup == false){
          game_key();
          
          carte.command_center();
          
          //if(screen == 0){
          //  saveFrame();
          //  screen = 1;
          //}
          
          SideMenu.center();
          PannelControl.center();
          
          if(player.stats[4] > level_save){
            load_carte();
            textAlign(CENTER);
            text("You level up",width/2, height/2);
            level_save = player.stats[4];
            levelup = true;
            Levelup.levelOk = false;
            Levelup.open = true;
          }
          if(player.out == true){
            if(player.outs == 1){
              player.x = width-diffX-25;
            }if(player.outs == 2){
              player.x = 25;
            }if(player.outs == 3){
              player.y = height-55;
            }if(player.outs == 4){
              player.y = 25;
            }
            player.out = false;
            player.outs = 0;
            load_carte();
          }
          for(int i = 0; i < nb_monstres; i++){
            monstres[i].center();
          }
          player.center();
          //player_key();
          
          Inventory.center();
          Equipped.center();
          Shop.center();
          
          for(int i = 0; i < nb_monstres; i++){
            search_battle(i);
          }
        }else{
          Levelup.center();
          if(Levelup.levelOk == true){
            levelup = false;
          }
        }
      }else{
        Start.aff();
        start_key();
      }
    }else{
      player.Skills.update();
      if(player.Skills.setCompetences.setComp == true){
        setComp = false;
        logs[0] = "Restart";
        game_load();
      }
    }
    Option.center();
    
    tracks();
  }
}

void search_battle(int X){
  if((monstres[X].x == player.x) && (monstres[X].y == player.y)){
    if(battle.battle == false){
      battle.begin();
    }else{
      battle.fight(monstres[X].stats, monstres[X].xp_drop, monstres[X].gold_drop, monstres[X].nom, monstres[X].Level, monstres[X].skin, player.stats, player.nom, player.skin);
    }
  }
  if(battle.result == "DEF"){
    battle.result = "";
    setComp = true;
    player.Skills.setCompetences.open = true;
  }
  if(battle.result == "WIN"){
    battle.result = "";
    monstres[X].move();
  }
  if(battle.result == "CAN"){
    battle.result = "";
    if(pl_dir == 1){
      player.move(2);
    }if(pl_dir == 2){
      player.move(1);
    }if(pl_dir == 3){
      player.move(4);
    }if(pl_dir == 4){
      player.move(3);
    }
    battle.battle = false;
  }
}

void tracks(){
  if((song.isPlaying() == false) && (paused == false)){
    if(play == tracks.length-1){
      play = 0;
    }else{
      play += 1;
    }
    song.close();
    song = minim.loadFile(tracks[play]);
    song.play();
  }
  
  int TimeStamp = int( map(song.position(), 0, song.length(), 0, 300));
  int song_min = int( map(song.position()/60000, 0, song.length()/60000, 0, song.length()/60000));
  int song_sec = int( map((song.position() - (song.position()/1000)), 0, (song.length() - (song.length()/1000)), 0, song.length()/1000));
  
  String str_song_min = "";
  String str_song_sec = "";
  
  
  // convert time
  if(song_min%60 < 10){
    str_song_min = "0"+str(song_min%60);
  }else{
    str_song_min = str(song_min%60);
  }
  
  if(song_sec%60 < 10){
    str_song_sec = "0"+str(song_sec%60);
  }else{
    str_song_sec = str(song_sec%60);
  }
  
  vizu(str_song_min, str_song_sec, TimeStamp);
  replay();
}

void music_key(){
  if(keyPressed == true){
    if(key == 'p'){
      if(paused == false){
        song.pause();
      }else{
        song.play();
      }
      paused = !paused;
    }
    if(key == 's'){
      if(play == tracks.length-1){
        play = 0;
      }else{
        play += 1;
      }
      song.close();
      song = minim.loadFile(tracks[play]);
      song.play();
    }
    if(key == 'a'){
      music_see = !music_see;
    }
  }
}

void keyPressed(){
  boolean esc = false;
  if(key == ESC){
    key = 'o';
    esc = true;
  }
  if(start){
    start_key();
    if(esc == true){
      game_key();
    }
  }else if(setComp == false){
    //music_key();
    player_key();
    game_key();
    keyPressed = false;
  }
}

void player_key(){
  if(keyPressed == true){
    if((keyCode == LEFT) && (player.x >= 25)){
      pl_dir = 1;
      player.move(1);
    }
    if((keyCode == RIGHT) && (player.x <= width-20)){
      pl_dir = 2;
      player.move(2);
    }
    if((keyCode == UP) && (player.y >= 25)){
      pl_dir = 3;
      player.move(3);
    }
    if((keyCode == DOWN) && (player.y <= height-50)){
      pl_dir = 4;
      player.move(4);
    }
  }
}

void game_key(){
  if(keyPressed == true){
    if(key == 'i'){
      Inventory.open_close();
    }if(key == 'e'){
      Equipped.open_close();
    }
    if(key == 'o'){
      Option.open_close();
    }
    if(key == 'b'){
      Shop.open_close();
    }
    //if(key == '5'){
    //  logs[0] = "Restart";
    //  game_load();
    //}
    if(key == 'c'){
      player.Skills.Affichage.open_close();
    }
    //if(key == 'n'){
    //  player.Skills.setCompetences.open_close();
    //}
    //if(key == 'l'){
    //  Levelup.open_close();
    //}
  }
}

void start_key(){
  if(keyPressed == true){
    if(key == 'y'){
      start = false;
    }
  }
}

void vizu(String min, String sec, int time){
  if(music_see == true){
    textSize(24);
    fill(150);
    rect(720,0,width-780,200);
    stroke(255,0,0);
    for(int i = 0; i < song.bufferSize() - 1; i++){
      float x1 = map(i, 0, song.bufferSize(), 730, width-90);
      float x2 = map(i+1, 0, song.bufferSize(), 730, width-90);
      line(x1, 50+song.left.get(i)*50, x2, 50 + song.left.get(i+1)*50);
      line(x1, 150+song.right.get(i)*50, x2, 150 + song.right.get(i+1)*50);
    }
    
    stroke(0);
    fill(255);
    // Display Time like: current_min:current_sec // song_min:song_sec
    if((song.length()/60000 < 10) && ((song.length() - ((song.length()/60000)*60000))/1000 < 10)){
      text("Current song: " + tracks[play] + "\nName: " + tracks_names[play] + "\nSong time: " + min + ":" + sec + "                                0" + song.length()/60000 + ":0" + (song.length() - ((song.length()/60000)*60000))/1000,10,20);
    }
    if((song.length()/60000 > 10) && ((song.length() - ((song.length()/60000)*60000))/1000 < 10)){
      text("Current song: " + tracks[play] + "\nName: " + tracks_names[play] + "\nSong time: " + min + ":" + sec + "                                " + song.length()/60000 + ":0" + (song.length() - ((song.length()/60000)*60000))/1000,10,20);
    }
    if((song.length()/60000 > 10) && ((song.length() - ((song.length()/60000)*60000))/1000 > 10)){
      text("Current song: " + tracks[play] + "\nName: " + tracks_names[play] + "\nSong time: " + min + ":" + sec + "                                " + song.length()/60000 + ":" + (song.length() - ((song.length()/60000)*60000))/1000,10,20);
    }
    if((song.length()/60000 < 10) && ((song.length() - ((song.length()/60000)*60000))/1000 > 10)){
      text("Current song: " + tracks[play] + "\nName: " + tracks_names[play] + "\nSong time: " + min + ":" + sec + "                                0" + song.length()/60000 + ":" + (song.length() - ((song.length()/60000)*60000))/1000,10,20);
    }
  
    fill(200);
    rect(264,75,304,14);
    fill(0,0,200);
    rect(266,77,time,10);
  }
}

void replay(){
  if(keyPressed == true){
    if(key == 'r'){
      song.rewind();
      keyPressed = false;
    }
  }
}

void load_tracks(){
  for(int i = 0; i < tracks.length; i++){
    tracks[i] = "data/soundTracks/musique RPG jeu/Track"+i+sound_extension;
  }
  tracks_names = loadStrings("data/soundTracks/musique RPG jeu/names.txt");
}
