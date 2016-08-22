//
//  CHRArchiveFile.m
//  BasicArchitectureProject
//  Created by 陈红荣 on 15/5/22.
//  Copyright © 2015年 chenHongRong. All rights reserved.
//

#import "CHRArchiveFile.h"

@implementation CHRArchiveFile

#pragma mark - 保存文件
+ (void)archiveDocumentWithRootObject:(id)arr FileName:(NSString *)name
{
    NSArray *arr1 = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [arr1 objectAtIndex:0];
    NSString *filePath = [path stringByAppendingString:[NSString stringWithFormat:@"/%@",name]];
    [NSKeyedArchiver archiveRootObject:arr toFile:filePath];
    //    NSLog(@"%@",path);
}

#pragma mark - 读取文件
+ (id)readDocumentWithFileName:(NSString *)name
{
    NSArray *arr = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [arr objectAtIndex:0];
    //NSLog(@"%@",path);
    NSString *filePath = [path stringByAppendingString:[NSString stringWithFormat:@"/%@",name]];
    //创建一个文件管理器判断文件是否存在
    NSFileManager *fileManager = [NSFileManager defaultManager];
    //如果存在就读取
    if([fileManager fileExistsAtPath:filePath])
    {
        //如果读取成功就返回数据
        if([NSKeyedUnarchiver unarchiveObjectWithFile:filePath])
        {
            id brr = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
            return brr;
        }
        else
            return nil;
    }
    else
        return nil;
}

#pragma mark - 获得所有的沙盒文件的路径
+ (NSArray *)getFilelistFromDocument
{
    NSArray *arr = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [arr objectAtIndex:0];
    
    NSFileManager* fm=[NSFileManager defaultManager];
    if(![fm fileExistsAtPath:path]){
        [fm createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    //取得一个目录下得所有文件名
    NSArray *files = [fm subpathsAtPath:path];
    return files;
}

#pragma mark - 创建文件
+ (NSString *)createFileWithName:(NSString *)name
{
    NSArray *arr = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [arr objectAtIndex:0];
    NSString *filePath = [path stringByAppendingString:[NSString stringWithFormat:@"/%@",name]];
    return filePath;
}


@end
