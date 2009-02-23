/*
  Ring buffer Library.
  Created by Pirmin Kalberer.
  Released into the public domain.
*/

#include "RingBuffer.h"

// AVR LibC Includes
//#include <inttypes.h>
#include <stdlib.h>

// Wiring Core Includes
//#undef abs
//#include "WConstants.h"

RingBuffer::RingBuffer(int size)
: size(size), start(0), end(0), cnt(0)
{
  buffer = (int*)calloc(size, sizeof(int));
}

RingBuffer::~RingBuffer()
{
  free(buffer);
}

void RingBuffer::push(int value)
{
  buffer[end] = value;
  if (++end > size) end = 0;
  if (cnt == size) {
    if (++start > size) start = 0;
  } else {
    ++cnt;
  }
}

int RingBuffer::pop()
{
  int value = buffer[start];
  if (cnt > 0) {
    --cnt;
    if (++start > size) start = 0;
  }
  return value;
}

int RingBuffer::peek()
{
  return buffer[start];
}

int RingBuffer::count()
{
  return cnt;
}