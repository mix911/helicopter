//
//  Scene.m
//  helicopter
//
//  Created by demo on 29.10.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Scene.h"

#import "Camera.h"
#import "Light.h"

#import "Cube.h"
#import "Terrain.h"
#import "ConfigManager.h"
#import "OpenGLView.h"

#include "constants.h"
#include "numbers.h"
#include "vector3d.h"

#include <OpenGL/gl.h>
#include <OpenGl/glu.h>
#include <sys/timeb.h>

time_t dateRange(struct timeb* a, struct timeb* b);
time_t dateRange(struct timeb* a, struct timeb* b)
{
    return (1000 * (b->time - a->time) - a->millitm + b->millitm) / 1000;
}

@implementation Scene

- (id)initWithOpenGLView:(OpenGLView*)wnd
{
    self = [super init];
    if (self) {
        @try {
            
            memset(&mouseOld, 0, sizeof(mouseOld));
            memset(&lastTime, 0, sizeof(lastTime));
            memset(&currTime, 0, sizeof(currTime));
            
            width       = 0.0f;
            height      = 0.0f;
            fpsCounter  = 0;
            
            window = wnd;
            [ConfigManager load];
            
            camera  = [[Camera alloc] init];
            light   = [[Light alloc] init];
            
            cube    = [[Cube    alloc] init];
            terrain = [[Terrain alloc] init];
        }
        @catch (NSException *exception) {
            NSLog(@"Failed to initialize camera");
        }
        @finally {
            NSLog(@"This always happens");
        }
    }
    
    return self;
}

-(void) dealloc
{
    [ConfigManager clear];
}

-(void) draw 
{
    if (ftime(&currTime) == -1) {
        NSException* e = [NSException exceptionWithName:@"System error" reason:@"ftime return -1" userInfo:nil];
        @throw e;
    }
    
    time_t range = dateRange(&lastTime, &currTime);
    
    if (range >= 1) {
        lastTime    = currTime;
        
        fpsCounter  /= range;
        [window setFps:fpsCounter];
        
        fpsCounter  = 0;
    }
    
    ++fpsCounter;
    
    
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
    glPolygonMode(GL_FRONT, GL_FILL);
    glCullFace(GL_BACK);
    glFrontFace(GL_CCW);
    glEnable(GL_CULL_FACE);
    glEnable(GL_DEPTH_TEST);
    glDepthFunc(GL_LESS);
    
    glEnable(GL_LIGHTING);
    glEnable(GL_LIGHT0);

    glLightfv(GL_LIGHT0, GL_AMBIENT, (GLfloat*)[light ambient]);
    glLightfv(GL_LIGHT0, GL_DIFFUSE, (GLfloat*)[light diffuse]);
    glLightfv(GL_LIGHT0, GL_SPECULAR,(GLfloat*)[light specular]);
    glLightfv(GL_LIGHT0, GL_POSITION,(GLfloat*)[light position]);
    
    vector3d eye      =*[camera eye];
    vector3d center   =*[camera center];
    vector3d up       =*[camera up];
    
    glMatrixMode(GL_MODELVIEW);
    
    glLoadIdentity();
    gluLookAt(eye.x, eye.y, eye.z, center.x, center.y, center.z, up.x, up.y, up.z);
    
    glPushMatrix();
    {
        [terrain draw];
    }
    glPopMatrix();

    glFlush();
}

-(void) resize:(float)w :(float)h
{
    width   = w;
    height  = h;
    
    float  aspect = width / height;
    
    glViewport(0, 0, (GLint)width, (GLint)height);
    
    glMatrixMode(GL_PROJECTION);
    
    glLoadIdentity();
    gluPerspective(60.0f, aspect, 1.0f, 60.0f);
}

-(void) mouseDown:(NSPoint)pt 
{
    mouseOld = pt;
}

-(void) mouseDragged:(NSPoint)pt
{   
    // Получим параметры камеры
    vector3d eye    = *[camera eye];
    vector3d center = *[camera center];
    
    // Получим инвертированное направление камеры
    vector3d idir;
    subtraction(&idir, &eye, &center);
    
    // Получим сферические координаты idir
    float collatitude   =get_collatitude(&idir);
    float azimuth       =get_azimuth(&idir);
    float r             =lenght(&idir);
    
    // Модифируем долготу и широту
    azimuth     += lerp(0.0f, TWO_PI,   0.0f, width,    (mouseOld.x - pt.x));
    collatitude += lerp(0.0f, PI,       0.0f, height,   (mouseOld.y - pt.y));
    
    // Установим новые значения idir
    vec3_spherical(&idir, collatitude, azimuth, r);
    normilize(&idir);
    multiple(&idir, r);
    
    // Получим новое значение eye
    sum_vec3d(&eye, &center, &idir);
    
    [camera setEye:&eye];
    
    mouseOld = pt;
}

-(void) goForward
{
    // Получим параметры камеры
    vector3d eye    = *[camera eye];
    vector3d center = *[camera center];
    
    // Получим направление камеры
    vector3d dir;
    subtraction(&dir, &center, &eye);
    
    // Получим вектор перемещения
    normilize(&dir);
    multiple(&dir, 0.3f);
    
    // Сохраним значения высоты
    float old_y_eye = eye.y;
    float old_y_cen = center.y;
    
    // Переместим центер и точку обзора
    add_vec3d(&eye,      &dir);
    add_vec3d(&center,   &dir);
    
    // Востановим старые значения высоты
    eye.y   = old_y_eye;
    center.y= old_y_cen;
        
    // Установим новые параметры камеры
    [camera setCenter:&center];
    [camera setEye:&eye];
}

-(void) goBackward
{
    // Получим параметры камеры
    vector3d eye    = *[camera eye];
    vector3d center = *[camera center];
    
    // Получим направление камеры
    vector3d dir;
    subtraction(&dir, &eye, &center);
    
    // Получим вектор перемещения
    normilize(&dir);
    multiple(&dir, 0.3f);
    
    // Сохраним значения высоты
    float old_y_eye = eye.y;
    float old_y_cen = center.y;
    
    // Переместим центер и точку обзора
    add_vec3d(&eye,      &dir);
    add_vec3d(&center,   &dir);
    
    // Востановим старые значения высоты
    eye.y   = old_y_eye;
    center.y= old_y_cen;
    
    // Установим новые параметры камеры
    [camera setCenter:&center];
    [camera setEye:&eye];
}

-(void) goLeft
{
    // Получим параметры камеры
    vector3d eye    = *[camera eye];
    vector3d center = *[camera center];
    vector3d up     = *[camera up];
    
    // Получим направление обзора камеры
    vector3d view_dir;
    subtraction(&view_dir, &eye, &center);
    
    // Получим направление влево
    vector3d dir;
    cross(&dir, &view_dir, &up);
    normilize(&dir);
    multiple(&dir, 0.1f);
    
    // Сохраним значения высоты
    float old_y_eye = eye.y;
    float old_y_cen = center.y;
    
    // Переместим камеру
    add_vec3d(&eye,      &dir);
    add_vec3d(&center,   &dir);
    
    // Востановим старые значения высоты
    eye.y   = old_y_eye;
    center.y= old_y_cen;
    
    // Установим новые параметры камеры
    [camera setCenter:&center];
    [camera setEye:&eye];
}

-(void) goRight
{
    // Получим параметры камеры
    vector3d eye    = *[camera eye];
    vector3d center = *[camera center];
    vector3d up     = *[camera up];
    
    // Получим направление обзора камеры
    vector3d view_dir;
    subtraction(&view_dir, &eye, &center);
    
    // Получим направление влево
    vector3d dir;
    cross(&dir, &up, &view_dir);
    normilize(&dir);
    multiple(&dir, 0.1f);
    
    // Сохраним значения высоты
    float old_y_eye = eye.y;
    float old_y_cen = center.y;
    
    // Переместим камеру
    add_vec3d(&eye,      &dir);
    add_vec3d(&center,   &dir);
    
    // Востановим старые значения высоты
    eye.y   = old_y_eye;
    center.y= old_y_cen;
    
    // Установим новые параметры камеры
    [camera setCenter:&center];
    [camera setEye:&eye];
}

@end
