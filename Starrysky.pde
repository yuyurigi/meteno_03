class Starrysky {
  float x, y;
  float size;
  float zurex, zurey;
  color c1;
  int s;
  int number;
  float R;
  float ro;
  color strokeC = color(229, 80, 40); //線の色
  
  Starrysky(int _number){
    x = random(width);
    y = random(height);
    size = random(8, 16);
    zurex = random(1, 3); //色のずれx値
    zurey = random(1, 3); //色のずれy値
    int c = int(random(7));
    metenoColor(c);
    s = int(random(2));
    ro = random(360);
  }
  
  void display(){
    if (number < ss*0.6) {
    //丸の色部分
    noStroke();
    fill(c1);
    ellipse(x+zurex, y+zurey, size, size);
    //丸の線部分
    strokeWeight(2);
    noFill();
    stroke(strokeC);
    ellipse(x, y, size, size);
  } else {
    
    switch(s) {
    case 0: //線だけの丸 塗りなし
    strokeWeight(2);
    stroke(strokeC);
    noFill();
    ellipse(x, y, size, size);
    break;
    case 1: //星
    pushMatrix();
    translate(x, y);
    rotate(radians(ro));
    fill(c1);
    stroke(c1);
    strokeWeight(4);
    strokeJoin(ROUND);
    beginShape();
    for(int i = 0; i < 10; i++) {
      if(i%2 == 0){
        R = size*0.6;
      } else {
        R = size*0.6/2;
      }
      vertex(R * cos(radians(360*i/10)), R * sin(radians(360*i/10)));
    }
    endShape(CLOSE);
    popMatrix();
  }
  }
  }
  
  
  void metenoColor(int colorP) {
    switch(colorP) {
    case 0: //red
      c1 = color(7, 33, 99); //濃い色
      break;
    case 1: //yellow
      c1 = color(51, 84, 96); //濃い色
      break;
    case 2: //orange
      c1 = color(34, 67, 99); //濃い色
      break;
    case 3: //blue
      c1 = color(220, 29, 98); //濃い色
      break;
    case 4: //green
      c1 = color(146, 19, 85);
      break;
    case 5: //brown
      c1 = color(26, 7, 88);
      break;
    case 6: //purple
      c1 = color(329, 21, 82); //濃い色
      break;
    }
  } //metenoColor_end
}
