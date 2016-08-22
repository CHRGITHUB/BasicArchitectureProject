//
//  NSString+Utils.m
//  BasicArchitectureProject
//  Created by 陈红荣 on 15/5/22.
//  Copyright © 2015年 chenHongRong. All rights reserved.
//

#import "NSString+Utils.h"

@implementation NSString (Utils)

//字符串去空格
-(NSString *)stringTrimWhitespace{
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

#pragma mark --长度宽度相关方法
//方法功能：计算字符串高度长度
- (CGSize)stringWidthWithFontSize:(CGFloat)fontSize andHeight:(CGFloat)height{
    if ([UIDevice currentDevice].systemVersion.floatValue>7.0) {
        
        NSDictionary *attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:fontSize]};
        return [self boundingRectWithSize:CGSizeMake(320, height) options:NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesLineFragmentOrigin attributes:attribute context:nil].size;
    }else{
        
        return [self sizeWithFont:[UIFont systemFontOfSize:fontSize] constrainedToSize:CGSizeMake(320, height)];
    }
}

//根据指定宽度，计算字符串高度
-(CGSize)stringheightWithFontSize:(CGFloat)fontSize andWidth:(CGFloat)width{
    if ([UIDevice currentDevice].systemVersion.floatValue>7.0) {
        
        NSDictionary *attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:fontSize]};
        return [self boundingRectWithSize:CGSizeMake(width, 3000) options:NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesLineFragmentOrigin attributes:attribute context:nil].size;
    }else{
        return [self sizeWithFont:[UIFont systemFontOfSize:fontSize] constrainedToSize:CGSizeMake(width, 3000)];
    }
}

#pragma mark --时间相关方法
// 方法功能：时间戳
+ (NSString *)getTimeStamp{
    NSDate *datenow = [NSDate date];
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[datenow timeIntervalSince1970]];
    return timeSp;
}

// 获取格式化时间时间戳
- (NSString *)getTimeStampString
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date=[dateFormatter dateFromString:self];
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[date timeIntervalSince1970]];
    return timeSp;
}

//取得格式化时间
-(NSString *)getDateTimeString
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date=[NSDate dateWithTimeIntervalSince1970:self.longLongValue];
    //用[NSDate date]可以获取系统当前时间
    NSString *dateTimeStr = [dateFormatter stringFromDate:date];
    return dateTimeStr;
}

//取得日期
-(NSString *)getDateString
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *date=[NSDate dateWithTimeIntervalSince1970:self.longLongValue];
    //用[NSDate date]可以获取系统当前时间
    NSString *dateStr = [dateFormatter stringFromDate:date];
    return dateStr;
}

#pragma mark --手机号码隐藏处理(加星号处理)
-(NSString *)securePhoneNumber
{
    NSString *regular=@"(?<=\\d{3})\\d(?=\\d{4})";
    NSRegularExpression *regularExpression = [NSRegularExpression regularExpressionWithPattern:regular options:0 error:nil];
    
    NSString *content=self;
    content  = [regularExpression stringByReplacingMatchesInString:content options:0 range:NSMakeRange(0, content.length) withTemplate:@"*"];
    
    return content;
}

#pragma mark --dictionaryToJson
+(NSString *)dictionaryToJsonStr:(id)dic
{
    if (dic==nil) {
        return nil;
    }
    
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    jsonString = [jsonString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    jsonString = [jsonString stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    //NSLog(@"JSON String = %@", jsonString);
    return jsonString;
}

// 十六进制转换为普通字符串的。
- (NSString *)stringFromHexString
{
    NSString *hexString = self;
    char *myBuffer = (char *)malloc((int)[hexString length] / 2 + 1);
    bzero(myBuffer, [hexString length] / 2 + 1);
    
    for (int i = 0; i < [hexString length] - 1; i += 2) {
        unsigned int anInt;
        NSString * hexCharStr = [hexString substringWithRange:NSMakeRange(i, 2)];
        NSScanner * scanner = [[NSScanner alloc] initWithString:hexCharStr];
        [scanner scanHexInt:&anInt];
        myBuffer[i / 2] = (char)anInt;
    }
    NSString *unicodeString = [NSString stringWithCString:myBuffer encoding:4];
    
    return unicodeString;
}

//普通字符串转换为十六进制的。
- (NSString *)hexStringFromString
{
    NSData *myD = [self dataUsingEncoding:NSUTF8StringEncoding];
    Byte *bytes = (Byte *)[myD bytes];
    //下面是Byte 转换为16进制。
    NSString *hexStr=@"";
    for(int i=0;i<[myD length];i++)
    {
        NSString *newHexStr = [NSString stringWithFormat:@"%x",bytes[i]&0xff];///16进制数
        if([newHexStr length]==1)
            hexStr = [NSString stringWithFormat:@"%@0%@",hexStr,newHexStr];
        else
            hexStr = [NSString stringWithFormat:@"%@%@",hexStr,newHexStr];
    }
    return hexStr;
}


@end
