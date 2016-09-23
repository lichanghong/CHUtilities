//
//  CHImage.h
//  CHUtilities
//
//  Created by lichanghong on 16/9/23.
//  Copyright © 2016年 lch. All rights reserved.
//
#import <UIKit/UIKit.h>

#import <Foundation/Foundation.h>

/**
 @brief 直接使用名字获取bundle中的image
 */
@interface CHImage : UIImage
+ (UIImage *)imageNamed:(NSString *)name;      // load from  bundle

@end

 
