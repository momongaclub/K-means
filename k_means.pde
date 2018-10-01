int size = 30;
int n = 100;
int classnumber = 5;
float[] pointx = new float[classnumber];
float[] pointy = new float[classnumber];
float[] ellipsex = new float[n];
float[] ellipsey = new float[n];
int[] cluster = new int[n];
color[] colors = new color[classnumber];

void setup(){
  size(1000,1000);
  background(255);
  for(int i = 0; i < classnumber; i++){
    colors[i] = color(random(255),random(255),random(255));
  }
  for(int i = 0;i < n;i++){
    ellipsex[i] = random(size,1000-size);
    ellipsey[i] = random(size,1000-size);
    cluster[i] = int(random(0,classnumber));
    fill(colors[cluster[i]]);
    //ellipse(x[i],y[i],size,size);
  }
  
  for(int i = 0;i < classnumber;i++){
    fill(colors[i]);
    pointx[i] = random(size, 1000-size);
    pointy[i] = random(size, 1000-size);
    rect(pointx[i],pointy[i],size,size);
  }
}

//ランダムに点を決める
//http://tech.nitoyon.com/ja/blog/2009/04/09/kmeans-visualise/
void draw() {
  
  /*○の配置*/
  background(255);
  for(int i = 0;i < n;i++){
    fill(colors[cluster[i]]);
    ellipse(ellipsex[i],ellipsey[i],size,size);
    for(int j=0;j<classnumber;j++){
     if(cluster[i] == j){
       stroke(colors[cluster[i]]);
      line(ellipsex[i],ellipsey[i],pointx[j]+(size/2),pointy[j]+(size/2)); 
     }
    }
  }
  
  float sumx = 0;
  float sumy = 0;
  for(int i = 0;i < classnumber;i++){
    float cnt = 0;
    fill(colors[i]);
    rect(pointx[i],pointy[i],size,size);
      for(int j = 0;j < n;j++){
        if(cluster[j] == i){// クラス分け
          //print(dist(pointx[i],pointy[i],x[j],y[j]));
          sumx += ellipsex[j];
          sumy += ellipsey[j];
          cnt++;
        }
      }
      sumx = sumx/cnt;
      sumy = sumy/cnt;
      pointx[i] = sumx;
      pointy[i] = sumy;
      frameRate(0.8);
    print(sumx,sumy);
    print('\n');
  }
    
    
    // 各nと全てのclassnumberを比較し一番近いclassnumberをクラスにする
    
    float min;
    int nearpoint=0;
    float dist;
    for(int i=0;i<n;i++){
      min = 100000000;
      for(int j=0;j<classnumber;j++){
        dist = dist(ellipsex[i],ellipsey[i],pointx[j],pointy[j]);
        if(min >= dist){
          min = dist;
          nearpoint = j;
        }
      }
      cluster[i] = nearpoint;
    }
}
