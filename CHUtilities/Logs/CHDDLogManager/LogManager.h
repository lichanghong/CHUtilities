//
//  MSLogManager.h
//  MobiSentry
//
//  Created by MobiSentry on 8/18/14.
//  Copyright (c) 2014 MobiSentry. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

/**
 @brief 将ddlog打印的日志本地化，方便打点查看或上传到服务器
 */
@interface LogManager : NSObject

+ (instancetype)defaultManager;

 

/**
 *@brief 管理员查看日志内容，只看Logs文件夹下的log信息
 *@param onlyRemote 是否只显示消息日志，如果为true就只显示消息日志，否则全部显示
 *@return 返回日志内容
 */
- (NSString *)logContents;


@end

















