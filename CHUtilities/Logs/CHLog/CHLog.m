//
//  CHLog.m
//  CHLog
//
//  Created by lichanghong on 16/9/12.
//  Copyright © 2016年 lichanghong. All rights reserved.
//

#import "CHLog.h"

#define UPLOADLOGS_DIR_NAME  @"chlog"
#define UploadURLStr @"http://%@/index.php/user/savelog?log=%@"


@implementation CHLog


+ (instancetype)defaultLog
{
    static CHLog *s_manager = nil;
    if (s_manager == nil) {
        s_manager = [[CHLog alloc]init];
    }
    return s_manager;
}

- (void)deleteLocalFile
{
    NSString *localfile = [[self uploadDirWithName:@"chlog_local"]stringByAppendingPathComponent:@"chlogfile.txt"];
    [[NSFileManager defaultManager]removeItemAtPath:localfile error:nil];
}

- (NSString *)logContents
{
    //获得日志文件所有内容到contents
    NSMutableString *contents = nil;
    NSArray *logfilepathes = [self logFiles];
    if (logfilepathes && logfilepathes.count>0) {
        contents = [NSMutableString string];
        for (NSString *path in logfilepathes) {
            NSError *error = nil;
            NSString *file = [[self uploadDirWithName:UPLOADLOGS_DIR_NAME]stringByAppendingPathComponent:path];
            NSString *fileContent = [NSString stringWithContentsOfFile:file encoding:NSUTF8StringEncoding error:&error];
            if (!error) {
                [contents appendString:fileContent];
            }
            else
            {
                NSLog(@"read log content error = %@",error);
            }
        }
    }
    
    BOOL empty = (contents == nil || contents.length == 0 || [[contents stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length] == 0);  //  同IsNullOrWhiteSpace
    if (!empty) {
//写入本地
        NSString *localfile = [[self uploadDirWithName:@"chlog_local"]stringByAppendingPathComponent:@"chlogfile.txt"];
        if ([[NSFileManager defaultManager]fileExistsAtPath:[self uploadDirWithName:@"chlog_local"]]) {
            NSError *err;
            [contents writeToFile:localfile atomically:YES encoding:NSUTF8StringEncoding error:&err];
            if (err) {
                NSLog(@"err=%@",err);
            }
        }
        else
        {
            NSFileHandle  *outFile;
            NSData *buffer;
            outFile = [NSFileHandle fileHandleForWritingAtPath:localfile];
            if(outFile == nil)
            {
                NSLog(@"Open of file for writing failed");
            }
            
            //找到并定位到outFile的末尾位置(在此后追加文件)
            [outFile seekToEndOfFile];
            
            //读取inFile并且将其内容写到outFile中
            buffer = [contents dataUsingEncoding:NSUTF8StringEncoding];
            
            [outFile writeData:buffer];
            //关闭读写文件
            [outFile closeFile];
        }
    }
    return contents;
}

- (void)inchlog:(NSString *)log
{
    NSString *writefile =[[self uploadDirWithName:UPLOADLOGS_DIR_NAME] stringByAppendingPathComponent: [self writeFileName]];
    BOOL write = [log writeToFile:writefile atomically:YES encoding:NSUTF8StringEncoding error:nil];
    if (write) {
        [self uploadLog:YES];
    }
    else
    {
    }
}

- (void)uploadLog:(BOOL)bforceUpload
{
    NSLog(@"%s",__func__);
    [self doUploadLog];
}

- (void)doUploadLog
{
    NSString *logcontent =[self logContents];
    BOOL empty = (logcontent == nil || logcontent.length == 0 || [[logcontent stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length] == 0);  //  同IsNullOrWhiteSpace
    
    if (!empty) {
//        存入服务器
        NSString *urlstr =[NSString stringWithFormat:UploadURLStr,IP,logcontent];
        NSURL *uploadURL = [NSURL URLWithString:[urlstr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]];
        NSURLRequest *request = [NSURLRequest requestWithURL:uploadURL];
        [[[NSURLSession sharedSession]dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            if (!error) {
                //                [self deleteLoggersWhenPostSuccess:[self uploadDir]];
            }
            else
            {
                NSLog(@"uploadlog error %@",error);
            }
        }] resume];
    }
    else
    {
        NSLog(@"uploadLog error =log content = nil");
    }
    
}

//临时文件目录
- (NSString *)uploadDirWithName:(NSString *)name
{
    //caches 路径,513 error ,permission deny
    NSString *caches = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    NSString *tempLog = [caches stringByAppendingPathComponent:name];
    
    //查看目录如果已经存在就直接返回路径，否则创建目录并返回路径，如果创建路径失败则返回nil
    if (![[NSFileManager defaultManager] fileExistsAtPath:tempLog isDirectory:nil])
    {
        NSError *createError = nil;
        BOOL createSuccess = [[NSFileManager defaultManager] createDirectoryAtPath:tempLog withIntermediateDirectories:YES attributes:nil error:&createError];
        
        if (createSuccess) {
        }
        else
        {
            NSLog(@"slfdlsfalf  = %@",createError);
            tempLog=nil;
        }
    }
    return tempLog;
}

-(NSArray *)logFiles
{
    return [[NSFileManager defaultManager]contentsOfDirectoryAtPath:[self uploadDirWithName:UPLOADLOGS_DIR_NAME] error:nil];
}

-(NSString *)writeFileName
{
    NSDate *now = [NSDate date];
    
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"yyyy-MM-dd"];
    return [df stringFromDate:now];
}



@end
