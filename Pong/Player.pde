class Player{
  PVector position;
  PVector size;
  int score;
  
  Player(float x, float y, float pheight, float pwidth){
    position = new PVector(x,y);
    size = new PVector(pheight, pwidth);
  }
  
  void draw(){
    rect(position.x, position.y, size.x, size.y);
  }
  
  void updatePosition(float dx, float dy){
    position.x += dx;
    position.y += dy;
  }
  
  void updateScore(){
    this.score++;
  }
  
  void checkEdges(){
    if (this.position.y < 45){
      this.position.y = 45;
    } else if (this.position.y + this.size.y > height-45){
      this.position.y = height - (this.size.y +45);
    } 
  }
}
