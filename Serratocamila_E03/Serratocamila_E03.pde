// Nombre: María Camila Serrato
// Código: 202410329
// Descripción: Paisaje de una casa en la colina. Imitación de un amanecer y atardecer en loop infinito.
// El sol sube y baja de forma continua mientras el cielo cambia de color.
// Los pájaros vuelan libremente en la parte superior del cielo, rebotando en los bordes.


//Definir variables

float solY = 400; //posición donde inicia el sol
int direccionSol = -1;  // -1: sube, 1: baja
int numBirds = 5;

// Arrays -> Posición, Velocidad, Dirección

float[] birdX;
float[] birdY;

float[] velocidadX;
float[] velocidadY;

int[] direccionX;
int[] direccionY;


void setup() {
  size(700, 400);
  noStroke();

  // Definir el tamaño de los Arrays

  birdX = new float[numBirds];
  birdY = new float[numBirds];

  velocidadX = new float[numBirds];
  velocidadY = new float[numBirds];

  direccionX = new int[numBirds];
  direccionY = new int[numBirds];

  // Inicializar cada pájaro con posiciones, velocidad y dirección aleatoria

  for (int i = 0; i < numBirds; i++) {
    
    birdX[i] = random(width); // pájaros viajan de lado a lado
    birdY[i] = random(height / 2); // pájaros bajan solo hasta la mitad del canvas
    
    velocidadX[i] = random(0.5, 1.5);
    velocidadY[i] = random(0.5, 1);
    
    direccionX[i] = random(1) > 0.5 ? 1 : -1;
    direccionY[i] = random(1) > 0.5 ? 1 : -1;
  }
}

void draw() {

  // El fondo cambia de color según la posición del sol:
  // Cielo se aclara mientras el sol sube y oscurece al bajar

//                    si solY está 400 color es 120, si esta en 100 el color es 210
//                    map(valor, minOriginal, maxOriginal, minNuevo, maxNuevo)     
  float cieloBrillo = map(solY,     400,         100,        120,      210);
  background(cieloBrillo, cieloBrillo + 40, cieloBrillo + 255);

  // Sol

  fill(255, 200, 0);
  ellipse(width / 2, solY, 80, 80);
  solY += 0.4 * direccionSol;

  // Rebotar entre límites (simula amanecer y atardecer eternos)

  if (solY < 100 || solY > 400) {
    direccionSol *= -1;  // Invierte la dirección ("rebote")
  }

  // Colina

  fill(120, 200, 120);
  arc(width / 2, height + 100, 800, 400, PI, TWO_PI);

  // Variables Casa

  float casaX = width / 2 - 5;
  float casaY = height - 140;

  fill(230, 239, 239);
  rect(casaX, casaY, 100, 80);
  fill(54, 72, 74);
  triangle(casaX - 10, casaY, casaX + 50, casaY - 40, casaX + 110, casaY);
  fill(50, 38, 18);
  rect(casaX + 35, casaY + 30, 30, 50);

  // Pajaritos volando

  stroke(0);
  strokeWeight(2);

  for (int i = 0; i < numBirds; i++) {
    birdX[i] += velocidadX[i] * direccionX[i];
    birdY[i] += velocidadY[i] * direccionY[i];

    // Rebote cuando llega al extremo derecho O al extremo izquierdo

    if (birdX[i] > width                      || birdX[i] < 0) {
      direccionX[i] = direccionX[i] * -1;
    }

    // Rebote cuando llega arriba O abajo

    if (birdY[i] > height / 2     || birdY[i] <= 0) {
      direccionY[i] = direccionY[i] * -1;
    }

    // Dibujar "V" del pájaro

    line(birdX[i], birdY[i], birdX[i] + 5, birdY[i] + 5);
    line(birdX[i] + 5, birdY[i] + 5, birdX[i] + 10, birdY[i]);
  }
  noStroke();
}
