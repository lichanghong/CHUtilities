//
//  CHLog.h
//  CHLog
//
//  Created by lichanghong on 16/9/12.
//  Copyright © 2016年 lichanghong. All rights reserved.
//  本类为日志类，用于个人测试使用，跟踪难以复现的bug使用。 by 李长鸿



#import <Foundation/Foundation.h>

//本地服务器必填
#define IP @"192.168.0.54"

#define hhlog(FORMAT, ...) {\
NSString *str = [NSString stringWithFormat:@"chlog fun=%s num=%d [--%@--]\n",__func__, __LINE__,[NSString stringWithFormat:FORMAT, ##__VA_ARGS__]];\
[[CHLog defaultLog]inchlog:str];\
NSLog(@"%@",str);\
}\



/**
 @brief use like NSLog() for example: hhlog(@"test log by lichanghong");
 */
@interface CHLog : NSObject

+ (instancetype)defaultLog;

- (void)inchlog:(NSString *)log;
/**
 *@brief 管理员查看日志内容，只看Logs文件夹下的log信息
 *@param onlyRemote 是否只显示消息日志，如果为true就只显示消息日志，否则全部显示
 *@return 返回日志内容
 */
- (NSString *)logContents;


@end
