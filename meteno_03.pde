import java.util.*;

int METENO_NUM = 30; // メテノの数
Meteno[] metenos; // 配列を宣言
Bebenomu bebenomu; //ベベノム
int bSize = 200; //ベベノムの大きさ
float minSize = 25.0; //メテノの大きさ（最小）
float maxSize = 105.0; //メテノの大きさ（最大）
float minVel = 0.1; //メテノが上に上がる速さ（最小）
float maxVel = 1.8; //メテノが上に上がる速さ（最大）

//背景
color back; //背景色
Starrysky[] starrysky; //背景の星
int ss = 18; //背景の星の数

PShape[] metenoSvg;

void setup() {
  size(300, 800);
  colorMode(HSB, 360, 100, 100);
  back = color(0, 0, 99); //背景色
  
  PShape mSvg = loadShape("meteno.svg");
  mSvg.disableStyle();
  metenoSvg = new PShape[6];
  for (int i = 0; i < metenoSvg.length; i++) {
    String svgName = nf(i, 1);
    metenoSvg[i] = mSvg.getChild(svgName);
  }
  
  metenos = new Meteno[METENO_NUM];
  starrysky = new Starrysky[ss]; //背景の星
  for (int i = 0; i < ss; i++){
  starrysky[i] = new Starrysky(i);
  }
  
  for (int i = 0; i < METENO_NUM; i++) {
    float x = random(width);
    float y = random(height);
    float v = random(1);
    float vely= minVel + (pow(v, 2) * (maxVel-minVel));
    float r = map(vely, minVel, maxVel, minSize, maxSize);
    int size = int(r); //メテノの大きさ（上にあがる速さと比例してる）
    int col = int(random(7)); //メテノの色
    metenos[i] = new Meteno(x, y, vely, size, col);
  }
  
  Arrays.sort(metenos);
  
  float be = random(width-100, width-70); // べべノムのx値
  bebenomu = new Bebenomu(be, height/2, bSize);
  
}

void draw() {
  background(back);
  for (int i = 0; i < ss; i++){ //背景の星
  starrysky[i].display();
  }
  
  for (int i = 0; i < METENO_NUM; i++) {
    if(metenos[i].size < bSize/2){
    metenos[i].move();
    metenos[i].display();
    }
  }
  
  bebenomu.move();
  bebenomu.display();
  
  for (int i = 0; i < METENO_NUM; i++) {
    if(metenos[i].size > bSize/2){
    metenos[i].move();
    metenos[i].display();
    }
  }
}

void keyReleased() {
  if (key == 's' || key == 'S')saveFrame(timestamp()+"_####.png");
}


String timestamp() {
  Calendar now = Calendar.getInstance();
  return String.format("%1$ty%1$tm%1$td_%1$tH%1$tM%1$tS", now);
}
