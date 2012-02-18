//
//  numbers.c
//  helicopter
//
//  Created by demo on 06.11.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#include "numbers.h"

float lerp(float x1, float x2, float y1, float y2, float y)
{
    return (x2 * (y - y1) + x1 * (y2 - y)) /
                     (y2 - y1);
}