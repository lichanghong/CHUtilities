//
//  CHUserDefaults.h
//  CHUtilities
//
//  Created by lichanghong on 16/9/21.
//  Copyright © 2016年 lch. All rights reserved.
//


#import <Foundation/Foundation.h>

/**
 @brief use as  [CHUserDefaults setObject:@"lichanghong" forKey:@"name"];
*/
@interface CHUserDefaults : NSObject
+ (void)setObject:(NSString *)obj forKey:(NSString *)key;

+ (id)getObjectForKey:(NSString *)key;

+(void)removeObjectForKey:(NSString *)defaultName;

+ (void)removeAllObject;
@end
