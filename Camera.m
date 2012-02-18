//
//  Camera.m
//  helicopter
//
//  Created by demo on 30.10.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Camera.h"

#import "ConfigManager.h"

@implementation Camera

- (id)init
{
    self = [super init];
    if (self) {
        eye.x   = [ConfigManager getValueFloat:@"Camera.eye.x"];
        eye.y   = [ConfigManager getValueFloat:@"Camera.eye.y"];
        eye.z   = [ConfigManager getValueFloat:@"Camera.eye.z"];
        center.x= [ConfigManager getValueFloat:@"Camera.center.x"];
        center.y= [ConfigManager getValueFloat:@"Camera.center.y"];
        center.z= [ConfigManager getValueFloat:@"Camera.center.z"];
        up.x    = [ConfigManager getValueFloat:@"Camera.up.x"];
        up.y    = [ConfigManager getValueFloat:@"Camera.up.y"];
        up.z    = [ConfigManager getValueFloat:@"Camera.up.z"];
    }
    
    return self;
}

-(vector3d*) eye
{
    return &eye;
}

-(vector3d*) center
{
    return &center;
}

-(vector3d*) up
{
    return &up;
}

-(void) setEye:(vector3d *)v
{
    eye = *v;
}

-(void) setCenter:(vector3d *)v
{
    center = *v;
}

-(void) setUp:(vector3d *)v
{
    up = *v;
}

@end
