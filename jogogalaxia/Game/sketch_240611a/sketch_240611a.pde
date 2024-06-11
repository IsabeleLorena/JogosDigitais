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
Button nave1Button;
Button nave2Button;

PImage nave1;
PImage nave2;
PImage naveSelecionada;
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

  nave1Button = cp5.addButton("nave1Button")
                   .setPosition(width/2 - 75, height/2 - 120)
                   .setSize(150, 50)
                   .setCaptionLabel("Nave 1");

  nave2Button = cp5.addButton("nave2Button")
                   .setPosition(width/2 - 75, height/2 - 60)
                   .setSize(150, 50)
                   .setCaptionLabel("Nave 2");

  somInicio = new SoundFile(this, "tiro.mp3");
  somPerder = new SoundFile(this, "explosao.mp3");
  somDisparo = new SoundFile(this, "tiro.mp3");

  nave1 = loadImage("Fighter_09.png");
  nave2 = loadImage("nave.png");
  naveSelecionada = nave1; // Nave padrão

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
  nave1Button.show();
  nave2Button.show();
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
  nave1Button.hide();
  nave2Button.hide();
}

void instrucoesButton() {
  tela = 2;
  startButton.hide();
  creditosButton.hide();
  instrucoesButton.hide();
  historiaButton.hide();
  voltarButton.setPosition(width/2 - 75, height/2 + 240);
  voltarButton.show();
  nave1Button.hide();
  nave2Button.hide();
}
void instrucoes() {
  background(planoDeFundo);
  fill(255);
  textSize(24);
  textAlign(CENTER, CENTER);
  text("Instruções do Jogo", width / 2, height / 2 - 100);
  text("1. Use as setas do teclado para mover a nave.", width / 2, height / 2 - 60);
  text("2. Pressione a barra de espaço para disparar lasers.", width / 2, height / 2 - 20);
  text("3. Desvie dos asteroides e destrua-os para ganhar pontos.", width / 2, height / 2 + 20);
  text("4. Cada 100 pontos, você sobe de nível e os asteroides ficam mais rápidos.", width / 2, height / 2 + 60);
  text("5. Você começa com 3 vidas. Se todas as vidas acabarem, o jogo termina.", width / 2, height / 2 + 100);
}
void creditos() {
  background(planoDeFundo);
  fill(255);
  textSize(24);
  textAlign(CENTER, CENTER);
  text("Créditos", width / 2, height / 2 - 100);
  text("Beatriz", width / 2, height / 2 - 60);
  text("Jean", width / 2, height / 2 - 20);
  text("Isabele", width / 2, height / 2 + 20);
  text("Paulo", width / 2, height / 2 + 60);
}

void historia() {
  background(planoDeFundo);
  fill(255);
  textSize(24);
  textAlign(CENTER, CENTER);
  text("História", width / 2, height / 2 - 100);
  text("No ano 3021, a galáxia está sob ataque de uma frota de asteroides.", width / 2, height / 2 - 60);
  text("Você é o último piloto sobrevivente de uma força de defesa espacial.", width / 2, height / 2 - 20);
  text("Sua missão é destruir os asteroides e proteger a galáxia.", width / 2, height / 2 + 20);
  text("Prepare-se para a batalha e boa sorte, piloto!", width / 2, height / 2 + 60);
}

void historiaButton() {
  tela = 4;
  startButton.hide();
  creditosButton.hide();
  instrucoesButton.hide();
  historiaButton.hide();
  voltarButton.setPosition(width/2 - 75, height/2 + 240);
  voltarButton.show();
  nave1Button.hide();
  nave2Button.hide();
}

void voltarButton() {
  tela = 0;
  startButton.show();
  creditosButton.show();
  instrucoesButton.show();
  historiaButton.show();
  voltarButton.hide();
  restartButton.hide();
  nave1Button.show();
  nave2Button.show();
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
  nave1Button.hide();
  nave2Button.hide();
}

void nave1Button() {
  naveSelecionada = nave1;
}

void nave2Button() {
  naveSelecionada = nave2;
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
  image(naveSelecionada, naveX, naveY, larguraNave, alturaNave);
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
    image(asteroides[int(random(0, 3))], asteroide.x, asteroide.y, 40, 40);
    if (asteroide.x < 0) {
      listaAsteroides.remove(i);
    }
  }
}

void verificarColisao() {
  for (int i = listaAsteroides.size() - 1; i >= 0; i--) {
    Asteroide asteroide = listaAsteroides.get(i);
    if (dist(naveX, naveY, asteroide.x, asteroide.y) < 25) {
      vidas--;
      somPerder.play();
      listaAsteroides.remove(i);
      if (vidas <= 0) {
        tela = 5;
        startButton.hide();
        creditosButton.hide();
        instrucoesButton.hide();
        historiaButton.hide();
        restartButton.show();
      }
    }
    for (int j = lasers.size() - 1; j >= 0; j--) {
      Laser laser = lasers.get(j);
      if (dist(laser.x, laser.y, asteroide.x, asteroide.y) < 20) {
        pontuacao += 10;
        image(explosao, asteroide.x, asteroide.y, 40, 40);
        listaAsteroides.remove(i);
        lasers.remove(j);
        break;
      }
    }
  }
}

void desenharPontuacao() {
  fill(255);
  textSize(24);
  text("Pontuação: " + pontuacao, 10, 25);
}

void desenharVidas() {
  fill(255);
  textSize(24);
  text("Vidas: " + vidas, 10, 50);
}

void verificarPontuacao() {
  if (pontuacao >= 100) {
    nivelDificuldade++;
    pontuacao = 0;
    velocidadeAsteroide++;
    vidas = 3;
    listaAsteroides.clear();
    lasers.clear();
  }
}

void gameOver() {
  background(0);
  fill(255, 0, 0);
  textSize(48);
  textAlign(CENTER, CENTER);
  text("Game Over", width/2, height/2);
  restartButton.show();
  voltarButton.show();
  nave1Button.show();
  nave2Button.show();
}

void restartButton() {
  iniciarJogo();
}

class Asteroide {
  float x, y, velocidade;

  Asteroide(float x, float y, float velocidade) {
    this.x = x;
    this.y = y;
    this.velocidade = velocidade;
  }

  void mover() {
    x -= velocidade;
  }
}

class Laser {
  float x, y;

  Laser(float x, float y) {
    this.x = x;
    this.y = y;
  }

  void mover() {
    x += 5;
  }
}
