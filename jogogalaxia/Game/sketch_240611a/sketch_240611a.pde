import processing.sound.*;
import java.util.ArrayList;
import controlP5.*;

ControlP5 cp5;
Button startButton;
Button creditosButton;
Button instrucoesButton;
Button historiaButton;
Button voltarButton;

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

  somInicio = new SoundFile(this, "tiro.mp3");
  somPerder = new SoundFile(this, "explosao.mp3");
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
  } else if (tela == 4) {
    historia();
  }
}

void menuInicial() {
  background(planoDeFundo); // Alterando o fundo para a imagem do jogo
  fill(255);
  textSize(24);
  textAlign(CENTER, CENTER);
  text("Asteroides: A Missão Estelar", width/2, height/2 - 50);
  startButton.show();
  creditosButton.show();
  instrucoesButton.show();
  historiaButton.show();
  voltarButton.hide();
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
  voltarButton.setPosition(width/2 - 75, height/2 + 240); // Ajustar a posição do botão Voltar
  voltarButton.show();
}

void instrucoesButton() {
  tela = 2;
  startButton.hide();
  creditosButton.hide();
  instrucoesButton.hide();
  historiaButton.hide();
  voltarButton.setPosition(width/2 - 75, height/2 + 240); // Ajustar a posição do botão Voltar
  voltarButton.show();
}

void historiaButton() {
  tela = 4;
  startButton.hide();
  creditosButton.hide();
  instrucoesButton.hide();
  historiaButton.hide();
  voltarButton.setPosition(width/2 - 75, height/2 + 240); // Ajustar a posição do botão Voltar
  voltarButton.show();
}

void voltarButton() {
  tela = 0;
  startButton.show();
  creditosButton.show();
  instrucoesButton.show();
  historiaButton.show();
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
      // Voltando a imagem da nave
      naveX = width / 2;
      naveY = height / 2;
      // Tocando o som de explosão
      somPerder.play();
      // Ajuste para evitar vidas negativas
      if (vidas < 0) {
        vidas = 0;
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
  text("[Nome do Desenvolvedor 4]", width/2, height/2 + 150);
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
  text("nosso planeta. Sua missão é destruir todos os asteroides", width/2, height/2 + 100);
  text("antes que eles atinjam a Terra. Boa sorte, piloto!", width/2, height/2 + 150);
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
