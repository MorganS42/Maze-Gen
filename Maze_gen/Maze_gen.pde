float cs=20;
ArrayList<PVector> log=new ArrayList<PVector>();
int pos=0;
int x;
int y;
int sx;
int sy;
int fx;
int fy;
int px;
int py;

int pf=10;

int sh=0;
int shm=100;
float cx;
float cy;
float zoom=1;
float ccs;
boolean set=false;
boolean fast=true;
boolean grid[][];
boolean finished=false;
boolean hacks=true;
void setup() {
  fullScreen();
  //size(540,150);
  grid=new boolean[round(width/cs)][round(height/cs)];
  for(int x=0; x<round(width/cs); x++) {
    for(int y=0; y<round(height/cs); y++) {
      grid[x][y]=false;
    }  
  }
  x=0;
  y=round(height/cs/2);
  sx=x;
  sy=y;
  background(0);
  //frameRate(2);
  noStroke();
  
  //frameRate(3);
}

void mousePressed() {
  if(hacks) {
    grid[round((mouseX+cx)/cs/zoom)][round((mouseY+cy)/cs/zoom)]=!grid[round((mouseX+cx)/cs/zoom)][round((mouseY+cy)/cs/zoom)];  
  }
}

void draw() {
  if(!finished) {
    fast=true;
    for(int i=0; i<10000; i++) {
      if(!finished) {
        next();
      }
    }
  }
  else {
    
    if(!set) {
      sh++;
      fast=false;
      fill(0);       
      if(sh>shm/2) zoom+=(height/cs/10-1)/(float(shm)/2);
      else rect(width-((width-height)/(shm/2))*sh,0,height/(shm/2),height);
      if(sh>shm) set=true;
    } 
    
    ccs=round(height/zoom/cs/2);
    
    cx=px*cs+cs/2;
    cy=py*cs+cs/2;
    
    if(cx-ccs*cs<0) {
      cx=ccs*cs;  
    }
    if(cy-ccs*cs<0) {
      cy=ccs*cs;  
    }
    if(cx/cs+ccs>=width/cs-1) {
      cx=width-ccs*cs;  
    }
    if(cy/cs+ccs>=height/cs-1) {
      cy=height-ccs*cs;  
    }
  }
  if(!fast) {
    if(sh>shm/2) {
      if(px==fx && py==fy) {
        x=0;
        y=round(height/cs/2);
        sx=x;
        sy=y;
        sh=0;
        set=false;
        fast=true;
        zoom=1;
        cs-=5;
        finished=false;
        grid=new boolean[round(width/cs)][round(height/cs)];
        for(int x=0; x<round(width/cs); x++) {
          for(int y=0; y<round(height/cs); y++) {
            grid[x][y]=false;
          }  
        }
      }
      
      
      if(keyPressed) {
        pf*=1.04;  
      }
      else {
        pf=30;  
      }
      
      if(pf%round(1/float(pf)*100+1)==0 && keyPressed) {
        switch(key) {
          case 'w':
            if(py>0) {
              if(grid[px][py-1] || hacks) {
                py--;  
              }
            }
          break;
          case 'a':
            if(px>0) {
              if(grid[px-1][py] || hacks) {
                px--;
              }
            }
          break;
          case 's':
            if(py<=height/cs-2) {
              if(grid[px][py+1] || hacks) {
                py++;  
              }
            }
          break;
          case 'd':
            if(px<=width/cs-2) {
              if(grid[px+1][py] || hacks) {
                px++;  
              }
            }
          break;
        }
        
        ccs=round(height/zoom/cs/2);
    
        cx=px*cs+cs/2;
        cy=py*cs+cs/2;
        
        if(cx-ccs*cs<0) {
          cx=ccs*cs;  
        }
        if(cy-ccs*cs<0) {
          cy=ccs*cs;  
        }
        if(cx/cs+ccs>=width/cs-1) {
          cx=width-ccs*cs;  
        }
        if(cy/cs+ccs>=height/cs-1) {
          cy=height-ccs*cs;  
        }
      }
      
      background(0);
      
      for(int xx=floor((cx/cs)-ccs); xx<ceil((cx/cs)+ccs)-1; xx++) {
        for(int yy=floor((cy/cs)-ccs); yy<ceil((cy/cs)+ccs)-1; yy++) {
          if(grid[xx][yy]) {
            fill(255);  
          }
          else {
            fill(0);  
          }
          if(xx==sx && yy==sy) {
            fill(0,255,0);  
          }
          if(xx==fx && yy==fy) {
            fill(0,0,255);  
          }
          if(xx==px && yy==py) {
            fill(255,0,0);  
          }
          rect((xx-floor(cx/cs-ccs))*cs*zoom,(yy-floor(cy/cs-ccs))*cs*zoom,cs*zoom,cs*zoom);
        }
      }
      fill(0);
      rect(height,0,width-height,height);
      strokeWeight(8);
      stroke(100);
      float angle=atan((float(py)-float(fy))/(float(px)-float(fx)));
      float ppx;
      float ppy;
      
      if(px>=fx) {
        ppx = height+(width-height)/3 + -cos(angle)*(width-height)/4;
        ppy = (width-height)/3 + -sin(angle)*(width-height)/4;     
      }
      else {
        ppx = height+(width-height)/3 + cos(angle)*(width-height)/4;
        ppy = (width-height)/3 + sin(angle)*(width-height)/4;  
      }
      
      line(height+(width-height)/3,(width-height)/3-(width-height)/4,height+(width-height)/3,(width-height)/3+(width-height)/4);
      line(height+(width-height)/3-(width-height)/4,(width-height)/3,height+(width-height)/3+(width-height)/4,(width-height)/3);
      strokeWeight(12);
      noFill();
      stroke(255);
      ellipse(height+(width-height)/3,(width-height)/3,(width-height)/2,(width-height)/2);
      stroke(0,255,0);
      line(height+(width-height)/3,(width-height)/3,ppx,ppy);
      noStroke();
    }
  }
}

void next() {
  int x1=x-2;
  int x2=x+2;
  int y1=y-2;
  int y2=y+2;
  int lc = 40; //loop chance
  ArrayList<PVector> temp = new ArrayList<PVector>();
  if(y-2>=0) {
    if(!grid[x][y1]) {
      temp.add(new PVector(x,y1));    
    }
    else if(round(random(0,lc))==0) {
      temp.add(new PVector(x,y1));   
    }
  }
  if(y+2<height/cs-1) {
    if(!grid[x][y2]) {
      temp.add(new PVector(x,y2));    
    }
    else if(round(random(0,lc))==0) {
      temp.add(new PVector(x,y2));   
    }
  }
  if(x-2>=0) {
    if(!grid[x1][y]) {
      temp.add(new PVector(x1,y)); 
    }
    else if(round(random(0,lc))==0) {
      temp.add(new PVector(x1,y));   
    }
  }
  if(x+2<width/cs-1) {
    if(!grid[x2][y]) {
      temp.add(new PVector(x2,y)); 
    }
    else if(round(random(0,lc))==0) {
      temp.add(new PVector(x2,y));   
    }
  }
  
  pos=0;
  
  int lt =round(random(1,1));
  
  while(temp.size()<lt) {
    pos+=1;
    if(pos>=log.size()-1) {
      finished=true;  
      temp.add(new PVector(x,y));
      fx=round(log.get(round(log.size()/1.4)).x);
      fy=round(log.get(round(log.size()/1.4)).y);
      px=sx;
      py=sy;
    }
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
    if(y+2<height/cs-1) {
      if(!grid[x][y2]) {
        temp.add(new PVector(x,y2));    
      }
    }
    if(x-2>=0) {
      if(!grid[x1][y]) {
        temp.add(new PVector(x1,y));    
      }
    }
    if(x+2<width/cs-1) {
      if(!grid[x2][y]) {
        temp.add(new PVector(x2,y)); 
      }
    }
  }
 
  if(!finished) {
    int rand=round(random(0,temp.size()-1));
    grid[x][y]=true;
    log.add(new PVector(x,y));
    if(x>round(temp.get(rand).x)) {
      grid[x-1][y]=true;
      if(fast) {
        fill(255);
        rect(x*cs,y*cs,cs,cs);
        rect((x-1)*cs,y*cs,cs,cs);
        rect(round(temp.get(rand).x)*cs,round(temp.get(rand).y)*cs,cs,cs);
      }
    }
    if(x<round(temp.get(rand).x)) {
      grid[x+1][y]=true;  
      if(fast) {
        fill(255);
        rect(x*cs,y*cs,cs,cs);
        rect((x+1)*cs,y*cs,cs,cs);
        rect(round(temp.get(rand).x)*cs,round(temp.get(rand).y)*cs,cs,cs);
      }
    }
    if(y>round(temp.get(rand).y)) {
      grid[x][y-1]=true;  
      if(fast) {
        fill(255);
        rect(x*cs,y*cs,cs,cs);
        rect(x*cs,(y-1)*cs,cs,cs);
        rect(round(temp.get(rand).x)*cs,round(temp.get(rand).y)*cs,cs,cs);
      }
    }
    if(y<round(temp.get(rand).y)) {
      grid[x][y+1]=true; 
      if(fast) {
        fill(255);
        rect(x*cs,y*cs,cs,cs);
        rect(x*cs,(y+1)*cs,cs,cs);
        rect(round(temp.get(rand).x)*cs,round(temp.get(rand).y)*cs,cs,cs);
      }
    }
    grid[round(temp.get(rand).x)][round(temp.get(rand).y)]=true;
    x=round(temp.get(rand).x);
    y=round(temp.get(rand).y);
  }
}
