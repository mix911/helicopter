//
//  OpenGLView.h
//  helicopter
//
//  Created by demo on 15.10.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <AppKit/AppKit.h>

@class Scene;
@class MainWindow;

//////////////////////////////////////////////////////////////////////////////////
// OpenGL window
//////////////////////////////////////////////////////////////////////////////////
@interface OpenGLView : NSOpenGLView
{
    Scene*      scene;              // Scene
    NSTimer*    timer;              // Update window timer
    
    IBOutlet MainWindow* window;    // Main window, that contain this OpenGLView
}

-(void) reshape;
-(void) drawRect:(NSRect)dirtyRect;
-(void) mouseDown:(NSEvent *)theEvent;
-(void) mouseDragged:(NSEvent *)theEvent;
-(void) awakeFromNib;
-(void) keyDown:(NSEvent *)theEvent;
-(void) setFps:(int)fps;

@end
