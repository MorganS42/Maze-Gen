int cs=100;
ArrayList<PVector> log=new ArrayList<PVector>();
int pos=0;
int x;
int y;
boolean fast=false;
boolean og[][];
boolean grid[][];
boolean finished=true;
void setup() {
  fullScreen();
  grid=new boolean[width/cs][height/cs];
  og=new boolean[width/cs][height/cs];
  for(int x=0; x<width/cs; x++) {
    for(int y=0; y<height/cs; y++) {
      grid[x][y]=false;
      og[x][y]=false;
    }  
  }
  x=0;
  y=height/cs/2;
  background(0);
}

void draw() {
  for(int i=0; i<1; i++) {
    if(!finished) {
      next();
    }
  }
  for(int xx=0; xx<width/cs; xx++) {
    for(int yy=0; yy<height/cs; yy++) {
      if(fast) {
        if(grid[xx][yy]!=og[xx][yy]) {
          if(grid[xx][yy]) {
            fill(255);  
          }
          else {
            fill(0);
          }
          rect(xx*cs,yy*cs,cs,cs);
        } 
      }
      else {
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
    else if(round(random(0,100))==0) {
      temp.add(new PVector(x,y1));   
    }
  }
  if(y+2<height/cs) {
    if(!grid[x][y2]) {
      temp.add(new PVector(x,y2));    
    }
    else if(round(random(0,100))==0) {
      temp.add(new PVector(x,y2));   
    }
  }
  if(x-2>=0) {
    if(!grid[x1][y]) {
      temp.add(new PVector(x1,y)); 
    }
    else if(round(random(0,100))==0) {
      temp.add(new PVector(x1,y));   
    }
  }
  if(x+2<width/cs) {
    if(!grid[x2][y]) {
      temp.add(new PVector(x2,y)); 
    }
    else if(round(random(0,100))==0) {
      temp.add(new PVector(x2,y));   
    }
  }
  
  pos=0;
  
  while(temp.size()==0) {
    pos+=1;
    if(pos>=log.size()-1) {
      finished=true;  
      temp.add(new PVector(x,y));
    }
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
 
  if(!finished) {
    int rand=round(random(0,temp.size()-1));
    og[x][y]=grid[x][y];
    grid[x][y]=true;
    log.add(new PVector(x,y));
    if(x>round(temp.get(rand).x)) {
      og[x-1][y]=grid[x-1][y];
      grid[x-1][y]=true;    
    }
    if(x<round(temp.get(rand).x)) {
      og[x+1][y]=grid[x+1][y];
      grid[x+1][y]=true;   
    }
    if(y>round(temp.get(rand).y)) {
      og[x][y-1]=grid[x][y-1];
      grid[x][y-1]=true;    
    }
    if(y<round(temp.get(rand).y)) {
      og[x][y+1]=grid[x][y+1];
      grid[x][y+1]=true;   
    }
    og[round(temp.get(rand).x)][round(temp.get(rand).y)]=grid[round(temp.get(rand).x)][round(temp.get(rand).y)];
    grid[round(temp.get(rand).x)][round(temp.get(rand).y)]=true;
    x=round(temp.get(rand).x);
    y=round(temp.get(rand).y);
  }
}
