import processing.sound.*;

PFont pongFont;
SoundFile startSound;
SoundFile pointSound;
SoundFile bounceSound;

ArrayList <Ball> balls;
int numberOfBalls;
int winPoints;

Player player1;
Player player2;

boolean player1Up = false;
boolean player2Up = false;

boolean player1Down = false;
boolean player2Down = false;

boolean player1won = false;
boolean player2won = false;

boolean inIntro = true;
boolean inGame = false;
boolean inMenu = false;
boolean inWinScreen = false;

void setup(){
  startSound = new SoundFile(this, "./assets/sounds/start.wav");
  pointSound = new SoundFile(this, "./assets/sounds/point.wav");
  bounceSound = new SoundFile(this, "./assets/sounds/bounce.wav");
  
  size(1152,640);
  background(0);
  
  pongFont = createFont("./assets/bit5x3.ttf",8,false);
  
  balls = new ArrayList<Ball>();
  numberOfBalls = 1;
  winPoints = 10;
   
  for (int i = 0; i < numberOfBalls; i++){
    balls.add(new Ball(width/2,height/2, random(-10,10), random(-5,5), 25));
  }
  player1 = new Player(30, height/2, 30, 100);
  player2 = new Player(width-30*2, height/2, 30, 100);
}

void draw(){
  if(inIntro){
    introScreen();
  } else if(inWinScreen) {
    winScreen();
  }else if(inGame){
    background(0);  
    
    drawCourt();
    
    for (Ball b: balls){
      b.draw();
      
      b.update();
      
      int edge = b.checkEdges();
     
      if(edge == 0){
        player1.updateScore();
        pointSound.play();
        restartState();
      } else if (edge == 1){
        player2.updateScore();
        pointSound.play();
        restartState();
      } else if (edge == 2){
        bounceSound.play();
      }
      
      colisionBallPlayer(b); 
    }
    
    player1.draw();
    player2.draw();
    
    movePlayers();
    
    player1.checkEdges();
    player2.checkEdges();
    
    displayScore();
    checkWinPoints();
  }
}

void restartState(){
  startSound.play();
  
  for(Ball b : balls){
    b.setPosition(width/2,height/2);
    b.setVelocity(random(-10,10), random(-5,5));
  }
  player1.setPosition(30, height/2);
  player2.setPosition(width-30*2, height/2);
}
 void drawCourt(){
   stroke(1000);  
   for(int i = 2; i <= 52; i+=2)
    rect(width/2-10,20*i,20,20);
 }
void introScreen(){
  textFont(pongFont, 64);
  textSize(256);
  textAlign(CENTER, CENTER);
  text("Pong", width/2 + 40, height/2 - 100);
  textSize(64);
  text("Press SPACE to play", width/2 + 30, height/2 + 100);
  text("Player 1: \tW-S to move \nPlayer 2: \tArrow keys to move  ", width/2 + 30, height/2 + 200);
}

void winScreen(){
  background(0);
  player1.setScore(0);
  player2.setScore(0);
  textFont(pongFont, 64);
  textSize(128);
  textAlign(CENTER, CENTER);
  String winner = player1won ? "Player 1" : "Player 2";
  String phrase = winner + " won!";
  text(phrase, width/2 + 10, height/2 - 100);
  textSize(64);
  text("Press SPACE to play", width/2, height/2 + 100);
}

void displayScore(){
  textFont(pongFont);
  textSize(128);
  textAlign(CENTER, CENTER);
  text(player1.getScore(), 100, 50);
  text(player2.getScore(), width-100, 50);
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

void colisionBallPlayer(Ball b){
  if(b.position.x < player1.position.x + player1.size.x && b.position.y < player1.position.y + player1.size.y && b.position.y + b.radius > player1.position.y ){
      if (b.velocity.x < 0){
        b.velocity.x = -b.velocity.x*1.05;
        bounceSound.play();
      }
  } else if(b.position.x > player2.position.x && b.position.y < player2.position.y + player2.size.y && b.position.y + b.radius > player2.position.y){
      if(b.velocity.x > 0){
        b.velocity.x = -b.velocity.x*1.05;
        bounceSound.play();
      }
  }
}

void checkWinPoints(){
  if(player1.score == winPoints){
    player1won = true;
    inWinScreen = true;
    inGame = false;
  } else if(player2.score == winPoints){
    player2won = true;
    inWinScreen = true;
    inGame = false;
  }
}

void keyPressed() {
  if(key == ' ' && (inIntro || inWinScreen)){
    startSound.play();
    inIntro = false;
    inWinScreen = false;
    player1won = false;
    player2won = false;
    inGame = true;
  }
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
