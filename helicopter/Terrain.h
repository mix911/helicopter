//
//  Terrain.h
//  helicopter
//
//  Created by demo on 06.11.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#include "vertex.h"

@interface Terrain : NSObject
{
    NSMutableData*  vertices;
    unsigned int    width;
    unsigned int    height;
}

-(id)   init;
-(void) dealloc;

-(void) draw;

@end
