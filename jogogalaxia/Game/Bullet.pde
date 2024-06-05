class Bullet {
  PImage sprite;
  float x, y;

  Bullet(PImage sprite, float x, float y) {
    this.sprite = sprite;
    this.x = x;
    this.y = y;
  }

  void display() {
    image(sprite, x, y);
  }

  void move() {
    y -= 5;
  }
}
