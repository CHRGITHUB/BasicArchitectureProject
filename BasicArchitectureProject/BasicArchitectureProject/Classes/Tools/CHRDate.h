//
//  CHRDate.h
//  BasicArchitectureProject
//  Created by 陈红荣 on 15/5/22.
//  Copyright © 2015年 chenHongRong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CHRDate : NSObject

+(NSString *)getDataAtNowWithTitel:(NSString *)titel;

+(NSString *)getDataAtNow;
+(NSString *)getDataWithInterval:(NSTimeInterval)interval;
+(NSString *)getDataWithInterval:(NSTimeInterval)interval Format:(NSString *)format;

//时间转字符串
+ (NSString *)getDataAtNowWithFormat:(NSString *)format Date:(NSDate *)date;

//把时间字符串变成时间
+ (NSDate *)getDateWithString:(NSString *)string Format:(NSString *)format IsChangeZoon:(BOOL)zoon;

//返回自1970年到现在的秒数
+ (NSTimeInterval)timeIntervalSince1970;

@end
