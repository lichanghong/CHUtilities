//
//  CHDefines.h
//  CHUtilities
//
//  Created by li on 10/8/14.
//  Copyright (c) 2014 lch. All rights reserved.
//
//info
//所有自定义的没分类的宏都在这里(常用的宏)
//有的宏在各自的util里,如:LOCATIONSERVICE_ENABLED 地理相关的宏放在地理util里.

#ifndef CHUtilities_CHDefines_h
#define CHUtilities_CHDefines_h

#define RGB(r,g,b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]

//frame
#define KScreenWidth            [[UIScreen mainScreen] bounds].size.width
#define KScreenHeight           [[UIScreen mainScreen] bounds].size.height
#define KScreenRect             [[UIScreen mainScreen] bounds]
#define ViewW(v)                (v).frame.size.width
#define ViewH(v)                (v).frame.size.height
#define MinX(v)                 CGRectGetMinX((v).frame)
#define MinY(v)                 CGRectGetMinY((v).frame)
#define MaxX(v)                 CGRectGetMaxX((v).frame)
#define MaxY(v)                 CGRectGetMaxY((v).frame)
#define setY(v,y)   v.frame=CGRectMake(v.frame.origin.x, y , v.frame.size.width, v.frame.size.height)
#define setH(v,h)   v.frame=CGRectMake(v.frame.origin.x,v.frame.origin.y, v.frame.size.width, h)




#endif
