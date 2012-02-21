//
//  Camera.h
//  helicopter
//
//  Created by demo on 30.10.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#include "vector3d.h"

//////////////////////////////////////////////////////////////////////////////////
// Camera
//////////////////////////////////////////////////////////////////////////////////
@interface Camera : NSObject
{
    vector3d eye;
    vector3d center;
    vector3d up;
}

-(vector3d*) eye;
-(vector3d*) center;
-(vector3d*) up;

-(void) setEye:(vector3d*)v;
-(void) setCenter:(vector3d*)v;
-(void) setUp:(vector3d*)v;

@end
