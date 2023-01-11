float sineMap(float value, float low, float high, float nlow, float nhigh){

  float phase = high - low;
  float phaseOffset = low;
  float amplitude = (nhigh - nlow)/2;
  float vertOffset = amplitude + nlow;
  
  return amplitude * sin((value - phaseOffset) * (PI/phase) - PI/2) + vertOffset;
  
}

int round(float value, float threshold){

  return (value < threshold) ? floor(value) : ceil(value);
  
}
