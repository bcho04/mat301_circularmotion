class Object {
  float radius;
  float theta;
  float angularVelocity;
  float angularAcceleration;
  Object orbit = null;
  
  Object(float r, float theta, float av, float aa){
    this.radius = r;
    this.theta = theta;
    this.angularVelocity = av;
    this.angularAcceleration = aa;
  }
  
  Object(float r, float theta, float av, float aa, Object o){
    this.radius = r;
    this.theta = theta;
    this.angularVelocity = av;
    this.angularAcceleration = aa;
    this.orbit = o;
  }
  
  void update(){
    this.theta += this.angularVelocity;
    this.angularVelocity += this.angularAcceleration;
  }
}

Object[] array = new Object[15];

void setup(){
  size(1280, 720);
  frameRate(60);
  /*
  for(int i=0;i<5;i++){
    array[i] = new Object(random(100,300),0,random(-2.5, 2.5),0);
  }
  for(int i=5;i<array.length;i++){
    array[i] = new Object(random(30,50),0,random(-1,1),0,array[(i-5)%5])
  }
  */
  /*
  array[0] = new Object(random(100,300),0,random(-2.5,2.5),0,null);
  for(int i=1;i<2;i++){
    array[i] = new Object(random(50,150),0,random(-2.5,2.5),0,array[i-1]);
  }
  */
  array[0] = new Object(200, 0, 2, 0);
  array[1] = new Object(40, 0, 8, 0, array[0]);
}

void draw(){
  background(255);
  fill(0,0,0);
  ellipse(width/2, height/2, 20, 20);
  stroke(0);
  ellipseMode(CENTER);
  for(int i=0;i<array.length;i++){
    if(array[i] == null) continue;
    pushMatrix();
    // We are given Object.radius and Object.theta, and we need to find x and y.
    if(array[i].orbit == null){
      translate(width/2, height/2);
      fill(0,0,255);
    } else {
      float translate_x = width/2;
      float translate_y = height/2;
      Object orbit = array[i].orbit;
      while(orbit != null){
         float m = orbit.radius;
         float a = orbit.theta;
         translate_x += m*cos(radians(a));
         translate_y += m*sin(radians(a));
         orbit = orbit.orbit;
      }
      translate(translate_x, translate_y);
      fill(255,0,0);
    }
    float magnitude = array[i].radius;
    float argument = array[i].theta;
    
    ellipse(magnitude*cos(radians(argument)), magnitude*sin(radians(argument)), 8, 8);
    if(i==1){
      println(magnitude*sin(radians(argument))+array[0].radius*sin(radians(array[0].theta)));
    }
    array[i].update();
    popMatrix();
  }
}
