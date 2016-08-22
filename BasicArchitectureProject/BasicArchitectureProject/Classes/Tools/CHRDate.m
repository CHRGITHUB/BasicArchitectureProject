//
//  CHRDate.m
//  BasicArchitectureProject
//  Created by 陈红荣 on 15/5/22.
//  Copyright © 2015年 chenHongRong. All rights reserved.
//

#import "CHRDate.h"

@implementation CHRDate


+(NSString *)getDataAtNowWithTitel:(NSString *)titel
{
    //写入日期
    NSDate *date = [NSDate date];
    NSDateFormatter *f = [[NSDateFormatter alloc] init];
    f.dateFormat = @"yyyy年MM月dd日 HH:mm:ss";
    NSString *s = [NSString stringWithFormat:@"%@:%@",titel,[f stringFromDate:date]];
    return s;
}

+(NSString *)getDataAtNow
{
    //写入日期
    NSDate *date = [NSDate date];
    NSDateFormatter *f = [[NSDateFormatter alloc] init];
    f.dateFormat = @"yy-MM-dd HH:mm:ss";
    NSString *s = [NSString stringWithFormat:@"%@",[f stringFromDate:date]];
    return s;
}

+(NSString *)getDataWithInterval:(NSTimeInterval)interval
{
    //写入日期
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:interval];
    NSDateFormatter *f = [[NSDateFormatter alloc] init];
    f.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSString *s = [NSString stringWithFormat:@"%@",[f stringFromDate:date]];
    return s;
}

+(NSString *)getDataWithInterval:(NSTimeInterval)interval Format:(NSString *)format
{
    //写入日期
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:interval];
    NSDateFormatter *f = [[NSDateFormatter alloc] init];
    f.dateFormat = format;
    NSString *s = [NSString stringWithFormat:@"%@",[f stringFromDate:date]];
    return s;
}

#pragma mark - 时间转换成字符串
+ (NSString *)getDataAtNowWithFormat:(NSString *)format Date:(NSDate *)date
{
    NSDateFormatter *f = [[NSDateFormatter alloc] init];
    f.dateFormat = format;
    NSString *s = [f stringFromDate:date];
    return s;
}


#pragma mark - 字符串转换成时间
+ (NSDate *)getDateWithString:(NSString *)string Format:(NSString *)format IsChangeZoon:(BOOL)zoon
{
    NSDateFormatter *f = [[NSDateFormatter alloc] init];
    f.dateFormat = format;
    NSDate *d = [f dateFromString:string];
    if(zoon)
    {
        //转化时区
        NSTimeZone *zone = [NSTimeZone defaultTimeZone];
        NSTimeInterval nti = [zone secondsFromGMTForDate:d];
        NSDate *date1 = [d dateByAddingTimeInterval:nti];
        return date1;
    }
    else
        return d;
}

#pragma mark - 返回自1970年到现在的秒数
+ (NSTimeInterval)timeIntervalSince1970
{
    NSDate *date = [NSDate date];
    return [date timeIntervalSince1970];
}

@end
