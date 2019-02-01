class Bebenomu { //<>//
  float x, y;
  int size;
  Meteno meteno;
  float n;
  float velx, vely;
  float xNoise;
  float strokeW = 2; //線の太さ
  color strokeC = color(229, 80, 40); //線の色
  color murasaki = color(317, 29, 73);
  color pink = color(4, 34, 98);
  color white = color(53, 7, 92);
  color mizuiro = color(186, 37, 95);
  float s; //スケール値
  float zure = 1; //色のずれ
  PShape[] bebes = new PShape[8];

  Bebenomu(float _x, float _y, int _size) {
    x = _x;
    y = _y;
    size = _size;
    shapeMode(CENTER);

    PShape bebenomuSvg = loadShape("bebenomu.svg");
    bebenomuSvg.disableStyle();
    for (int i = 0; i < bebes.length; i++) {
      String svgName = nf(i, 1);
      bebes[i] = bebenomuSvg.getChild(svgName);
    }

    meteno = new Meteno(0, 0, 0, size/2, 2);
    meteno.setRotate(radians(-20));
    meteno.setFace(0);
    vely = map(size/2, minSize, maxSize, minVel, maxVel);
    velx = 0;
    xNoise = 0.02;
    s = 0.01*size;
  }

  void move() {
    n = noise(velx)*15.0; //メテノが横に揺れ動く数値
    y -= vely;
    velx = velx + xNoise;

    if (y < 0 - size/2) {
      y = height + size/2;
      x = random(width-80, width-50);
    }
  }

  void display() {
    pushMatrix();
    translate(x+n, y);
    strokeWeight(1.0/s * strokeW);

    pushMatrix();
    scale(s);
    fill(back);
    noStroke();
    shape(bebes[2], 0, 0);

    pushMatrix(); //ベベノム（下半身）色部分
    translate(zure, zure);
    fill(murasaki);
    shape(bebes[0], 0, 0);
    fill(pink);
    shape(bebes[1], 0, 0);
    popMatrix();

    noFill(); //ベベノム（下半身）線
    stroke(strokeC);
    shape(bebes[2], 0, 0); 
    popMatrix();

    meteno.display(); //メテノ

    pushMatrix();
    scale(s);
    fill(back);
    noStroke();
    shape(bebes[7], 0, 0);

    pushMatrix(); //ベベノム（上半身）色部分
    translate(zure, zure);
    fill(murasaki);
    noStroke();
    shape(bebes[3], 0, 0);
    fill(pink);
    shape(bebes[4], 0, 0);
    fill(white);
    shape(bebes[5], 0, 0);
    fill(mizuiro);
    shape(bebes[6], 0, 0);
    popMatrix();

    noFill(); //ベベノム（上半身）線
    stroke(strokeC);
    shape(bebes[7], 0, 0);
    popMatrix();

    popMatrix();
  }
}
