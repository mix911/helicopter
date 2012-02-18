//
//  OpenGLView.m
//  helicopter
//
//  Created by demo on 15.10.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "OpenGLView.h"

#import "Scene.h"
#import "MainWindow.h"

enum EVirtualKeyCode {
    KEY_W = 13,
    KEY_S = 1,
    KEY_A = 0,
    KEY_D = 2,
};

@interface OpenGLView(Private)

-(void) onTimer:(id)info;

@end

@implementation OpenGLView(Private)

-(void) onTimer:(id)info
{
    [scene draw];
}

@end

@implementation OpenGLView

-(void) awakeFromNib
{
    scene = [[Scene alloc] initWithOpenGLView:self];
    timer = [NSTimer scheduledTimerWithTimeInterval:0.015f target:self selector:@selector(onTimer:) userInfo:nil repeats:YES];
}

-(void) reshape
{
    [super reshape];
    
    NSRect bounds = [self bounds];
    [scene resize:bounds.size.width :bounds.size.height];
}

-(void) drawRect:(NSRect)dirtyRect
{    
    [scene draw];
}

-(void) mouseDown:(NSEvent *)theEvent
{
    NSPoint pt = [theEvent locationInWindow];
    [scene mouseDown:[self convertPoint:pt fromView:nil]];
}

-(void) mouseDragged:(NSEvent *)theEvent
{
    NSPoint pt = [theEvent locationInWindow];
    pt = [self convertPoint:pt fromView:nil];
    
    [scene mouseDragged:pt];
}

-(void) keyDown:(NSEvent *)theEvent
{
    int key = [theEvent keyCode];
    
    switch (key) {

        case KEY_W:
            [scene goForward];
            break;
            
        case KEY_S:
            [scene goBackward];
            break;
            
        case KEY_A:
            [scene goLeft];
            break;
            
        case KEY_D:
            [scene goRight];
            break;
            
        default:
            break;
    }
}

-(void) setFps:(int)fps
{
    [window setTitle:[NSString stringWithFormat:@"helicopter: %i fps", fps]];
}

@end
