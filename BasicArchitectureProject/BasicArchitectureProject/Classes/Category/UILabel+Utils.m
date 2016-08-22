//
//  UILabel+Utils.m
//  BasicArchitectureProject
//  Created by 陈红荣 on 15/1/22.
//  Copyright © 2015年 chenHongRong. All rights reserved.
//

#import "UILabel+Utils.h"

@implementation UILabel (Utils)

//给label指定text的颜色、字体
-(void)addAttributesText:(NSString *)text color:(UIColor *)color font:(UIFont *)font
{
    [self addAttributesText:text color:color];
    [self addAttributesText:text font:font];
}

//给label指定text的颜色、字体大小(系统字体)
-(void)addAttributesText:(NSString *)text color:(UIColor *)color fontSize:(int)fontSize
{
    [self addAttributesText:text color:color];
    [self addAttributesText:text fontSize:fontSize];
}

//给label指定text的颜色
-(void)addAttributesText:(NSString *)text color:(UIColor *)color
{
    NSRange range = [[self.attributedText string] rangeOfString:text];
    if(range.location != NSNotFound)
    {
        NSMutableAttributedString *mat = [self.attributedText mutableCopy];
        [mat addAttributes:@{NSForegroundColorAttributeName:color} range:range];
        self.attributedText = mat;
    }
}

//给label指定text的字体
-(void)addAttributesText:(NSString *)text fontSize:(int)fontSize
{
    NSRange range = [[self.attributedText string] rangeOfString:text];
    if(range.location != NSNotFound)
    {
        NSMutableAttributedString *mat = [self.attributedText mutableCopy];
        [mat addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]} range:range];
        self.attributedText = mat;
    }
}

//给label指定text的字体(系统字体)
-(void)addAttributesText:(NSString *)text font:(UIFont *)font
{
    NSRange range = [[self.attributedText string] rangeOfString:text];
    if(range.location != NSNotFound)
    {
        NSMutableAttributedString *mat = [self.attributedText mutableCopy];
        [mat addAttributes:@{NSFontAttributeName:font} range:range];
        self.attributedText = mat;
    }
}


@end
