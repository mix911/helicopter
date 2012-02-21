//
//  ConfigManager.m
//  helicopter
//
//  Created by demo on 06.11.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ConfigManager.h"

#import "Camera.h"

//////////////////////////////////////////////////////////////////////////////////
// Propertes dictionary
//////////////////////////////////////////////////////////////////////////////////
NSDictionary* dict = nil;

@implementation ConfigManager

//////////////////////////////////////////////////////////////////////////////////
// Load configs
//////////////////////////////////////////////////////////////////////////////////
+(void) load
{
    NSString*               error_desc  = nil;
    NSPropertyListFormat    format      = 0;
    NSString*               plist_file  = @"/Users/demo/Documents/helicopter/helicopter/en.lproj/Config.plist";
    
    // Create propertes list data
    NSData* plist_data = [[NSFileManager defaultManager] contentsAtPath:plist_file];
    
    // Create propertes dictionary
    dict = (NSDictionary*)[NSPropertyListSerialization propertyListFromData:plist_data 
                                                           mutabilityOption:NSPropertyListMutableContainersAndLeaves 
                                                                     format:&format 
                                                           errorDescription:&error_desc];
}

//////////////////////////////////////////////////////////////////////////////////
// Clear configs
//////////////////////////////////////////////////////////////////////////////////
+(void) clear
{
    [dict release];
}

//////////////////////////////////////////////////////////////////////////////////
// Get value
//////////////////////////////////////////////////////////////////////////////////
+(id) getValue:(NSString*)name
{    
    return [dict objectForKey:name];
}

//////////////////////////////////////////////////////////////////////////////////
// Get float value. Call only if you sure that value is float number
//////////////////////////////////////////////////////////////////////////////////
+(float) getValueFloat:(NSString *)name
{
    return [[self getValue:name] floatValue];
}

@end
