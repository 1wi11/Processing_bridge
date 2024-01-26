float x = 1;
float car;
Firework[] fs = new Firework[10];
boolean once;
int i;


void setup() {
  size(800,700);
  noStroke();
  frameRate(30);
  for (int i = 0; i < fs.length; i++){
    fs[i] = new Firework();
  }
}

void draw(){
  
  sky();
  oceanwater(.005, -0.3);
  oceanwater(.002, 0.3);
  oceanwater(.003, 0);
  oceanwater(.001, 0.2);
  oceanwater(.004, 0.1);
  
  
  if (car >= width+300) {
    car = 0;
  } 
  car = car + 4;
  car();
  
  for (int i = 0; i < fs.length; i++){
    fs[i].draw();
  }
  moving_bridge();
  bridge();
  
}

void ship(){

}

void bridge(){
  noStroke();
  
  fill(64);
  rect(140,500,80,80);
  rect(570,500,80,80);
  
  stroke(1);
  strokeWeight(2);
  fill(0);
  for(i = 20; i <= 380; i += 20)
  { 
     rect(i+200,240,5,20);
  }   
  
  fill(0,51,102);
  rect(150,240,430,8);
  rect(150,260,430,8);
  
  fill(64);
  rect(150,265,430,7);
  
  fill(160);
  rect(360,230,50,50);
  
  strokeWeight(2);
  stroke(6);
 
  fill(0);
  rect(20,450,10,50);
  rect(50,410,10,110);
  rect(80,370,10,150);
  rect(110,340,10,180);
  fill(0,51,102);
  quad(-20,500,0,500,200,240,200,210);
 
  fill(0);
  rect(770,450,10,50);
  rect(740,410,10,110);
  rect(710,370,10,150);
  rect(670,330,10,190);
  fill(0,51,102);
  quad(820,500,800,500,600,240,600,210);
  
  fill(96);
  rect(0,500,220,25);
  rect(570,500,240,25);
  
  fill(64);
  
  rect(140,230,80,270);
  rect(570,230,80,270);
  
  rect(160,190,40,40);
  triangle(160,190,200,190,180,120);
  rect(130,210,20,20);
  triangle(130,210,150,210,140,170);
  rect(210,210,20,20);
  triangle(210,210,230,210,220,170);
  
  rect(590,190,40,40);
  triangle(590,190,630,190,610,120);
  rect(560,210,20,20);
  triangle(560,210,580,210,570,170);
  rect(640,210,20,20);
  triangle(640,210,660,210,650,170);
  
  rect(130,230,100,50);
  rect(560,230,100,50);
  
  stroke(1);
  strokeWeight(2);
  fill(204,204,0);
  
  rect(153,400,20,20);
  rect(188,400,20,20);
  rect(153,430,20,20);
  rect(188,430,20,20);
  
  rect(153,340,20,20);
  rect(188,340,20,20);
  rect(153,310,20,20);
  rect(188,310,20,20);
  
  rect(153,250,20,20);
  rect(188,250,20,20);
  
  rect(583,400,20,20);
  rect(618,400,20,20);
  rect(583,430,20,20);
  rect(618,430,20,20);
  
  rect(583,340,20,20);
  rect(618,340,20,20);
  rect(583,310,20,20);
  rect(618,310,20,20);
  
  rect(583,250,20,20);
  rect(618,250,20,20);
  
  fill(80);
  rect(140,370,80,20);
  rect(570,370,80,20);
  
   
}

void oceanwater(float scale, float dist) {
  noStroke();
  x += scale*2;
  fill(10+(2-42)*dist, 88+(255-28)*dist, 225-(22-14)*dist, 50);
  beginShape();
  vertex(200,800);
  vertex(0,700);
  float ds =  100-(5*(dist));
  for (float i =  0;  i <= 1920;  i+=15)
  {
      float y2 =  noise(x+(i*scale), dist/100);
      vertex( i, ds-(y2*ds*2)+600);
  }
  endShape();
  
  rect(0,570,800,200);
}

void sky(){
  noStroke();
  fill(80,0,0);
  rect(0,0,1000,100);
  fill(100,0,0);
  rect(0,100,1000,100);
  fill(120,0,0);
  rect(0,200,1000,100);
  fill(140,0,0);
  rect(0,300,1000,100);
  fill(160,0,0);
  rect(0,400,1000,100);
  fill(180,100,0);
  rect(0,500,1000,100);
  fill(200,90,0);
  rect(0,600,1000,100);
}

void moving_bridge(){
  noStroke();
  strokeWeight(24); 
  float a=map(mouseX,0,width,400,400); 
  float c=map(mouseX,0,width,400,400); 
  float b=map(mouseY,0,height,510,350); 
  float d=map(mouseY,0,height,510,350); 
  stroke(96);
  line(210,512,a,b); 
  line(c,d,580,512);  
}

void car(){
  noStroke();
  fill(0); 
  triangle(car,100,car+20,100,car+20,80);
  ellipse(car+5,100,60,15);
  triangle(car,100,car+20,100,car,125);
  triangle(car-15,100,car-35,100,car-35,80);
  triangle(car-15,100,car-35,100,car-35,110);
}

void mouseReleased(){
  once = false;
  for (int i = 0; i < fs.length; i++){
    if((fs[i].hidden)&&(!once)){
      fs[i].launch();
      once = true;
    }
  }
}

class Firework {
  float x, y, oldX, oldY, ySpeed, targetX, targetY, explodeTimer, flareWeight, flareAngle;
  int flareAmount, duration;
  boolean launched, exploded, hidden;
  color flare;
  int shapeType;
  
  Firework() {
    launched = false;
    exploded = false;
    hidden = true;
    shapeType = 0; 
  }
  
  void draw() {
    if ((launched) && (!exploded) && (!hidden)) {
      launchMaths();
      strokeWeight(1);
      stroke(255);
      line(x, y, oldX, oldY);
    }
    if ((!launched) && (exploded) && (!hidden)) {
      explodeMaths();
      noStroke();
      strokeWeight(flareWeight);
      stroke(flare);
      for (int i = 0; i < flareAmount + 1; i++) {
        pushMatrix();
        translate(x, y);
        if (shapeType == 0) { 
          point(sin(radians(i * flareAngle)) * explodeTimer, cos(radians(i * flareAngle)) * explodeTimer);
        }  else if (shapeType == 1) { 
          float angle = radians(i * flareAngle);
          float r = explodeTimer*0.1;
          float px = r * 16 * pow(sin(angle), 3);
          float py = -r * (13 * cos(angle) - 5 * cos(2 * angle) - 2 * cos(3 * angle) - cos(4 * angle));
          point(px, py);
        } 
        popMatrix();
      }
    }
    if ((!launched) && (!exploded) && (hidden)) {
      // do nothing
    }
  }
  
  void launch() {
    x = oldX = mouseX + ((random(5) * 10) - 25);
    y = oldY = height;
    targetX = mouseX;
    targetY = mouseY;
    ySpeed = random(3) + 2;
    flare = color(random(3) * 50 + 105, random(3) * 50 + 105, random(3) * 50 + 105);
    flareAmount = ceil(random(30)) + 20;
    flareWeight = ceil(random(4));
    duration = ceil(random(3)) * 20 + 30;
    flareAngle = 360 / flareAmount;
    launched = true;
    exploded = false;
    hidden = false;
    shapeType = floor(random(2));
  }
  
  void launchMaths() {
    oldX = x;
    oldY = y;
    if (dist(x, y, targetX, targetY) > 6) {
      x += (targetX - x) / 2;
      y += -ySpeed;
    } else {
      explode();
    }
  }
  
  void explode() {
    explodeTimer = 0;
    launched = false;
    exploded = true;
    hidden = false;
  }
  
  void explodeMaths() {
    if (explodeTimer < duration) {
      explodeTimer += 0.4;
    } else {
      hide();
    }
  }
  
  void hide() {
    launched = false;
    exploded = false;
    hidden = true;
  }
}
