import processing.sound.*;
import java.util.ArrayList;
import controlP5.*;

ControlP5 cp5;
Button startButton;
Button creditosButton;
Button instrucoesButton;
Button historiaButton;
Button voltarButton;
Button restartButton;

PImage nave;
PImage[] asteroides = new PImage[3];
PImage explosao;
PImage planoDeFundo;
PImage laserImg;

SoundFile somInicio;
SoundFile somPerder;
SoundFile somDisparo;

int tela = 0;
int pontuacao = 0;
int vidas = 3;
int corFundo = color(0, 0, 255);
int nivelDificuldade = 1;
int velocidadeAsteroide = 1;

float naveX, naveY;
int larguraNave = 50;
int alturaNave = 50;

ArrayList<Asteroide> listaAsteroides = new ArrayList<Asteroide>();
ArrayList<Laser> lasers = new ArrayList<Laser>();

void setup() {
  size(800, 600);
  cp5 = new ControlP5(this);
  startButton = cp5.addButton("startButton")
                   .setPosition(width/2 - 75, height/2)
                   .setSize(150, 50)
                   .setCaptionLabel("Start Game");
  creditosButton = cp5.addButton("creditosButton")
                     .setPosition(width/2 - 75, height/2 + 60)
                     .setSize(150, 50)
                     .setCaptionLabel("Créditos");
  instrucoesButton = cp5.addButton("instrucoesButton")
                     .setPosition(width/2 - 75, height/2 + 120)
                     .setSize(150, 50)
                     .setCaptionLabel("Instruções");
  historiaButton = cp5.addButton("historiaButton")
                     .setPosition(width/2 - 75, height/2 + 180)
                     .setSize(150, 50)
                     .setCaptionLabel("História");

  voltarButton = cp5.addButton("voltarButton")
                    .setPosition(width/2 - 75, height/2 + 240)
                    .setSize(150, 50)
                    .setCaptionLabel("Voltar")
                    .hide();
  
  restartButton = cp5.addButton("restartButton")
                    .setPosition(width/2 - 75, height/2 + 60)
                    .setSize(150, 50)
                    .setCaptionLabel("Restart")
                    .hide();

  somInicio = new SoundFile(this, "tiro.mp3");
  somPerder = new SoundFile(this, "explosao.mp3");
  somDisparo = new SoundFile(this, "tiro.mp3");

  nave = loadImage("Fighter_09.png");
  asteroides[0] = loadImage("asteroide1.png");
  asteroides[1] = loadImage("asteroide2.png");
  asteroides[2] = loadImage("asteroide3.png");
  explosao = loadImage("explosao.png");
  planoDeFundo = loadImage("planoDeFundo.png");
  laserImg = loadImage("laser.png");

  planoDeFundo.resize(width, height);
}

void draw() {
  if (tela == 0) {
    menuInicial();
  } else if (tela == 1) {
    jogo();
    verificarPontuacao();
  } else if (tela == 2) {
    instrucoes();
  } else if (tela == 3) {
    creditos();
  } else if (tela == 4) {
    historia();
  } else if (tela == 5) {
    gameOver();
  }
}

void menuInicial() {
  background(planoDeFundo);
  fill(255);
  textSize(48);
  textFont(createFont("Amasis MT Pro Black", 60));
  textAlign(CENTER, CENTER);
  text("Atacando na Galaxia", width/2, height/2 - 60);
  cp5.getController("startButton").setSize(200, 70);
  cp5.getController("creditosButton").setSize(200, 70);
  cp5.getController("instrucoesButton").setSize(200, 70);
  cp5.getController("historiaButton").setSize(200, 70);
 
  startButton.show();
  creditosButton.show();
  instrucoesButton.show();
  historiaButton.show();
  voltarButton.hide();
  restartButton.hide();
}

void startButton() {
  iniciarJogo();
}

void creditosButton() {
  tela = 3;
  startButton.hide();
  creditosButton.hide();
  instrucoesButton.hide();
  historiaButton.hide();
  voltarButton.setPosition(width/2 - 75, height/2 + 240);
  voltarButton.show();
}

void instrucoesButton() {
  tela = 2;
  startButton.hide();
  creditosButton.hide();
  instrucoesButton.hide();
  historiaButton.hide();
  voltarButton.setPosition(width/2 - 75, height/2 + 240);
  voltarButton.show();
}

void historiaButton() {
  tela = 4;
  startButton.hide();
  creditosButton.hide();
  instrucoesButton.hide();
  historiaButton.hide();
  voltarButton.setPosition(width/2 - 75, height/2 + 240);
  voltarButton.show();
}

void voltarButton() {
  tela = 0;
  startButton.show();
  creditosButton.show();
  instrucoesButton.show();
  historiaButton.show();
  voltarButton.hide();
  restartButton.hide();
}

void iniciarJogo() {
  tela = 1;
  pontuacao = 0;
  vidas = 3;
  somInicio.play();
  startButton.hide();
  creditosButton.hide();
  instrucoesButton.hide();
  historiaButton.hide();
  voltarButton.hide();
  restartButton.hide();
}

void jogo() {
  background(planoDeFundo);
  desenharNave();
  atualizarNave();
  criarAsteroides();
  desenharAsteroides();
  desenharLasers();
  verificarColisao();
  desenharPontuacao();
  desenharVidas();
}

void desenharNave() {
  image(nave, naveX, naveY, larguraNave, alturaNave);
}

void atualizarNave() {
  if (keyPressed && keyCode == UP) {
    naveY -= 5;
  }
  if (keyPressed && keyCode == DOWN) {
    naveY += 5;
  }
  if (keyPressed && keyCode == LEFT) {
    naveX -= 5;
  }
  if (keyPressed && keyCode == RIGHT) {
    naveX += 5;
  }
  naveX = constrain(naveX, 0, width - larguraNave);
  naveY = constrain(naveY, 0, height - alturaNave);

  if (keyPressed && key == ' ') {
    dispararLaser();
  }
}

void dispararLaser() {
  Laser laser = new Laser(naveX + larguraNave, naveY + alturaNave/2);
  lasers.add(laser);
  somDisparo.play();
}

void desenharLasers() {
  for (int i = lasers.size() - 1; i >= 0; i--) {
    Laser laser = lasers.get(i);
    laser.mover();
    rect(laser.x, laser.y, 5, 2);
    if (laser.x > width) {
      lasers.remove(i);
    }
  }
}

void criarAsteroides() {
  if (frameCount % (60 / velocidadeAsteroide) == 0) {
    float x = width;
    float y = random(height);
    float vel = random(1, 3);
    Asteroide asteroide = new Asteroide(x, y, vel);
    listaAsteroides.add(asteroide);
  }
}

void desenharAsteroides() {
  for (int i = listaAsteroides.size() - 1; i >= 0; i--) {
    Asteroide asteroide = listaAsteroides.get(i);
    asteroide.mover();
    int indexAsteroides = nivelDificuldade - 1;
    if (indexAsteroides >= 0 && indexAsteroides < asteroides.length) {
      image(asteroides[indexAsteroides], asteroide.posX, asteroide.posY, 50, 50);
    }
  }
  
  for (int i = listaAsteroides.size() - 1; i >= 0; i--) {
    Asteroide asteroide = listaAsteroides.get(i);
    if (asteroide.posX < -50) {
      listaAsteroides.remove(i);
    }
  }
}

void verificarColisao() {
  for (int i = listaAsteroides.size() - 1; i >= 0; i--) {
    Asteroide asteroide = listaAsteroides.get(i);
    for (int j = lasers.size() - 1; j >= 0; j--) {
      Laser laser = lasers.get(j);
      if (laser.x < asteroide.posX + 50 && laser.x + 10 > asteroide.posX &&
          laser.y < asteroide.posY + 50 && laser.y + 10 > asteroide.posY) {
        listaAsteroides.remove(i);
        lasers.remove(j);
        pontuacao += 10;
      }
    }
    if (naveX < asteroide.posX + 50 && naveX + larguraNave > asteroide.posX &&
        naveY < asteroide.posY + 50 && naveY + alturaNave > asteroide.posY) {
      listaAsteroides.remove(i);
      vidas--;
      somPerder.play();
      if (vidas == 0) {
        gameOver();
      }
    }
  }
}

void verificarPontuacao() {
  if (pontuacao >= 50 && nivelDificuldade == 1) {
    nivelDificuldade = 2;
    velocidadeAsteroide = 20;
  } else if (pontuacao >= 120 && nivelDificuldade == 2) {
    nivelDificuldade = 3;
    velocidadeAsteroide = 25;
  }
}

void gameOver() {
  tela = 5;
  background(0);
  fill(255);
  textSize(32);
  textAlign(CENTER, CENTER);
  text("Game Over", width/2, height/2 - 50);
  text("Pontuação: " + pontuacao, width/2, height/2);
  restartButton.show();
}

void desenharPontuacao() {
  fill(255);
  textSize(16);
  textAlign(LEFT);
  text("Pontuação: " + pontuacao, 10, 20);
}

void desenharVidas() {
  fill(255);
  textSize(16);
  textAlign(RIGHT);
  text("Vidas: " + vidas, width - 10, 20);
}

void instrucoes() {
  background(corFundo);
  fill(255);
  textSize(24);
  textAlign(CENTER, CENTER);
  text("Instruções", width/2, height/2 - 100);
  textSize(16);
  text("Use as setas do teclado para mover a nave", width/2, height/2 - 50);
  text("Pressione a barra de espaço para disparar o laser", width/2, height/2);
  text("Destrua os asteroides para ganhar pontos", width/2, height/2 + 50);
  text("Evite colidir com os asteroides para não perder vidas", width/2, height/2 + 100);
  text("Quando fizer 50 pontos a velociade aumenta e ao chegar em 100 pontos, aumenta mais um pouco", width/2, height/2 + 150);
}

void creditos() {
  background(corFundo);
  fill(255);
  textSize(24);
  textAlign(CENTER, CENTER);
  text("Créditos", width/2, height/2 - 100);
  textSize(16);
  text("Desenvolvido por:", width/2, height/2 - 50);
  text("Beatriz Tayna", width/2, height/2);
  text("Dieuphenson Jean", width/2, height/2 + 50);
  text("Isabele Lorena", width/2, height/2 + 100);
  text("Paulo Sergio", width/2, height/2 + 150);

 
}

void historia() {
  background(corFundo);
  fill(255);
  textSize(24);
  textAlign(CENTER, CENTER);
  text("História", width/2, height/2 - 100);
  textSize(16);
  text("Em um futuro distante, a Terra está sob ataque constante", width/2, height/2 - 50);
  text("de asteroides. Você, como o piloto da nave estelar", width/2, height/2);
  text("mais avançada, é a última esperança para proteger", width/2, height/2 + 50);
  text("nosso planeta. Sua missão é destruir todos os asteroides e planetas intrusos", width/2,height/2 + 100);
  text("antes que eles atinjam a Terra. Boa sorte, piloto!", width/2, height/2 + 150);
}

void restartButton() {
  iniciarJogo();
}

void keyPressed() {
  if (key == ' ' && tela == 0) {
    iniciarJogo();
  }
  if (key == ' ' && tela == 2) {
    tela = 0;
        startButton.show();
    creditosButton.show();
    instrucoesButton.show();
    historiaButton.show();
  }
  if (key == ' ' && tela == 4) {
    tela = 0;
    startButton.show();
    creditosButton.show();
    instrucoesButton.show();
    historiaButton.show();
  }
}

class Asteroide {
  float posX, posY;
  float velocidade;

  Asteroide(float x, float y, float vel) {
    posX = x;
    posY = y;
    velocidade = vel;
  }

  void mover() {
    posX -= velocidade;
  }
}

class Laser {
  float x, y;
  float velocidade = 10;

  Laser(float x, float y) {
    this.x = x;
    this.y = y;
  }

  void mover() {
    x += velocidade;
  }
}
