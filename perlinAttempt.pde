Perlin p;
void setup(){
  size(1600,900);
  p = new Perlin(7,0.5);
  c1=1;
  c2=10000;
}

float c1,c2;

void draw(){
  background(150);
  pushMatrix();
  scale(1,-1);
  translate(0,-height/2);
  float px=0;
  float py=p.getNoise(px);
  for(float x=0;x<width;x+=1){
    float y = 100*p.getNoise(x/500);
    line(px,py,x,y);
    px=x;
    py=y;
  }
  popMatrix();
  
  
  ellipse(width/2+200*p.getNoise(c1),height/2+200*p.getNoise(c2),50,50);
  c1+=0.005;
  c2+=0.005;
}

class Perlin{
  ArrayList<Integer> primeNumbers;
  float randomOffsetX;
  float randomOffsetY;
  int[] steps;
  float stepMultD;
  Perlin(int stepCount, float stepMultD){
    primeNumbers = primeNumbers(1000+stepCount);
    this.stepMultD = stepMultD;
    steps = new int[stepCount];
    for(int i=0;i<stepCount;i++){
      int pNum = primeNumbers.get(round(random(0,primeNumbers.size())));
      steps[i] = round(random(1,100));
    }
    randomOffsetX = random(-1000,1000);
    randomOffsetY = random(-1000,1000);
  }
  
  float getNoise(float x){
    float val = 0;
    float stepMult=0.5;
    for(int i=0;i<steps.length;i++){
      val+=stepMult*sin(steps[i]*x);
      stepMult*=stepMultD;
    }
    return val;
  }
  
  private ArrayList<Integer> primeNumbers(int count){
    ArrayList<Integer> pNums = new ArrayList<Integer>();
    int curI=1;
    while(pNums.size()<count){
      curI++;
      for(int num:pNums){
        if(curI%num==0){
          continue;
        }
      }
      pNums.add(curI);
    }
    return pNums;
    
  }
}