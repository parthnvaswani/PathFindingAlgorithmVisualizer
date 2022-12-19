void Astar() {
    Cell q = openlist.get(0);
    int index = 0;
    for (int i = openlist.size() - 1;i > 0;i--) {
        if (q.f > openlist.get(i).f) {
            q = openlist.get(i);
            index = i;
        }
    }
    
    if (q ==  end) {
        finished = true;
        return;
    }
    
    openlist.remove(index);
    
    ArrayList<Cell> neighbors = getNeighbors(q);
    for (int i = 0;i < neighbors.size();i++) {
        Cell neighbor = neighbors.get(i);
        if (!closelist.contains(neighbor) && !neighbor.wall) {
            float tempG = q.g + neighbor.heuristic(q);
            
            boolean newPath = false;
            if (openlist.contains(neighbor)) {
                if (tempG < neighbor.g) {
                    neighbor.g = tempG;
                    newPath = true;
                }
            } else {
                neighbor.g = tempG;
                openlist.add(neighbor);
                newPath = true;
            }
            
            if (newPath) {
                neighbor.h = neighbor.heuristic(end);
                neighbor.f = neighbor.g + neighbor.h;
                neighbor.previous = q;
            }
        }
    }
    closelist.add(q);
    path.clear();
    Cell temp = q;
    path.add(temp);
    while(temp.previous!= null) {
        path.add(temp.previous);
        temp = temp.previous;
    }
}

ArrayList<Cell> getNeighbors(Cell q) {
    ArrayList<Cell>result = new ArrayList<Cell>();
    int i = q.i,j = q.j;
    if (i > 0) {
        result.add(graph[i - 1][j]);
    }
    if (j > 0) {
        result.add(graph[i][j - 1]);
    }
    if (i < graph.length - 1) {
        result.add(graph[i + 1][j]);
    }
    if (j < graph[0].length - 1) {
        result.add(graph[i][j + 1]);
    }
    if (j < graph[0].length - 1 &&  i < graph.length - 1) {
        result.add(graph[i + 1][j + 1]);
    }
    if (j > 0 &&  i > 0) {
        result.add(graph[i - 1][j - 1]);
    }
    if (j < graph[0].length - 1 &&  i > 0) {
        result.add(graph[i - 1][j + 1]);
    }
    if (i < graph.length - 1 &&  j > 0) {
        result.add(graph[i + 1][j - 1]);
    }
    return result;
}
