//
//  Cube.m
//  helicopter
//
//  Created by demo on 06.11.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Cube.h"

#import "ConfigManager.h"

#include <OpenGL/gl.h>
#include <OpenGl/glu.h>

const float size = 2.0f;

@implementation Cube

//////////////////////////////////////////////////////////////////////////////////
// Initialize cube
//////////////////////////////////////////////////////////////////////////////////
- (id)init
{
    self = [super init];
    if (self) {
        pos[0] = 0.0f;
        pos[1] = 0.0f;
        pos[2] = 0.0f;
    }
    
    return self;
}

//////////////////////////////////////////////////////////////////////////////////
// Draw cube
//////////////////////////////////////////////////////////////////////////////////
-(void) draw
{
    float x2 = pos[0] + size;
    float y2 = pos[1] + size;
    float z2 = pos[2] + size;
    
    glShadeModel(GL_SMOOTH);
    
    glBegin(GL_QUADS);
    {
        // Front face
        glColor3f(1.0f, 0.0f, 0.0f);    glVertex3f(pos[0],  pos[1], z2);
        glColor3f(0.0f, 1.0f, 0.0f);    glVertex3f(x2,      pos[1], z2);
        glColor3f(0.0f, 0.0f, 1.0f);    glVertex3f(x2,      y2,     z2);
        glColor3f(1.0f, 1.0f, 0.0f);    glVertex3f(pos[0],  y2,     z2);
        
        // Back face
        glColor3f(1.0f, 0.0f, 1.0f);    glVertex3f(pos[0],  pos[1], pos[2]);
        glColor3f(0.5f, 1.0f, 0.5f);    glVertex3f(pos[0],  y2,     pos[2]);
        glColor3f(0.8f, 1.0f, 0.5f);    glVertex3f(x2,      y2,     pos[2]);
        glColor3f(0.0f, 1.0f, 1.0f);    glVertex3f(x2,      pos[1], pos[2]);
        
        // Left face
        glColor3f(0.1f, 0.0f, 1.0f);    glVertex3f(pos[0],  pos[1], pos[2]);
        glColor3f(0.5f, 5.0f, 0.5f);    glVertex3f(pos[0],  pos[1], z2);
        glColor3f(0.0f, 1.0f, 0.5f);    glVertex3f(pos[0],  y2,     z2);        
        glColor3f(0.5f, 0.0f, 1.0f);    glVertex3f(pos[0],  y2,     pos[2]);
        
        // Right face
        glColor3f(0.5f, 0.5f, 0.5f);    glVertex3f(x2,      pos[1], z2);
        glColor3f(0.5f, 1.0f, 0.5f);    glVertex3f(x2,      pos[1], pos[2]);
        glColor3f(1.0f, 0.2f, 0.5f);    glVertex3f(x2,      y2,     pos[2]);
        glColor3f(0.0f, 1.0f, 0.2f);    glVertex3f(x2,      y2,     z2);
        
        // Top face
        glColor3f(1.0f, 1.0f, 0.2f);    glVertex3f(pos[0],  y2,     z2);
        glColor3f(0.0f, 1.0f, 0.2f);    glVertex3f(x2,      y2,     z2);
        glColor3f(0.0f, 1.0f, 0.2f);    glVertex3f(x2,      y2,     pos[2]);
        glColor3f(0.0f, 1.0f, 0.2f);    glVertex3f(pos[0],  y2,     pos[2]);
        
        // Bottom face
        glColor3f(0.0f, 1.0f, 0.2f);    glVertex3f(x2,      pos[1], z2);
        glColor3f(0.0f, 1.0f, 0.2f);    glVertex3f(pos[0],  pos[1], z2);
        glColor3f(0.0f, 1.0f, 0.2f);    glVertex3f(pos[0],  pos[1], pos[2]);
        glColor3f(0.0f, 1.0f, 0.2f);    glVertex3f(x2,      pos[1], pos[2]);
        
    }
    glEnd();
}

@end
