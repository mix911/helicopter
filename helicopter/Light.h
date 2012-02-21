//
//  Light.h
//  helicopter
//
//  Created by demo on 26.11.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#include "vector4d.h"
#include "color.h"

//////////////////////////////////////////////////////////////////////////////////
// Light - represent open gl light
//////////////////////////////////////////////////////////////////////////////////
@interface Light : NSObject
{
    vector4d    pos;    // Position of light
    color       amb;    // Ambient component
    color       dif;    // Diffuse component
    color       spec;   // Specular component
}

-(id) init;

-(vector4d*)    position;
-(color*)       ambient;
-(color*)       diffuse;
-(color*)       specular;

@end
