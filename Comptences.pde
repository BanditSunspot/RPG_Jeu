class Competences{
  
  Binary_Unbinary Bin;
  
  Window Affichage;
  Window setCompetences;
  
  int[] Comp;
  int[] stats;
  
  Competences(){
    //Comp = int(loadStrings("data/player/-- Competences --.txt"));
    
    // Chargement des datas compétences enregistrées en Binaire.
    
    Bin = new Binary_Unbinary();
    String[] Load = loadStrings("data/player/-- Competences --.txt");
    Comp = new int[Load.length];
    for(int i = 0; i < Load.length; i++){
      Comp[i] = Bin.unbin_int(Load[i]);
    }
    Affichage = new Window(width/2-700, height/2-400, 400, 600, 20, "Stats", "Competences");
    setCompetences = new Window(width/2-200, height/2-400, 400, 600, 20, "Set Reincarnation Bonus", "setStats");
    stats = new int[4];
  }
  
  void aff(int[] player_stats){
    stats[0] = player_stats[4];
    stats[1] = player_stats[0];
    stats[2] = player_stats[4];
    stats[3] = player_stats[3];
    int armor = player_stats[1]-1;
    Affichage.center();
    if(Affichage.open == true){
      Affichage.content_Competences(Comp, stats, armor);
    }
    update();
  }
  
  void update(){
    setCompetences.center();
    if(setCompetences.open == true){
      setCompetences.setCompetences(Comp);
    }
  }
  
}
