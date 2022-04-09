class Binary_Unbinary{
  
  Binary_Unbinary(){
    
  }
  
  String unbin(String enter){
    String res = "";
    for(int i = 0; i < enter.length()/16; i++){
      res += char(unbinary(enter.substring(16*i,16*(i+1))));
    }
    return res;
  }
  
  String bin(String enter){
    String res = "";
    for(int i = 0; i < enter.length(); i++){
      char c = enter.charAt(i);
      boolean N = false;
      for(int o = 0; o < 10; o++){
        if(str(c).equals(str(o)) == true){
          res += bin_int(o);
          N = true;
          break;
        }
      }
      if(!N){
        res += binary(enter.charAt(i));
      }
    }
    return res;
  }
  
  int unbin_int(String enter){
    int res = 0;
    for(int i = 0; i < enter.length()/16; i++){
      res += unbinary(enter.substring(16*i,16*(i+1)));
    }
    return res;
  }
  
  String bin_int(int enter){
    String res = "";
    res = binary(enter);
    return res;
  }
}
