//
//  MainWindow.m
//  helicopter
//
//  Created by demo on 12.11.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MainWindow.h"
#import "OpenGLView.h"

@implementation MainWindow

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

-(void) keyDown:(NSEvent *)theEvent
{
    [view keyDown:theEvent];
}

@end
