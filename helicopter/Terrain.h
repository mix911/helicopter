//
//  Terrain.h
//  helicopter
//
//  Created by demo on 06.11.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#include "vertex.h"

//////////////////////////////////////////////////////////////////////////////////
// Terrain - render object to represents terrain
//////////////////////////////////////////////////////////////////////////////////
@interface Terrain : NSObject
{
    NSMutableData*  vertices;       // Vertices
    unsigned int    width;          // Count points by width
    unsigned int    height;         // Count points by heithg
    bool            isShowNormal;   // Show or hide hormal
    GLenum          shadeMode;      // Shade mode
}

-(id)   init;
-(void) dealloc;

-(void) draw;

@end
