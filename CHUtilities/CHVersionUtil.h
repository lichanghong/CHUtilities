//
//  CHVersionUtil.h
//  CHUtilities
//
//  Created by li on 10/8/14.
//  Copyright (c) 2014 lch. All rights reserved.
//

#import <Foundation/Foundation.h>

#define OSVERSION_BIG_THAN_7 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0?YES:NO)


@interface CHVersionUtil : NSObject

+ (void)test:(void (^)(void))didfinish;


@end
