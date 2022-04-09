class Sorts{
  
  String[] H_sort;
  String[] D_sort;
  int[][] stats_sort;
  
  Sorts(){
    loadSorts();
  }
  
  void loadSorts(){
    H_sort = loadStrings("data/sorts/Heal/name.txt");
    D_sort = loadStrings("data/sorts/Damage/name.txt");
    
    stats_sort = new int[H_sort.length+D_sort.length][];
    
    int val = 0;
    
    for(int i = 0; i < H_sort.length; i++){
      stats_sort[i] = int(loadStrings("data/sorts/Heal/"+H_sort[i]+"/stats.txt"));
      println("Sort: "+H_sort[i]+" Chargé.\nStats:\n  - Coût mana: "+stats_sort[i][0]+"\n  - Bonus: "+stats_sort[i][1]+"\n  - Durée: "+stats_sort[i][2]);
      val = i;
    }
    
    for(int i = val; i < D_sort.length+val; i++){
      stats_sort[i] = int(loadStrings("data/sorts/Damage/"+D_sort[i]+"/stats.txt"));
      println("Sort: "+D_sort[i]+" Chargé.\nStats:\n  - Coût mana: "+stats_sort[i][0]+"\n  - Bonus: "+stats_sort[i][1]+"\n  - Durée: "+stats_sort[i][2]);
    }
  }
  
}
