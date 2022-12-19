void bfs(){
  int arrSize=openlist.size();
  for(int j=0;j<arrSize;j++){
    Cell c=openlist.get(j);
    closelist.add(c);
    if(c==end){
      finished=true;
      path.clear();
      Cell temp=end;
      path.add(temp);
      while(temp.previous!= null) {
          path.add(temp.previous);
          temp = temp.previous;
      }
    }
    ArrayList<Cell> neighbors=getNeighborsDfs(c);
    for(int i=neighbors.size()-1;i>=0;i--){
      Cell t=neighbors.get(i);
      if(!t.wall && !openlist.contains(t) && !closelist.contains(t)){
        t.previous=c;
        openlist.add(t);
      }
    }
  }
  for(int i=0;i<arrSize;i++){
    openlist.remove(0);
  }
}
