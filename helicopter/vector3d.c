//
//  vector3d.c
//  helicopter
//
//  Created by demo on 06.11.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#include "vector3d.h"

#include "constants.h"

#include <math.h>

// out          - out vector
// colatitude   - angle between projection of vector on xOz and vector [-HALF_PI..HALF_Pi]
// azimuth      - angle between projection of vector on xOz and axis X [-PI..PI]
vector3d* vec3_spherical(vector3d* out, float colatitude, float azimuth, float r)
{
    float sin_colatitude= sinf(colatitude);
    float cos_colatitude= cosf(colatitude);
    float sin_azimuth   = sinf(azimuth);
    float cos_azimuth   = cosf(azimuth);
    
    out->x = r * sin_colatitude * sin_azimuth;
    out->y = r * cos_colatitude;
    out->z = r * sin_colatitude * cos_azimuth;
    
    return out;
}

vector3d* normilize(vector3d* out)
{
    return multiple(out, 1.0f / lenght(out));
}

float lenght(vector3d* v)
{
    return sqrtf(lenght_sq(v));
}

float lenght_sq(vector3d* v)
{
    return v->x * v->x + v->y * v->y + v->z * v->z;
}

vector3d* multiple(vector3d* out, float k)
{
    out->x *= k;
    out->y *= k;
    out->z *= k;
    
    return out;
}

vector3d* invert(vector3d* out)
{
    out->x = -out->x;
    out->y = -out->y;
    out->z = -out->z;
    
    return out;
}

vector3d* add_vec3d(vector3d* out, vector3d* rgh)
{
    out->x += rgh->x;
    out->y += rgh->y;
    out->z += rgh->z;
    
    return out;
}

vector3d* sum_vec3d(vector3d* out, vector3d* lft, vector3d* rgh)
{
    out->x = lft->x + rgh->x;
    out->y = lft->y + rgh->y;
    out->z = lft->z + rgh->z;
    
    return out;
}

vector3d* subtraction(vector3d* out, vector3d* lft, vector3d* rgh)
{
    out->x = lft->x - rgh->x;
    out->y = lft->y - rgh->y;
    out->z = lft->z - rgh->z;
    
    return out;
}

float dot(vector3d* lft, vector3d* rgh)
{
    return lft->x * rgh->x + lft->y * rgh->y + lft->z * rgh->z;
}

float get_collatitude(vector3d* v)
{
    return atan2f(sqrtf(v->x * v->x + v->z * v->z), v->y);
}

float get_azimuth(vector3d* v)
{   
    return atan2f(v->x, v->z);
}

vector3d* cross(vector3d* out, vector3d* lft, vector3d* rgh)
{
    out->x = lft->y * rgh->z - lft->z * rgh->y;
    out->y = lft->z * rgh->x - lft->x * rgh->z;
    out->z = lft->x * rgh->y - lft->y * rgh->x;
    
    return out;
}