import controlP5.*;

ControlP5 cp5;
Button b1;

int square = 30, scl = 20;
int sizeWH = square * scl;
int controlsSize = 150;
Cell[][]graph = new Cell[square][square];
ArrayList<Cell> closelist = new ArrayList<Cell>();
ArrayList<Cell> openlist = new ArrayList<Cell>();
ArrayList<Cell> path = new ArrayList<Cell>();
Cell start, end;
Cell dfstemp;
boolean finished = false;
boolean playing = false;
boolean generate=false;
String locked = "";
int speed=1;
String []l={"A*","bfs","dfs"};
String algorithm="A*";

void settings() {
    size(sizeWH,sizeWH + controlsSize);
}

void setup() {
    setupControls();
    for (int i = 0;i < square;i++) {
        for (int j = 0;j < square;j++) {
            graph[i][j] = new Cell(i * scl,j * scl,i,j);
        }
    }
    frameRate(30);
    start = graph[0][0];
    end = graph[square - 1][square - 1];
    start.wall = end.wall = false;
    openlist.add(start);
    dfstemp=start;
}

void draw() {
    background(255);
    textSize(20);
    fill(0);
    text("Speed", 140, height - 90);
    text("Algorithm", 310, height - 90);
    text("Press space for generating maze!", 150, height - 130);
    fill(255);
    rect(480,height-140,100,130,28);
    for (int i = 0;i < square;i++) {
        for (int j = 0;j < square;j++) {
            graph[i][j].setColor(white);
        }
    }
    for (int index = 0; index < closelist.size(); index++) {
        closelist.get(index).setColor(red);
    }
    for (int index = 0; index < openlist.size(); index++) {
        openlist.get(index).setColor(blue);
    }
    for (int index = 0; index < path.size(); index++) {
        path.get(index).setColor(green);
    }
    start.setColor(yellow);
    end.setColor(cyan);
    if(mazeTemp!=null)
      mazeTemp.setColor(green);
    for (int i = 0;i < graph.length;i++) {
        for (int j = 0;j < graph[i].length;j++) {
            graph[i][j].show();
        }
    }
    if (playing && !finished &&  openlist.size() > 0 && frameCount%(speed-31)==0 && !generate) {
      if(algorithm=="A*")
        Astar();
      else if(algorithm=="bfs")
        bfs();
      else if(algorithm=="dfs")
        dfs();
    }
    if (mouseX > 0 &&  mouseX < width &&  mouseY > 0 &&  mouseY < height - controlsSize) {
        int i = floor(mouseX / scl);
        int j = floor(mouseY / scl);
        Cell t=graph[i][j];
        fill(0);
        text(String.format("f: %.02f\ng: %.02f\nh: %.02f",t.f,t.g,t.h), 490, height - 100);
    }
    if(generate && frameCount%(speed-31)==0 && playing && closelist.size()==0)
       getmaze();
}

void setupControls(){
    cp5 = new ControlP5(this);
    cp5.addButton("clearButt").setCaptionLabel("Clear").setPosition(20,height - 70).setSize(100,40);
    b1=cp5.addButton("playButt").setCaptionLabel("Play").setPosition(20,height - 120).setSize(100,40);
    cp5.addSlider("slider")
       .setPosition(140,height - 83)
       .setSize(150,20)
       .setRange(1,30)
       .setValue(speed);
    cp5.addScrollableList("dropdown")
     .setPosition(310, height-83)
     .setSize(150, 100)
     .setBarHeight(20)
     .setItemHeight(20)
     .addItems(l);
}

void clearGrid() {
    for (int i = 0;i < square;i++) {
        for (int j = 0;j < square;j++) {
            graph[i][j] = new Cell(i * scl,j * scl,i,j);
        }
    }
    closelist.clear();
    openlist.clear();
    path.clear();
    finished = false;
    start = graph[0][0];
    end = graph[graph.length - 1][graph[0].length - 1];
    start.wall = false;
    end.wall = false;
    openlist.add(start);
    dfstemp=start;
    generate=false;
    playing=false;
    b1.setCaptionLabel("Play");
}

void reset() {
    closelist.clear();
    openlist.clear();
    path.clear();
    finished = false;
    openlist.add(start);
    dfstemp=start;
}
