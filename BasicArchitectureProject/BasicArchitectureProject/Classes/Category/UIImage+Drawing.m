//
//  UIImage+Drawing.m
//  BasicArchitectureProject
//  Created by 陈红荣 on 15/5/22.
//  Copyright © 2015年 chenHongRong. All rights reserved.
//

#import "UIImage+Drawing.h"

@implementation UIImage (Drawing)

+ (UIImage *)createImage:(CGSize)size andColor:(UIColor *)color
{
    //开启图形上下文
    UIGraphicsBeginImageContext(size);
    
    //设置颜色
    [color setFill];
    
    //绘制
    UIRectFill(CGRectMake(CGPointZero.x, CGPointZero.y, 1, 1));
    
    //获取图片
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    //关闭图形上下文
    UIGraphicsEndImageContext();
    
    //返回图片
    return image;
}

@end
