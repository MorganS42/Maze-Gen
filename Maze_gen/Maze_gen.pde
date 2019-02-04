int cs=10;
ArrayList<PVector> log=new ArrayList<PVector>();
int pos=0;
int x;
int y;
boolean grid[][];
void setup() {
  fullScreen();
  grid=new boolean[width/cs][height/cs];
  for(int x=0; x<width/cs; x++) {
    for(int y=0; y<height/cs; y++) {
      grid[x][y]=false;
    }  
  }
  x=0;
  y=height/cs/2;
}

void draw() {
  for(int i=0; i<10; i++) {
    if(key!=' ') {
      next();
    }
  }
  for(int xx=0; xx<width/cs; xx++) {
    for(int yy=0; yy<height/cs; yy++) {
      if(grid[xx][yy]) {
        fill(255);  
      }
      else {
        fill(0);
      }
      if(xx==x && yy==y) {
        fill(255,0,0);  
      }
      rect(xx*cs,yy*cs,cs,cs);
    }
  }  
}

void next() {
  int x1=x-2;
  int x2=x+2;
  int y1=y-2;
  int y2=y+2;
  ArrayList<PVector> temp = new ArrayList<PVector>();
  if(y-2>=0) {
    if(!grid[x][y1]) {
      temp.add(new PVector(x,y1));    
    }
  }
  if(y+2<height/cs) {
    if(!grid[x][y2]) {
      temp.add(new PVector(x,y2));    
    }
  }
  if(x-2>=0) {
    if(!grid[x1][y]) {
      temp.add(new PVector(x1,y));    
    }
  }
  if(x+2<width/cs) {
    if(!grid[x2][y]) {
      temp.add(new PVector(x2,y)); 
    }
  }
  
  pos=0;
  
  while(temp.size()==0) {
    pos+=1;
    println(pos);
    x=round(log.get(log.size()-pos).x);
    y=round(log.get(log.size()-pos).y);
    x1=x-2;
    x2=x+2;
    y1=y-2;
    y2=y+2;
    if(y-2>=0) {
      if(!grid[x][y1]) {
        temp.add(new PVector(x,y1));    
      }
    }
    if(y+2<height/cs) {
      if(!grid[x][y2]) {
        temp.add(new PVector(x,y2));    
      }
    }
    if(x-2>=0) {
      if(!grid[x1][y]) {
        temp.add(new PVector(x1,y));    
      }
    }
    if(x+2<width/cs) {
      if(!grid[x2][y]) {
        temp.add(new PVector(x2,y)); 
      }
    }
  }
 
  int rand=round(random(0,temp.size()-1));
  grid[x][y]=true;
  log.add(new PVector(x,y));
  if(x>round(temp.get(rand).x)) {
    grid[x-1][y]=true;    
  }
  if(x<round(temp.get(rand).x)) {
    grid[x+1][y]=true;   
  }
  if(y>round(temp.get(rand).y)) {
    grid[x][y-1]=true;    
  }
  if(y<round(temp.get(rand).y)) {
    grid[x][y+1]=true;   
  }
  grid[round(temp.get(rand).x)][round(temp.get(rand).y)]=true;
  x=round(temp.get(rand).x);
  y=round(temp.get(rand).y);
}