void dfs(){
  closelist.add(dfstemp);
  ArrayList<Cell> neighbors=getNeighborsDfs(dfstemp);
  boolean newPath=false;
  for(int i=neighbors.size()-1;i>=0;i--){
    Cell t=neighbors.get(i);
    if(!t.wall && !closelist.contains(t)){
      t.previous=dfstemp;
      dfstemp=t;
      newPath=true;
      break;
    }
  }
  if(dfstemp==end)
    finished=true;
  if(!newPath && dfstemp.previous!=null)
    dfstemp=dfstemp.previous;
  path.clear();
  Cell temp=dfstemp;
  path.add(temp);
  while(temp.previous!= null) {
      path.add(temp.previous);
      temp = temp.previous;
  }
}

ArrayList<Cell> getNeighborsDfs(Cell q) {
    ArrayList<Cell>result = new ArrayList<Cell>();
    int i = q.i,j = q.j;
    if (i > 0) {
        result.add(graph[i - 1][j]);
    }
    if (j < graph[0].length - 1) {
        result.add(graph[i][j + 1]);
    }
    if (i < graph.length - 1) {
        result.add(graph[i + 1][j]);
    }
    if (j > 0) {
        result.add(graph[i][j - 1]);
    }
    return result;
}
