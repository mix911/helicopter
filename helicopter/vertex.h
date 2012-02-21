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

//////////////////////////////////////////////////////////////////////////////////
// Vertex structure
//////////////////////////////////////////////////////////////////////////////////
typedef struct _vertex
{
    vector3d    v;  // Vertex
    vector3d    n;  // Normal
    color       c;  // Color
} vertex;

#endif
