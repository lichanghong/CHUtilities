//
//  MSLogManager.m
//  MobiSentry
//
//  Created by MobiSentry on 8/18/14.
//  Copyright (c) 2014 MobiSentry. All rights reserved.
//

#import "LogManager.h"
#import "CocoaLumberjack.h"


#define UPLOADLOGS_DIR_NAME  @"uploadLogs"

@implementation LogManager


+ (instancetype)defaultManager
{
    static LogManager *s_manager = nil;
    if (s_manager == nil) {
        s_manager = [[LogManager alloc]init];
#ifdef DEBUG
        [DDLog addLogger:[DDASLLogger sharedInstance]];
#endif
        [DDLog addLogger:[DDTTYLogger sharedInstance]];
        [[DDTTYLogger sharedInstance]setColorsEnabled:YES];
        
        DDFileLogger *fileLogger = [[DDFileLogger alloc] init];
        fileLogger.rollingFrequency = 60 * 60 * 24;
        fileLogger.logFileManager.maximumNumberOfLogFiles = 5;
        [DDLog addLogger:fileLogger];
    }
    return s_manager;
}


//日志上传成功之后，删除日志文件
- (void)deleteLoggersWhenPostSuccess:(NSString *)tempDir
{
    NSError *error;
    if ([[NSFileManager defaultManager]fileExistsAtPath:tempDir]) {
        BOOL success = [[NSFileManager defaultManager] removeItemAtPath:tempDir error:&error];
        if (!success) {
            DDLogInfo(@"failed to delete log file..error = %@",error);
        }
    }
    //if nil,had printed log,so don't need else statement..
}
 
- (NSString *)logContents
{
    //获得日志文件所有内容到contents
    NSMutableString *contents = nil;
    NSArray *logfilepathes = [self rawLogFilePaths];
    if (logfilepathes && logfilepathes.count>0) {
        contents = [NSMutableString string];
        for (NSString *path in logfilepathes) {
            NSError *error = nil;
            NSString *fileContent = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:&error];
            if (!error) {
                [contents appendString:fileContent];
            }
            else
            {
                DDLogInfo(@"read log content error = %@",error);
            }
        }
    }
    return contents;
}

//获得日志文件路径
- (NSArray *)sortedLogFilePaths
{
    NSArray *loggers = [DDLog allLoggers];
    DDFileLogger *fileLogger = [[loggers lastObject] class] == [DDFileLogger class]?[loggers lastObject]:nil ;
    if (fileLogger !=nil ) {
        return fileLogger.logFileManager.unsortedLogFilePaths;
    }
    else
    {
        DDLogInfo(@"get log failed");
        return nil;
    }
}
 

//临时文件目录
- (NSString *)uploadDir
{
    //caches 路径,513 error ,permission deny
    NSString *caches = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    NSString *tempLog = [caches stringByAppendingPathComponent:UPLOADLOGS_DIR_NAME];
    
    //查看目录如果已经存在就直接返回路径，否则创建目录并返回路径，如果创建路径失败则返回nil
    if (![[NSFileManager defaultManager] fileExistsAtPath:tempLog isDirectory:nil])
    {
        NSError *createError = nil;
        BOOL createSuccess = [[NSFileManager defaultManager] createDirectoryAtPath:tempLog withIntermediateDirectories:YES attributes:nil error:&createError];
        
        if (createSuccess) {
        }
        else
        {
            DDLogInfo(@"slfdlsfalf  = %@",createError);
            tempLog=nil;
        }
    }
    return tempLog;
}

- (void)moveLogsToTempLogs:(NSString *)tempLogFileDir
{
    if (tempLogFileDir != nil) {
        //log path
        NSArray *rawLogFilePaths = [self rawLogFilePaths];
        //traversal 原来的Logs文件夹下的log
        for (NSString *path in rawLogFilePaths) {
            //tempLogFile 全路径path
            NSString *tempLogFilePath = [tempLogFileDir stringByAppendingPathComponent:[[path componentsSeparatedByString:@"/"]lastObject]];
            NSError *moveError = nil;
            if ([[NSFileManager defaultManager]fileExistsAtPath:tempLogFileDir]) {
                [[NSFileManager defaultManager]moveItemAtPath:path toPath:tempLogFilePath error:&moveError];
                if (moveError!=nil && [moveError code]!=0) {
                    DDLogInfo(@"sklfjlsjflajff = %@",moveError);
                }
            }
        }
    }
}

/**
 * @brief 获得日志文件路径
 */
- (NSArray *)rawLogFilePaths
{
    NSArray *loggers = [DDLog allLoggers];
    DDFileLogger *fileLogger = [[loggers lastObject] class] == [DDFileLogger class]?[loggers lastObject]:nil ;
    if (fileLogger !=nil ) {
        NSArray *result = fileLogger.logFileManager.unsortedLogFilePaths;
        return  result;
    }
    else
    {
        DDLogInfo(@"get log failed");
        return nil;
    }
}

//- (NSMutableArray *)tempLogFilePaths
//{
//    NSString *tempLogFileDir = [self uploadDir];
//    NSError *getcontentError = nil;
//    NSArray *result = [[NSFileManager defaultManager]contentsOfDirectoryAtPath:tempLogFileDir error:&getcontentError];
//    if (getcontentError==nil || [getcontentError code]==0)
//    {
//        NSMutableArray *resultArr = [NSMutableArray array];
//        for (NSString *path in result) {
//            if ([path hasSuffix:@".log"]) {
//                NSString *resultpath = [tempLogFileDir stringByAppendingPathComponent:path];
//                [resultArr addObject:resultpath];
//            }
//        }
//        return resultArr;
//    }
//    else
//    {
//        DDLogInfo(@"getcontenterror..sjalfjaslkfjaf");
//        return nil;
//    }
//}

@end
