//
//  CHUserDefaults.m
//  CHUtilities
//
//  Created by lichanghong on 16/9/21.
//  Copyright © 2016年 lch. All rights reserved.
//

#import "CHUserDefaults.h"

@implementation CHUserDefaults

+ (void)setObject:(NSString *)obj forKey:(NSString *)key
{
    [[NSUserDefaults standardUserDefaults]setObject:obj forKey:key];
    [[NSUserDefaults standardUserDefaults]synchronize];
}

+ (id)getObjectForKey:(NSString *)key
{
    return [[NSUserDefaults standardUserDefaults]objectForKey:key];
}

+(void)removeObjectForKey:(NSString *)defaultName
{
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:defaultName];
    [[NSUserDefaults standardUserDefaults]synchronize];
}

+ (void)removeAllObject
{
    NSArray *allkeys = [[[NSUserDefaults standardUserDefaults]dictionaryRepresentation]allKeys];
    for (NSString *key in allkeys)
    {
        [[NSUserDefaults standardUserDefaults]removeObjectForKey:key];
    }
    [[NSUserDefaults standardUserDefaults]synchronize];
}



@end
