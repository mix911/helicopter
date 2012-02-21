//
//  helicopterAppDelegate.h
//  helicopter
//
//  Created by demo on 15.10.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>

//////////////////////////////////////////////////////////////////////////////////
// Application delegate
//////////////////////////////////////////////////////////////////////////////////
@interface helicopterAppDelegate : NSObject <NSApplicationDelegate> 
{
    NSWindow *window;
}

@property (assign) IBOutlet NSWindow *window;

@end
