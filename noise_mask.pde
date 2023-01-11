float falseThreshold = 0.5;
float trueThreshold = 0.5;
float falseTarget = 0.8;
float trueTarget = 0;
int numFrames = 40;
int totalFrames;

OpenSimplexNoise noise = new OpenSimplexNoise();
PImage img;
PImage mask1;
PImage mask2;

void setup(){

  size(800, 800);
  mask1 = loadImage("seilMask.png");
  mask1.filter(GRAY);
  //mask1.resize(200, 200);
  mask1.loadPixels();
  
  mask2 = loadImage("dipsMask.png");
  mask2.filter(GRAY);
  //mask2.resize(200, 200);
  mask2.loadPixels();
  
  
  totalFrames = 2 * 2 * numFrames;
}

void draw(){

  loadPixels();
  
  if((frameCount / (2 * numFrames)) % 2 == 0){
    img = mask1;
  } else{
    img = mask2;
  }
  float loopingX = cos(frameCount / (float)totalFrames * TWO_PI) * 5;
  float loopingY = sin(frameCount / (float)totalFrames * TWO_PI) * 5;
  for(int x = 0; x < width; x++){
  
    for(int y = 0; y < height; y++){
      color c;
      float noiseVal = map((float)noise.eval(x / 80.0, y / 80.0, loopingX, loopingY), -1, 1, 0, 1);
      
      float cDist = new PVector(x, y).dist(new PVector(width / 2, height / 2));
      
      //float maskAdd = constrain(red(img.pixels[x + y * width]) * (frameCount / numFrames), 0, 1);
      trueThreshold = sineMap(frameCount - 1, 0, numFrames, 0.5, trueTarget);
      falseThreshold = sineMap(frameCount - 1, 0, numFrames, 0.5, falseTarget); //<>//
      
      if(red(img.pixels[x + y * width]) < 125){ //<>//
        //if(cDist > 280) falseThreshold = 0.5;
        c = color(round(noiseVal, falseThreshold) * 255 );
      }else{
        c = color(round(noiseVal, trueThreshold) * 255 );
      }
      //print(red(c));
      pixels[x + y * width] = c;
      
    }
    
  }
  
  
  updatePixels();
  
  if(frameCount <= totalFrames){

    saveFrame("mask###.png");
  }else{noLoop();}
}
