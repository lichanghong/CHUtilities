//
//  CHLocalUtil.h
//  CHUtilities
//
//  Created by li on 12/15/14.
//  Copyright (c) 2014 lch. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CHLocalUtil : NSUserDefaults


+ (void)setObject:(NSString *)obj forKey:(NSString *)key;

+ (id)getObjectForKey:(NSString *)key;

+(void)removeObjectForKey:(NSString *)defaultName;

+ (void)removeAllObject;


@end
