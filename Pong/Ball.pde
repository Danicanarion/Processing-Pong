class Ball{
  PVector position;
  PVector velocity;
  float radius;
  
  Ball(float x, float y, float vx, float vy, float radius){
    position = new PVector(x,y);
    velocity = new PVector(vx,vy);
    this.radius = radius;
  }
  
  void draw(){
    circle(position.x, position.y, radius);
  }
  
  void update(){
    updatePosition();
  }
  
  void updatePosition(){
    this.position.x += this.velocity.x;
    this.position.y += this.velocity.y;
  }
  
  void updateVelocity(float vx, float vy){
    this.velocity.x = vx;
    this.velocity.y = vy;
  }
  
  int checkEdges(){
    if (this.position.x > width - this.radius){
      setup();
      return 0;
    } else if (this.position.x < this.radius/2){
      setup();
      return 1;
    }
    
    if (this.position.y > height-40 - this.radius){
      this.velocity.y = -this.velocity.y;
    } else if (this.position.y < 40){
      this.velocity.y = -this.velocity.y;
    }
    
    return -1;
  }
}
