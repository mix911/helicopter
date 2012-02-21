//
//  Terrain.m
//  helicopter
//
//  Created by demo on 06.11.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Terrain.h"

#import "ConfigManager.h"

#include <OpenGL/gl.h>
#include <OpenGl/glu.h>

#include "color.h"
#include "vertex.h"

const float MAX_HEIGHT  = 3.0f;  // The highest point of the terrain
const float MAX_X       = 10.0f; 
const float MAX_Y       = 10.0f;

@interface Terrain(Private)

-(void) load;

@end

@implementation Terrain(Private)

//////////////////////////////////////////////////////////////////////////////////
// Load terrain from resource
//////////////////////////////////////////////////////////////////////////////////
-(void) load
{
    // Load image
    NSString* file = [ConfigManager getValue:@"Terrain.filePath"];
    NSImage* image = [[NSImage alloc] initByReferencingFile:file];
    
    // Если не удалось загрузить картинку, сообщем об этом
    if (image == nil) {
        NSException* e = [NSException exceptionWithName:nil reason:nil userInfo:nil];
        @throw e;
    }
    
    // Get image's rectangle
    NSSize size = [image size];
    NSRect rect = NSMakeRect(0.0, 0.0, size.width, size.height);
    
    
    // Create bitmap
    [image lockFocus];
    NSBitmapImageRep* img = [[NSBitmapImageRep alloc] initWithFocusedViewRect:rect];
    [image unlockFocus];
    
    // Get width and height of bitmap
    width = (unsigned int)[img pixelsHigh];
    height= (unsigned int)[img pixelsWide];
    
    // Allocate vertices buffer
    [vertices setLength:sizeof(vertex) * width * height];
    
    // Get pointer to buffer
    vertex* data = [vertices mutableBytes];
    
    // Calculate scale factors
    float kx = MAX_X        / width;
    float ky = MAX_HEIGHT   / 255.0f;
    float kz = MAX_Y        / height;
    
    // Foreach pixels
    for (unsigned int y = 0; y < height; ++y) {
        for (unsigned int x = 0; x < width; ++x) {

            // Get pixel's color
            NSColor* color = [img colorAtX:x y:y];
            
            // Get any component of color
            Byte red    = (Byte)(255.0f * [color redComponent]);
            
            // Calculate index of current point in vertices buffer
            size_t i = y * width + x;
            
            // Any color is height
            float z = red;
            
            // Fill current point in vertices buffer
            data[i].v.x = MAX_X / 2.0f - x * kx;
            data[i].v.y = z * ky;
            data[i].v.z = MAX_Y / 2.0f - y * kz;
        }
    }
    
    unsigned int nheight= height - 1;
    unsigned int nwidth = width - 1;
    
    // Create temporary buffer for the triangle's normiles
    vector3d* normiles = malloc(2 * sizeof(vector3d) * nwidth * nheight);
    
    // Fill temporary buffer
    for (unsigned int ih = 0; ih < nheight; ++ih) {
        
        unsigned int h  = ih * width;
        unsigned int nh = ih * nwidth;
        
        for (unsigned int iw = 0; iw < nwidth; ++iw) {
            
            unsigned int i = h + iw;
            unsigned int ni= 2 * (nh + iw);
            
            vector3d lb = data[i].v;
            vector3d rb = data[i + 1].v;
            vector3d lt = data[i + width].v;
            vector3d rt = data[i + width + 1].v;
            
            vector3d a1, b1, a2, b2;
            
            subtraction(&a1, &lb, &lt);
            subtraction(&b1, &lt, &rt);
            subtraction(&a2, &rb, &lb);
            subtraction(&b2, &rb, &rt);
            
            cross(&normiles[ni],    &a1, &b1);
            cross(&normiles[ni+1],  &a2, &b2);
            
            normilize(&normiles[ni]);
            normilize(&normiles[ni + 1]);
        }
    }
    
    // Calculate vertice's normilez
    for (unsigned int ih = 0; ih < height; ++ih) {
        
        unsigned int h = ih * width;
        
        unsigned int inh = ih % nheight;
        unsigned int inhp= (inh + nheight - 1) % nheight;
        
        unsigned int nh = inh * nwidth;
        unsigned int nhp= inhp* nwidth;
                
        for (unsigned int iw = 0; iw < width; ++iw) {
            
            unsigned int i = h + iw;
            
            unsigned int inw = iw % nwidth;
            unsigned int inwp= (inw + nwidth - 1) % nwidth;
            
            unsigned int ntr = 2 * (nh + inw);
            unsigned int ntl = 2 * (nh + inwp);
            unsigned int nbr = 2 * (nhp+ inw);
            unsigned int nbl = 2 * (nhp+ inwp);
            
            data[i].n = normiles[ntr];
            add_vec3d(&data[i].n, &normiles[ntr + 1]);
            add_vec3d(&data[i].n, &normiles[nbr]);
            add_vec3d(&data[i].n, &normiles[nbl]);
            add_vec3d(&data[i].n, &normiles[nbl + 1]);
            add_vec3d(&data[i].n, &normiles[ntl + 1]);
            
            normilize(&data[i].n);
        }
    }
    
    free(normiles);
}

@end

@implementation Terrain

//////////////////////////////////////////////////////////////////////////////////
// Initialization
//////////////////////////////////////////////////////////////////////////////////
- (id)init
{
    self = [super init];
    if (self) {
        vertices    = [[NSMutableData alloc ] init];
        width       = 0;
        height      = 0;
        isShowNormal= false;
        shadeMode   = GL_SMOOTH;
        
        [self load];
    }
    
    return self;
}
//////////////////////////////////////////////////////////////////////////////////
// Dealocation
//////////////////////////////////////////////////////////////////////////////////
-(void) dealloc
{
    if (vertices) {
        [vertices dealloc];

        vertices= NULL;
        width   = 0;
        height  = 0;
    }
}

//////////////////////////////////////////////////////////////////////////////////
// Draw terrain
//////////////////////////////////////////////////////////////////////////////////
-(void) draw
{
    glShadeModel(shadeMode);
    
    vertex* data = [vertices mutableBytes];
    
    glBegin(GL_TRIANGLES);
    {
        
        for (unsigned int ih = 0; ih < height - 1; ++ih) {
            
            unsigned int h = width * ih;
            
            for (unsigned int iw = 0; iw < width - 1; ++iw) {

                unsigned int i = h + iw;
                
                glNormal3fv((float*)&data[i].n);
                glVertex3fv((float*)&data[i].v); 
                
                
                i += width;
                glNormal3fv((float*)&data[i].n);
                glVertex3fv((float*)&data[i].v); 
                
                ++i;
                glNormal3fv((float*)&data[i].n);
                glVertex3fv((float*)&data[i].v);
                
                glNormal3fv((float*)&data[i].n);                
                glVertex3fv((float*)&data[i].v); 
                
                i -= width;
                glNormal3fv((float*)&data[i].n);                
                glVertex3fv((float*)&data[i].v); 
                
                --i;
                glNormal3fv((float*)&data[i].n);                
                glVertex3fv((float*)&data[i].v); 
            }
        }
    }
    glEnd();
    
    // If show normal is on
    if (isShowNormal) {
        glBegin(GL_LINES);
        {
            glColor3f(1.0f, 0.0f, 0.0f);
            for (unsigned int ih = 0; ih < height; ++ih) {
                
                unsigned int h = width * ih;
                
                for (unsigned int iw = 0; iw < width; ++iw) {
                    unsigned int i = h + iw;
                    
                    vector3d v = data[i].v;
                    add_vec3d(&v, &data[i].n);
                    
                    glVertex3fv((float*)&data[i].v);
                    glVertex3fv((float*)&v);
                }
            }
        }
        glEnd();
    }
}

@end
