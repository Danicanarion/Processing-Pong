class Player{
  PVector position;
  PVector size;
  int score = 0;
  
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
  
  void setPosition(float x, float y){
    this.position.x = x;
    this.position.y = y;
  }
  
  void updateScore(){
    this.score++;
  }
  
  void setScore(int score){
    this.score = score;
  }
  int getScore(){
    return this.score;
  }
  
  void checkEdges(){
    if (this.position.y < 5){
      this.position.y = 5;
    } else if (this.position.y + this.size.y > height-5){
      this.position.y = height - (this.size.y +5);
    } 
  }
}
