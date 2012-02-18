//
//  vector3d.h
//  helicopter
//
//  Created by demo on 06.11.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#ifndef helicopter_vector3d_h
#define helicopter_vector3d_h

typedef struct _vector3d
{
    float x, y, z;
} vector3d;

vector3d* vec3_spherical(vector3d* out, float colatitude, float azimuth, float r);

vector3d* normilize(vector3d* out);
vector3d* invert(vector3d* out);

float lenght(vector3d* v);
float lenght_sq(vector3d* v);

vector3d* multiple(vector3d* out, float k);
vector3d* add_vec3d(vector3d* out, vector3d* rgh);
vector3d* sum_vec3d(vector3d* out, vector3d* lft, vector3d* rgh);
vector3d* subtraction(vector3d* out, vector3d* lft, vector3d* rgh);
vector3d* cross(vector3d* out, vector3d* lft, vector3d* rgh);

float dot(vector3d* lft, vector3d* rgh);

float get_collatitude(vector3d* v);
float get_azimuth(vector3d* v);

#endif
