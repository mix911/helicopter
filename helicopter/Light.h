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

@interface Light : NSObject
{
    vector4d    pos;
    color       amb;
    color       dif;
    color       spec;
}

-(id) init;

-(vector4d*)    position;
-(color*)       ambient;
-(color*)       diffuse;
-(color*)       specular;

@end
