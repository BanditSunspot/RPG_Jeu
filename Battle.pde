class Battle{
  
  Binary_Unbinary Bin;
  
  Settings start;
  Settings cancel;
  
  boolean battle;
  
  int t = 0;
  
  String result = "";
  
  Battle(){
    Bin = new Binary_Unbinary();
    
    start = new Settings(width/2,120);
    cancel = new Settings(width/2,height-120);
  }
  
  void begin(){
    battle = true;
  }
  
  void fight(int[] monster_data, int xp_drop, int gold_drop, String monster_name, int monster_level, PImage monster_skin, int[] player_data, String player_name, PImage player_skin){
    fill(0);
    rect(100,100,width-200,height-200);
    textAlign(CENTER);
    start.aff("Battle Begin",8);
    
    fill(150);
    rect(200,height-500,400,300);
    textSize(30);
    fill(0);
    text("Name: " + player_name, 400, height-450);
    text("Level: " + player_data[4], 400, height-410);
    text("Health: " + player_data[0], 400, height-370);
    text("Armor: " + player_data[1], 400, height-330);
    text("Mana: " + player_data[2], 400, height-290);
    text("Damage: " + player_data[3], 400, height-250);
    image(player_skin, 200, height-900);
    
    fill(150);
    rect(width-600,height-500,400,300);
    textSize(30);
    fill(0);
    text("Name: " + monster_name, width-400, height-450);
    text("Level: " + monster_level, width-400, height-410);
    text("Health: " + monster_data[1], width-400, height-370);
    text("Armor: " + monster_data[2], width-400, height-330);
    text("Mana: " + monster_data[3], width-400, height-290);
    text("Damage: " + monster_data[4], width-400, height-250);
    image(monster_skin, width-600, height-900);
    
    fill(255,0,0);
    
    int s = second();
    
    if((monster_data[1] > 0) && (player_data[0] > 0)){
      if((s > t) || (s < t)){
        t = s;
        if(monster_data[2] <= player_data[3]){
          monster_data[1] = (monster_data[1] - (player_data[3] - monster_data[2]));
        }
        
        if(player_data[1] <= monster_data[4]){
          player_data[0] = (player_data[0] - (monster_data[4] - player_data[1]));
        }
      }
    }
    if(player_data[0] <= 0){
      text("PLAYER DIE, You Loose...", width/2, height/2);
      if((s > t) || (s < t)){
        battle = false;
        t = s;
        result = "DEF";
      }
    }
    
    
    textSize(10);
    cancel.aff("CANCEL",5);
    textSize(30);
    
    
    if(monster_data[1] <= 0){
      text("MONSTER DIE, You Win...", width/2, height/2);
      if((s > t) || (s < t)){
        player_data[5] = player_data[5] + xp_drop;
        player_data[7] = player_data[7] + gold_drop;
        result = "WIN";
        battle = false;
        t = s;
        String[] Save = new String[player_data.length];
        
        for(int i = 0; i < player_data.length; i++){
          if(i == 0){
            int save_hp = player.hp-player.Skills.Comp[i];
            Save[i] = Bin.bin_int(save_hp);
          }else{
            Save[i] = Bin.bin_int(player_data[i]);
          }
        }
        saveStrings("data/player/-- stats --.txt", Save);
      }
    }
    
    textAlign(LEFT);
  }
  
}
