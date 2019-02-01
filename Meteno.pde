class Meteno implements Comparable {
  float x, y;
  float zurex, zurey; //ずれ
  float vely;
  int size; //直径
  float n;
  float s; //スケール値
  float velx = 0;
  float xNoise;
  float ro; //回転
  color c1, c2, c3, c4; //メテノの色（濃い、中間、薄い、模様の色）
  color strokeC = color(229, 80, 40); //線の色
  int sb; //メテノの裏表
  PGraphics pg1, pg2; //マスク
  float strokeW = 2; //線の太さ

  //コンストラクタ
  Meteno(float _x, float _y, float _vely, int _size, int _col) {
    x = _x;
    y = _y;
    vely = _vely;
    size = _size;
    if (size > 40) {
      xNoise = random(0.05); //横揺れ
    } else {
      xNoise = map(vely, minVel, maxVel, 0.001, 0.05); //サイズが40以下の小さいメテノはあまり揺れないようにする
    }
    ro = random(TWO_PI); //回転
    zurex = random(1, 5); //色のずれ
    zurey = random(1, 5);
    sb = int(random(2)); //メテノの裏表
    shapeMode(CENTER);
    imageMode(CENTER);
    metenoColor(_col);
    metenoMask();
    s = 0.01*size;
  }

  void setRotate(float rot) { //回転設定
    ro = rot;
  }

  void setFace(int face) { //メテノの裏表設定,　0=表, 1=裏
    sb = face;
  }

  void move() {
    n = noise(velx)*15.0; //メテノが横に揺れ動く数値
    y -= vely;
    velx = velx + xNoise;

    if (y < 0 - size/2) {
      y = height + size/2;
      x = random(width);
    }
  }

  void display() {
    pushMatrix();
    translate(x+n, y);
    rotate(ro);
    scale(s);
    
    //メテノ色部分
    blendMode(MULTIPLY);
    if (size > 40) {
      image(pg1, 0, 0);
    } else {
      //pushMatrix();
      //scale(s);
      fill(c1); 
      noStroke();
      shape(metenoSvg[0], 0, 0);
      //popMatrix();
    }
    
    //popMatrix();
    
    //rotate(ro);
    
    blendMode(BLEND);
    //pushMatrix();
    //scale(s);
    strokeWeight((1.0 / s) * strokeW);
    noFill();
    stroke(strokeC); //輪郭
    shape(metenoSvg[0], 0, 0);
    //popMatrix();

    if (sb == 0 && size > 40) { //表
      noStroke();
      fill(c2);
      shape(metenoSvg[1], 0, 0); //目
      fill(c3);
      shape(metenoSvg[2], 0, 0); //白目
      fill(c3);
      shape(metenoSvg[3], 0, 0); //くち
      strokeWeight(1);
      strokeJoin(ROUND);
      stroke(c4);
      fill(c4);
      shape(metenoSvg[4], 0, 0); //模様
    } else if (sb == 1 && size > 40) { //裏
      strokeWeight(1);
      strokeJoin(ROUND);
      stroke(c4);
      fill(c4);
      shape(metenoSvg[5], 0, 0); //模様
    }    

    popMatrix();
  }

  void metenoColor(int colorP) {
    switch(colorP) {
    case 0: //red
      c1 = color(7, 33, 99); //濃い色
      c2 = color(7, 20, 99); //中間色
      c3 = color(33, 3, 99); //薄い色
      c4 = color(353, 44, 96); //模様の色
      break;
    case 1: //yellow
      c1 = color(51, 84, 96); //濃い色
      c2 = color(31, 23, 97); //中間色
      c3 = color(34, 11, 99); //薄い色
      c4 = color(45, 89, 95); //模様の色
      break;
    case 2: //orange
      c1 = color(34, 67, 99); //濃い色
      c2 = color(30, 33, 98); //中間色
      c3 = color(60, 1, 100); //薄い色
      c4 = color(0, 44, 96); //模様の色
      break;
    case 3: //blue
      c1 = color(220, 29, 98); //濃い色
      c2 = color(220, 14, 98); //中間色
      c3 = color(255, 3, 100); //薄い色
      c4 = color(220, 29, 68); //模様の色
      break;
    case 4: //green
      c1 = color(146, 19, 85);
      c2 = color(146, 8, 85);
      c3 = color(33, 4, 99);
      c4 = color(146, 19, 68);
      break;
    case 5: //brown
      c1 = color(26, 7, 88);
      c2 = color(37, 12, 98);
      c3 = color(60, 1, 100);
      c4 = color(144, 18, 71);
      break;
    case 6: //purple
      c1 = color(329, 21, 82); //濃い色
      c2 = color(0, 20, 96); //中間色
      c3 = color(40, 1, 100); //薄い色
      c4 = color(325, 26, 76); //模様の色
      break;
    }
  } //metenoColor_end

  void metenoMask() {
    pg1 = createGraphics(100, 100);
    pg2 = createGraphics(100, 100);

    pg1.beginDraw();
    pg1.background(c3);
    pg1.ellipseMode(CENTER);
    pg1.noStroke();
    pg1.fill(c2);
    pg1.ellipse(100/2, 100/2, 100*0.8, 100*0.8);
    pg1.fill(c1);
    pg1.ellipse(100/2, 100/2, 100*0.7, 100*0.7);
    pg1.endDraw();

    pg2.beginDraw();
    pg2.background(0);
    pg2.fill(255, 255, 255);
    pg2.shapeMode(CENTER);
    pg2.pushMatrix();
    pg2.translate(100/2, 100/2);
    pg2.scale(.01*100, .01*100);
    pg2.shape(metenoSvg[0], 0, 0);
    pg2.popMatrix();
    pg2.endDraw();

    pg1.mask(pg2);
  } //metenoMask_end
  
  int compareTo(Object o) {
    Meteno m = (Meteno) o;
    return size-m.size;
  }
}
