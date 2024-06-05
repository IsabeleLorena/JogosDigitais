class Player {
  PImage sprite;
  float x, y;
  int lives;
  float speedX, speedY;

  Player(PImage sprite) {
    this.sprite = sprite;
    this.x = width / 2;
    this.y = height - 100;
    this.lives = 3;
    this.speedX = random(3, 5);
    this.speedY = random(3, 5);
  }

  void display() {
    image(sprite, x, y, sprite.width / 2, sprite.height / 2);
  }

  void move() {
    if (keyPressed) {
      if (keyCode == LEFT) x -= 5;
      if (keyCode == RIGHT) x += 5;
      if (keyCode == UP) y -= 5;
      if (keyCode == DOWN) y += 5;
    }
  }

  void reset() {
    this.x = width / 2;
    this.y = height - 100;
    this.lives = 3;
  }

  boolean isGameOver() {
    return x > width || x < 0 || y > height || y < 0;
  }
}
