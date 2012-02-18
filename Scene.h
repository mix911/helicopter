//
//  Scene.h
//  helicopter
//
//  Created by demo on 29.10.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Camera;
@class Cube;
@class Terrain;
@class Light;
@class OpenGLView;

@interface Scene : NSObject
{
    Camera* camera;
    Light*  light;
    
    Cube*       cube;
    Terrain*    terrain;
    
    OpenGLView*   window;
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
