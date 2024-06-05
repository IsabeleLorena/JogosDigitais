class Enemy {
  PImage sprite;
  float x, y;
  float speed;

  Enemy(PImage sprite, float x, float y, float speed) {
    this.sprite = sprite;
    this.x = x;
    this.y = y;
    this.speed = speed;
  }

  void display() {
    image(sprite, x, y);
  }

  void move() {
    y += speed;
    if (y > height) {
      y = -sprite.height;
      x = random(width);
    }
  }

  void reset() {
    this.y = -sprite.height;
    this.x = random(width);
  }

  void setSpeed(float speed) {
    this.speed = speed;
  }
}
