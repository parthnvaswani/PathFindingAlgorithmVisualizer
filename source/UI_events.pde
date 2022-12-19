void clearButt() {
  clearGrid();
}

void playButt(){
  if(!playing)b1.setCaptionLabel("Pause");
  else b1.setCaptionLabel("Play");
  playing=!playing;
}

void slider(int s) {
  speed=s;
}

void dropdown(int n) {
  algorithm = cp5.get(ScrollableList.class, "dropdown").getItem(n).get("text").toString();
  reset();
}

void mousePressed() {
  if (mouseX > 0 &&  mouseX < width &&  mouseY > 0 &&  mouseY < height - controlsSize && !playing && closelist.size()==0) {
      int i = floor(mouseX / scl);
      int j = floor(mouseY / scl);
      
      if (graph[i][j] ==  start || graph[i][j] ==  end) {
          if (graph[i][j] ==  start)
              locked = "start";
          else
              locked = "end";
          return;
      }
      if (graph[i][j].wall)graph[i][j].wall = false;
      else graph[i][j].wall = true;
  }
}

void mouseDragged() {
  if(mouseX > 0 &&  mouseX < width &&  mouseY > 0 &&  mouseY < height - controlsSize)
    if (locked == "start") {
        start = graph[floor(mouseX / scl)][floor(mouseY / scl)];
        openlist.clear();
        openlist.add(start);
        dfstemp=start;
    } else if (locked == "end") {
        end = graph[floor(mouseX / scl)][floor(mouseY / scl)];
    }
}

void mouseReleased() {
    if(locked=="start")
      start.wall=false;
    else if(locked=="end")
      end.wall=false;
    locked = "";
}

void keyPressed(){
  if(key==' ' && !playing && closelist.size()==0){
    generate=true;
    generateMaze();
  }
}
