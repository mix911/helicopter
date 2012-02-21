//
//  Light.m
//  helicopter
//
//  Created by demo on 26.11.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Light.h"
#import "ConfigManager.h"

@implementation Light

//////////////////////////////////////////////////////////////////////////////////
// Initialize Light
//////////////////////////////////////////////////////////////////////////////////
- (id)init
{
    self = [super init];
    if (self) {
        pos.x = [ConfigManager getValueFloat:@"Light.position.x"];
        pos.y = [ConfigManager getValueFloat:@"Light.position.y"];
        pos.z = [ConfigManager getValueFloat:@"Light.position.z"];
        pos.w = 0.0f;
        
        amb.r = [ConfigManager getValueFloat:@"Light.ambient.r"];
        amb.g = [ConfigManager getValueFloat:@"Light.ambient.g"];
        amb.b = [ConfigManager getValueFloat:@"Light.ambient.b"];
        amb.a = [ConfigManager getValueFloat:@"Light.ambient.a"];
        
        dif.r = [ConfigManager getValueFloat:@"Light.diffuse.r"];
        dif.g = [ConfigManager getValueFloat:@"Light.diffuse.g"];
        dif.b = [ConfigManager getValueFloat:@"Light.diffuse.b"];
        dif.a = [ConfigManager getValueFloat:@"Light.diffuse.a"];
        
        spec.r= [ConfigManager getValueFloat:@"Light.specular.r"];
        spec.g= [ConfigManager getValueFloat:@"Light.specular.g"];
        spec.b= [ConfigManager getValueFloat:@"Light.specular.b"];
        spec.a= [ConfigManager getValueFloat:@"Light.specular.a"];
    }
    
    return self;
}

-(vector4d*) position
{
    return &pos;
}

-(color*) ambient
{
    return &amb;
}

-(color*) diffuse
{
    return &dif;
}

-(color*) specular
{
    return &spec;
}

@end
