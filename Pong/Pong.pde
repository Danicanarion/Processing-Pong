ArrayList <Ball> balls;
Player player1;
Player player2;

boolean player1Up = false;
boolean player2Up = false;

boolean player1Down = false;
boolean player2Down = false;

void setup(){
  size(1152,640);
  
  balls = new ArrayList<Ball>();
  
  balls.add(new Ball(width/2,height/2, 0, 5, 25));
  player1 = new Player(30, height/2, 30, 100);
  player2 = new Player(width-30*2, height/2, 30, 100);
}

void draw(){
  background(0);  
  
  for (Ball b: balls){
    b.draw();
    
    int edge = b.checkEdges();
   
    if(edge == 0){
      player1.updateScore();
    } else if (edge == 1){
      player2.updateScore();
    }
    
    b.update();
  }
  
  player1.draw();
  player2.draw();
  
  movePlayers();
 
}

void keyPressed() {
  if (key == 'w' || key == 'W') {
    player1Up = true;
  } else if (key == 's' || key == 'S') {
    player1Down = true;
  }
  
  if (keyCode == UP) {
    player2Up = true;
  } else if (keyCode == DOWN) {
    player2Down = true;
  }
}

void movePlayers() {
  if (player1Up) {
    player1.updatePosition(0,-5);
  } else if (player1Down) {
    player1.updatePosition(0,5);
  }
  
  if (player2Up) {
    player2.updatePosition(0,-5);
  } else if (player2Down) {
    player2.updatePosition(0,5);
  }
}

void keyReleased() {
  if (key == 'w' || key == 'W') {
    player1Up = false;
  } else if (key == 's' || key == 'S') {
    player1Down = false;
  }
  
  if (keyCode == UP) {
    player2Up = false;
  } else if (keyCode == DOWN) {
    player2Down = false;
  }
}
