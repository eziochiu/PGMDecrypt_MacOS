//
//  Header.h
//  pgmDecrypt
//
//  Created by admin on 2021/1/7.
//

#ifndef Header_h
#define Header_h

#ifndef M_PI // SDL2 is making this not found
#define M_PI 3.14159265358979323846264338327950288
#endif

typedef unsigned char                        UINT8;
typedef signed char                         INT8;
typedef unsigned short                        UINT16;
typedef signed short                        INT16;
typedef unsigned int                        UINT32;
typedef signed int                            INT32;
#ifdef _MSC_VER
typedef signed __int64                        INT64;
typedef unsigned __int64                    UINT64;
#else
__extension__ typedef unsigned long long    UINT64;
__extension__ typedef long long                INT64;
#endif

#endif /* Header_h */
