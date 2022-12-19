Cell mazeTemp;
void generateMaze(){
  for (int i = 0;i < square;i++) {
    for (int j = 0;j < square;j++) {
        graph[i][j].wall=true;
    }
  }
  start.wall=false;
  mazeTemp=start;
  //visited.clear();
  generate=true;
}

void getmaze(){
    Cell neighbor=getRandNeighbor(mazeTemp);
    if(neighbor!=null){
      neighbor.previous=mazeTemp;
      mazeTemp=neighbor;
      mazeTemp.wall=false;
    }
    else{
      if(mazeTemp.previous==null){
        generate=false;
        end.wall=false;
      }
      mazeTemp=mazeTemp.previous;
    }
}

Cell getRandNeighbor(Cell q) {
    ArrayList<Cell>result = new ArrayList<Cell>();
    int i = q.i,j = q.j;
    if (i > 0 && graph[i - 1][j].wall && checkWalls(graph[i - 1][j])) {
        result.add(graph[i - 1][j]);
    }
    if (j < graph[0].length - 1 && graph[i][j + 1].wall && checkWalls(graph[i][j + 1])) {
        result.add(graph[i][j + 1]);
    }
    if (i < graph.length - 1 && graph[i + 1][j].wall && checkWalls(graph[i + 1][j])) {
        result.add(graph[i + 1][j]);
    }
    if (j > 0 && graph[i][j - 1].wall && checkWalls(graph[i][j - 1])) {
        result.add(graph[i][j - 1]);
    }
    if(result.size()==0)
      return null;
    return result.get(int(random(result.size())));
}

boolean checkWalls(Cell c){
  ArrayList<Cell> neighbors=getNeighborsDfs(c);
  int walls=0;
  for(int i=neighbors.size()-1;i>=0;i--){
    if(neighbors.get(i).wall)
      walls++;
  }
  return neighbors.size()-1==walls;
}
