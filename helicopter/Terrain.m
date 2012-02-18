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

const float MAX_HEIGHT  = 3.0f;
const float MAX_X       = 10.0f;
const float MAX_Y       = 10.0f;

@interface Terrain(Private)

-(void) load;

@end

@implementation Terrain(Private)

-(void) load
{
    // Загрузим картинку
    NSString* file = [ConfigManager getValue:@"Terrain.filePath"];
    NSImage* image = [[NSImage alloc] initByReferencingFile:file];
    
    // Если не удалось загрузить картинку, сообщем об этом
    if (image == nil) {
        NSException* e = [NSException exceptionWithName:nil reason:nil userInfo:nil];
        @throw e;
    }
    
    // Получим прямоугольник картинки
    NSSize size = [image size];
    NSRect rect = NSMakeRect(0.0, 0.0, size.width, size.height);
    
    [image lockFocus];
    NSBitmapImageRep* img = [[NSBitmapImageRep alloc] initWithFocusedViewRect:rect];
    [image unlockFocus];
    
    // Получим ширину и высоту картинки
    width = (unsigned int)[img pixelsHigh];
    height= (unsigned int)[img pixelsWide];
    
    [vertices setLength:sizeof(vertex) * width * height];
    
    vertex* data = [vertices mutableBytes];
    
    float kx = MAX_X        / width;
    float ky = MAX_HEIGHT   / 255.0f;
    float kz = MAX_Y        / height;
    
    // Пройдемся по всем пикселям
    for (unsigned int y = 0; y < height; ++y) {
        for (unsigned int x = 0; x < width; ++x) {

            // Получим цвет очередного пикселя
            NSColor* color = [img colorAtX:x y:y];
            
            // Разложим его на компоненты TODO: тут можно переделать
            Byte red    = (Byte)(255.0f * [color redComponent]);
            
            // Вычислим индекс
            size_t i = y * width + x;
            
            // Из цветов получим высоту
            float z = red;
            
            data[i].v.x = MAX_X / 2.0f - x * kx;
            data[i].v.y = z * ky;
            data[i].v.z = MAX_Y / 2.0f - y * kz;
        }
    }
    
    unsigned int nheight= height - 1;
    unsigned int nwidth = width - 1;
    
    // Создадим буфер для нормалей к треугольникам
    vector3d* normiles = malloc(2 * sizeof(vector3d) * nwidth * nheight);
    
    // Заполним буфер нормалей к треугольникам
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
    
    // Посчитаем нормали к вершинам
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

- (id)init
{
    self = [super init];
    if (self) {
        vertices= [[NSMutableData alloc ] init];
        width   = 0;
        height  = 0;
        
        [self load];
    }
    
    return self;
}

-(void) dealloc
{
    if (vertices) {
        free(vertices);

        vertices= NULL;
        width   = 0;
        height  = 0;
    }
}

-(void) draw
{
    glShadeModel(GL_SMOOTH);
    
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
    
//    glBegin(GL_LINES);
//    {
//        glColor3f(1.0f, 0.0f, 0.0f);
//        for (unsigned int ih = 0; ih < height; ++ih)
//        {
//            unsigned int h = width * ih;
//            
//            for (unsigned int iw = 0; iw < width; ++iw)
//            {
//                unsigned int i = h + iw;
//                
//                vector3d v = data[i].v;
//                add_vec3d(&v, &data[i].n);
//                
//                glVertex3fv((float*)&data[i].v);
//                glVertex3fv((float*)&v);
//            }
//        }
//    }
//    glEnd();
}

@end
