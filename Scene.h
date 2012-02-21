//
//  Scene.h
//  helicopter
//
//  Created by demo on 29.10.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#include <sys/timeb.h>

@class Camera;
@class Cube;
@class Terrain;
@class Light;
@class OpenGLView;

// TODO: May be better if this class was singleton

//////////////////////////////////////////////////////////////////////////////////
// Scene - draw and update all rendered objects
//////////////////////////////////////////////////////////////////////////////////
@interface Scene : NSObject
{
    Camera*     camera;   // Camera 
    Light*      light;    // Light
    
    Cube*       cube;     // Cube object
    Terrain*    terrain;  // Terrain object
    
    OpenGLView* window;   // OpenGLView
    
    NSPoint     mouseOld;
    float       width;
    float       height;
    
    struct timeb    lastTime;
    struct timeb    currTime;
    int             fpsCounter;

}

-(id)   initWithOpenGLView:(OpenGLView*)wnd;
-(void) dealloc;

-(void) draw;
-(void) resize :(float)w :(float)h;
-(void) mouseDown :(NSPoint)pt;
-(void) mouseDragged :(NSPoint)pt;

-(void) goForward;
-(void) goBackward;
-(void) goLeft;
-(void) goRight;

@end
