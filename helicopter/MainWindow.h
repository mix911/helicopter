//
//  MainWindow.h
//  helicopter
//
//  Created by demo on 12.11.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <AppKit/AppKit.h>

@class OpenGLView;

//////////////////////////////////////////////////////////////////////////////////
// MainWindow
//////////////////////////////////////////////////////////////////////////////////
@interface MainWindow : NSWindow
{
    IBOutlet OpenGLView* view;  // OpenGLView
}

-(void) keyDown:(NSEvent *)theEvent;

@end
