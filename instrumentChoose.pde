class instrumentChoose extends Button {
  int instrumentNumber = 2;
  int currentInstrument = 0;
  String[] instrumentList = new String[instrumentNumber];
  
  public instrumentChoose(int x, int y, int d, String s[]){
    super(x, y, d, s[0]);
    for(int i = 0; i<instrumentNumber; i++){
      instrumentList[i] = s[i];
    }
  }
  
  public void invoke(){
    if(currentInstrument<instrumentNumber-1){
      currentInstrument++;
    }else{
      currentInstrument = 0;
    }
    content = instrumentList[currentInstrument];
    println(content);
    users[getButtonGroup().userID].setInstrument(content);
  }
  
}
