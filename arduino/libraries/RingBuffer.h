/*
  Ring buffer Library.
  Created by Pirmin Kalberer.
  Released into the public domain.
*/

#ifndef RingBuffer_h
#define RingBuffer_h

class RingBuffer
{
private:
  int size;
  int* buffer;
  int start;
  int end;
  int cnt;

public:
  RingBuffer(int size);
  ~RingBuffer();
  void push(int value);
  int pop();
  int peek();
  int count();
};

#endif
