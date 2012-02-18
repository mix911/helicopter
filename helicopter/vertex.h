//
//  vertex.h
//  helicopter
//
//  Created by demo on 17.11.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#ifndef helicopter_vertex_h
#define helicopter_vertex_h

#include "vector3d.h"
#include "color.h"

typedef struct _vertex
{
    vector3d    v;
    vector3d    n;
    color       c;
} vertex;

#endif
