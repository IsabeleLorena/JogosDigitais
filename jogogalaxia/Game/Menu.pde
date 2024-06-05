class Menu {
  void display() {
    background(0);
    fill(255);
    textSize(32);
    textAlign(CENTER);
    text("Atacando na Galáxia", width / 2, height / 2 - 100);
    textSize(24);
    text("Pressione '1' para Fácil", width / 2, height / 2);
    text("Pressione '2' para Médio", width / 2, height / 2 + 40);
    text("Pressione '3' para Difícil", width / 2, height / 2 + 80);
    text("Pressione 'I' para Instruções", width / 2, height / 2 + 120);
    text("Pressione 'C' para Créditos", width / 2, height / 2 + 160);
  }
  
  void handleMousePress() {

  }
  
  void showInstructions() {
    background(0);
    fill(255);
    textSize(24);
    textAlign(CENTER);
    text("Instruções", width / 2, height / 2 - 100);
    textSize(16);
    text("Use as setas para mover.", width / 2, height / 2 - 60);
    text("Pressione espaço para atirar.", width / 2, height / 2 - 40);
    text("Evite naves inimigas e seus projéteis.", width / 2, height / 2 - 20);
    text("Pressione qualquer tecla para voltar ao menu.", width / 2, height / 2 + 20);
  }
  
  void showCredits() {
    background(0);
    fill(255);
    textSize(24);
    textAlign(CENTER);
    text("Créditos", width / 2, height / 2 - 100);
    textSize(16);
    text("Beatriz Tayna", width / 2, height / 2 - 60);
    text("Dieuphenson Jean", width / 2, height / 2 - 40);
    text("Isabele Lorena", width / 2, height / 2 - 20);
    text("Paulo Sergio", width / 2, height / 2);
    text("Pressione qualquer tecla para voltar ao menu.", width / 2, height / 2 + 40);
  }
}
