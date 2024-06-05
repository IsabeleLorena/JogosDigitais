class GameGalaxy {
  Player player;
  ArrayList<Enemy> enemies;
  ArrayList<Bullet> bullets;
  PImage background;
  int score;
  int difficulty;
  PImage[] bulletSprites;
  int tempo;
  boolean sp;

  GameGalaxy(PImage playerSprite, PImage[] enemySprites, PImage[] bulletSprites, PImage background) {
    this.player = new Player(playerSprite);
    this.enemies = new ArrayList<Enemy>();
    this.bullets = new ArrayList<Bullet>();
    this.background = background;
    this.score = 0;
    this.difficulty = 1;
    this.bulletSprites = bulletSprites;

    for (int i = 0; i < enemySprites.length; i++) {
      enemies.add(new Enemy(enemySprites[i], i * 100, 100, difficulty * 0.5f));
    }
  }

  void setDifficulty
