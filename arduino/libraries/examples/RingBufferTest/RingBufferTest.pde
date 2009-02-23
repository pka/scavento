#include <RingBuffer.h>

RingBuffer buf(20);

void setup()
{
  Serial.begin(9600);
  delay(1000);
  for (int i=0; i<30; i++) buf.push(i);      
}

void loop()
{
  buf.push(analogRead(0));
  if (buf.count() >= 10) {
    int sum = 0;
    for (int i=0; i<10; i++) sum += buf.pop();
    Serial.println(sum/10);
  }
  delay(100);
}

