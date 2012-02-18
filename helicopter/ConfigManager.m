//
//  ConfigManager.m
//  helicopter
//
//  Created by demo on 06.11.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ConfigManager.h"

#import "Camera.h"

NSDictionary* dict = nil;

@implementation ConfigManager

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

+(void) load
{
    NSString *error_desc = nil;
    NSPropertyListFormat format;
    
    NSString* plist_file= @"/Users/demo/Documents/helicopter/helicopter/en.lproj/Config.plist";
    
//    if (![[NSFileManager defaultManager] fileExistsAtPath:plist_file]) {
//        plist_file = [[NSBundle mainBundle] pathForResource:@"Data" ofType:@"plist"];
//    }
    
    NSData* plist_data = [[NSFileManager defaultManager] contentsAtPath:plist_file];
    
    NSDictionary* local_dict = (NSDictionary*)[NSPropertyListSerialization propertyListFromData:plist_data mutabilityOption:NSPropertyListMutableContainersAndLeaves format:&format errorDescription:&error_desc];
    
    dict = [[NSDictionary alloc] initWithDictionary:local_dict];
    
    if (dict == nil) {
         NSLog(@"Error reading plist: %@, format: %d", error_desc, (int)format);
    }
}

+(void) clear
{
    [dict release];
}

+(id) getValue:(NSString*)name
{    
    return [dict objectForKey:name];
//    if ([name isEqualToString:@"Camera.eye.x"]) {
//        return [NSNumber numberWithFloat:0.0f];
//    }
//    else if ([name isEqualToString:@"Camera.eye.y"]) {
//        return [NSNumber numberWithFloat:0.0f];
//    }
//    else if ([name isEqualToString:@"Camera.eye.z"]) {
//        return [NSNumber numberWithFloat:7.0f];
//    }
//    else if ([name isEqualToString:@"Camera.center.x"]) {
//        return [NSNumber numberWithFloat:0.0f];
//    }
//    else if ([name isEqualToString:@"Camera.center.y"]) {
//        return [NSNumber numberWithFloat:0.0f];
//    }
//    else if ([name isEqualToString:@"Camera.center.z"]) {
//        return [NSNumber numberWithFloat:0.0f];
//    }
//    else if ([name isEqualToString:@"Camera.up.x"]) {
//        return [NSNumber numberWithFloat:0.0f];
//    }
//    else if ([name isEqualToString:@"Camera.up.y"]) {
//        return [NSNumber numberWithFloat:1.0f];
//    }
//    else if ([name isEqualToString:@"Camera.up.z"]) {
//        return [NSNumber numberWithFloat:0.0f];
//    }
//    else if ([name isEqualToString:@"Terrain.filePath"]) {
//        return @"/Users/demo/Documents/helicopter/height_map2.jpg";
//    }
//    else if ([name isEqualToString:@"Light.position.x"]) {
//        return [NSNumber numberWithFloat:0.0f];
//    }
//    else if ([name isEqualToString:@"Light.position.y"]) {
//        return [NSNumber numberWithFloat:100.0f];
//    }
//    else if ([name isEqualToString:@"Light.position.z"]) {
//        return [NSNumber numberWithFloat:0.0f];
//    }
//    else if ([name isEqualToString:@"Light.ambient.r"]) {
//        return [NSNumber numberWithFloat:0.5f];
//    }
//    else if ([name isEqualToString:@"Light.ambient.g"]) {
//        return [NSNumber numberWithFloat:0.5f];
//    }
//    else if ([name isEqualToString:@"Light.ambient.b"]) {
//        return [NSNumber numberWithFloat:0.5f];
//    }
//    else if ([name isEqualToString:@"Light.ambient.a"]) {
//        return [NSNumber numberWithFloat:1.0f];
//    }
//    else if ([name isEqualToString:@"Light.specular.r"]) {
//        return [NSNumber numberWithFloat:0.99f];
//    }
//    else if ([name isEqualToString:@"Light.specular.g"]) {
//        return [NSNumber numberWithFloat:0.99f];
//    }
//    else if ([name isEqualToString:@"Light.specular.b"]) {
//        return [NSNumber numberWithFloat:0.99f];
//    }
//    else if ([name isEqualToString:@"Light.specular.a"]) {
//        return [NSNumber numberWithFloat:0.99f];
//    }
//    else if ([name isEqualToString:@"Light.diffuse.r"]) {
//        return [NSNumber numberWithFloat:0.5f];
//    }
//    else if ([name isEqualToString:@"Light.diffuse.g"]) {
//        return [NSNumber numberWithFloat:0.5f];
//    }
//    else if ([name isEqualToString:@"Light.diffuse.b"]) {
//        return [NSNumber numberWithFloat:0.5f];
//    }
//    else if ([name isEqualToString:@"Light.diffuse.a"]) {
//        return [NSNumber numberWithFloat:0.5f];
//    }
//    
//    NSException* e = [NSException exceptionWithName:nil reason:nil userInfo:nil];
//    
//    @throw e;
//    
//    return nil;
}

+(float) getValueFloat:(NSString *)name
{
    
    return [[self getValue:name] floatValue];
}

@end
