import processing.sound.*;
import java.util.ArrayList;

PImage nave;
PImage[] asteroides = new PImage[3];
PImage explosao;
PImage planoDeFundo;

SoundFile somInicio;
SoundFile somPerder;

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

void setup() {
  size(800, 600);
  somInicio = new SoundFile(this, "tiro.mp3");
  somPerder = new SoundFile(this, "explosaor.mp3");
  nave = loadImage("Fighter_09.png");
  asteroides[0] = loadImage("asteroide1.png");
  asteroides[1] = loadImage("asteroide2.png");
  asteroides[2] = loadImage("asteroide3.png");
  explosao = loadImage("explosao.png");
  planoDeFundo = loadImage("planoDeFundo.png");
  planoDeFundo.resize(width, height); // Redimensionando a imagem para o tamanho da tela
}

void draw() {
  if (tela == 0) {
    menuInicial();
  } else if (tela == 1) {
    jogo();
  } else if (tela == 2) {
    instrucoes();
  } else if (tela == 3) {
    creditos();
  }
}

void menuInicial() {
  background(corFundo);
  fill(255);
  textSize(24);
  textAlign(CENTER, CENTER);
  text("Asteroides: A Missão Estelar", width/2, height/2 - 50);
  textSize(16);
  text("Pressione 'Espaço' para iniciar", width/2, height/2 + 50);
}

void iniciarJogo() {
  tela = 1;
  pontuacao = 0;
  vidas = 3;
  somInicio.play();
}

void jogo() {
  background(planoDeFundo);
  desenharNave();
  atualizarNave();
  criarAsteroides();
  desenharAsteroides();
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
    image(asteroides[nivelDificuldade - 1], asteroide.posX, asteroide.posY, 50, 50);
    if (asteroide.posX < -50) {
      listaAsteroides.remove(i);
    }
  }
}

void verificarColisao() {
  for (int i = listaAsteroides.size() - 1; i >= 0; i--) {
    Asteroide asteroide = listaAsteroides.get(i);
    if (naveX < asteroide.posX + 50 && naveX + larguraNave > asteroide.posX &&
        naveY < asteroide.posY + 50 && naveY + alturaNave > asteroide.posY) {
      listaAsteroides.remove(i);
      vidas--;
      somPerder.play();
      if (vidas == 0) {
        tela = 0;
      }
    }
  }
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
  text("Destrua os asteroides para ganhar pontos", width/2, height/2);
  text("Evite colidir com os asteroides para não perder vidas", width/2, height/2 + 50);
  text("Pressione 'Espaço' para retornar ao menu", width/2, height/2 + 100);
}

void creditos() {
  background(corFundo);
  fill(255);
  textSize(24);
  textAlign(CENTER, CENTER);
  text("Créditos", width/2, height/2 - 100);
  textSize(16);
  text("Desenvolvido por:", width/2, height/2 - 50);
  text("[Nome do Desenvolvedor 1]", width/2, height/2);
  text("[Nome do Desenvolvedor 2]", width/2, height/2 + 50);
  text("[Nome do Desenvolvedor 3]", width/2, height/2 + 100);
}

void keyPressed() {
  if (key == ' ' && tela == 0) {
    iniciarJogo();
  }
  if (key == ' ' && tela == 2) {
    tela = 0;
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
