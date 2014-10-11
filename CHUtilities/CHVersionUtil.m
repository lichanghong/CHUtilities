//
//  CHVersionUtil.m
//  CHUtilities
//
//  Created by li on 10/8/14.
//  Copyright (c) 2014 lch. All rights reserved.
//

#import "CHVersionUtil.h"

 
@implementation CHVersionUtil

+ (void)test:(void (^)(void))didfinish
{
    didfinish();
    NSLog(@"test ....===========================");
}

- (void)test2:(void (^)(void))didfinish
{
    didfinish();
    NSLog(@"test2 ....===========================");
}

@end
