//
//  CHRArchiveFile.h
//  BasicArchitectureProject
//  Created by 陈红荣 on 15/5/22.
//  Copyright © 2015年 chenHongRong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CHRArchiveFile : NSObject

//保存文件
+ (void)archiveDocumentWithRootObject:(id)arr FileName:(NSString *)name;

//读取文件
+ (id)readDocumentWithFileName:(NSString *)name;

//获取沙盒所有文件名称
+ (NSArray *)getFilelistFromDocument;

//创建文件
+ (NSString *)createFileWithName:(NSString *)name;

@end
