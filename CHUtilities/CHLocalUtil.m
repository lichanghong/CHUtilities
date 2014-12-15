//
//  CHLocalUtil.m
//  CHUtilities
//
//  Created by li on 12/15/14.
//  Copyright (c) 2014 lch. All rights reserved.
//

#import "CHLocalUtil.h"

@implementation CHLocalUtil

+ (void)setObject:(NSString *)obj forKey:(NSString *)key
{
  [[super standardUserDefaults]setObject:obj forKey:key];
  [[super standardUserDefaults]synchronize];
}

+ (id)getObjectForKey:(NSString *)key
{
  return [[super standardUserDefaults]objectForKey:key];
}

+(void)removeObjectForKey:(NSString *)defaultName
{
  [[super standardUserDefaults]removeObjectForKey:defaultName];
  [[super standardUserDefaults]synchronize];
}

+ (void)removeAllObject
{
  NSArray *allkeys = [[[super standardUserDefaults]dictionaryRepresentation]allKeys];
  for (NSString *key in allkeys)
  {
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:key];
  }
  [[NSUserDefaults standardUserDefaults]synchronize];
}









@end
