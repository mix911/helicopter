//
//  HelicopterErrors.h
//  helicopter
//
//  Created by demo on 18.02.12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#ifndef helicopter_HelicopterErrors_h
#define helicopter_HelicopterErrors_h

enum EErrorsCode
{
    S_OK            =  0,
    S_FALSE         =  1,
    E_FAIL          = -1,
    E_INVALIDE_ARG  = -2,
}

#define SUCCESS(code) (code >= 0)
#define FAILED(code)  (code <  0)

#endif
