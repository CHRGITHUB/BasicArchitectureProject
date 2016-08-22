//
//  NSBundle+JudgeVersion.m
//  BasicArchitectureProject
//  Created by 陈红荣 on 15/5/22.
//  Copyright © 2015年 chenHongRong. All rights reserved.
//

#import "NSBundle+JudgeVersion.h"

@implementation NSBundle (JudgeVersion)

+ (BOOL)hasNewVersion
{
   //获得当前版本号
   NSString *currentVersion = [NSBundle mainBundle].infoDictionary[@"CFBundleShortVersionString"];
    
    BOOL hasNewVersion = NO;
    
    NSString *oldVersion = [[NSUserDefaults standardUserDefaults] objectForKey:AppCurrentVersionKey];
    
    if(oldVersion == nil)
    {
        hasNewVersion = YES;
    }
    else
    {
        if([currentVersion isEqualToString:oldVersion])
        {
            hasNewVersion =  NO;
        }
        else
        {
            hasNewVersion =  YES;
        }
        
    }
    
    //保存当前版本号
    [[NSUserDefaults standardUserDefaults]setObject:currentVersion forKey:AppCurrentVersionKey];
    
    return hasNewVersion;
}

@end
