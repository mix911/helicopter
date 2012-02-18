//
//  color.h
//  helicopter
//
//  Created by demo on 13.11.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#ifndef helicopter_color_h
#define helicopter_color_h

typedef unsigned int rgba_t;

#define rgba(r, g, b, a)\
    (((char)r << 24) | ((char)g << 16) | ((char)b << 8) | (char)a)

typedef struct _color
{
    float r, g, b, a;
} color;

#endif
