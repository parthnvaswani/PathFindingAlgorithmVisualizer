class Cell{
    int i,j,x,y;
    float g,h,f;
    boolean wall;
    color colour;
    Cell previous;
    
    Cell() {
        this(0,0,0,0);      
    }
    Cell(int x,int y,int i,int j) {
        this.i = i;
        this.j = j;
        this.x = x;
        this.y = y;
        f = 0;
        g = 0;
        h = 0;
        colour = white;
        wall = false;
    }
    void setColor(color colour) {
        this.colour = colour;
    }
    void show() {
        if (this.wall) {
            fill(0);
        } else{
            fill(this.colour);
        }
        rect(this.x,this.y,scl,scl);
    }
    float heuristic(Cell e) {
        return dist(this.x,this.y,e.x,e.y);
    }
}
