//
//  CHImage.m
//  CHUtilities
//
//  Created by lichanghong on 16/9/23.
//  Copyright © 2016年 lch. All rights reserved.
//

#import "CHImage.h"

@implementation CHImage
+ (UIImage *)imageNamed:(NSString *)name
{
    name = [NSString stringWithFormat:@"Bundle.bundle/%@",name];
    return [UIImage imageNamed:name];
}
@end
