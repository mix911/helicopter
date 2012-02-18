//
//  ConfigManager.h
//  helicopter
//
//  Created by demo on 06.11.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ConfigManager : NSObject

+(id)       getValue:(NSString*)name;
+(float)    getValueFloat:(NSString*)name;
+(void)     load;
+(void)     clear;

@end
