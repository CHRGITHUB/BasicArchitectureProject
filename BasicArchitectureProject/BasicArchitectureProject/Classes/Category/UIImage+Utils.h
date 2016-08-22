//
//  UIImage+Utils.h
//
//  BasicArchitectureProject
//  Created by 陈红荣 on 15/5/22.
//  Copyright © 2015年 chenHongRong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Utils)

//使用颜色创建图片
+ (UIImage *)imageWithColor:(UIColor *)color andSize:(CGSize)size;
//拉伸图片  主要用途动态修改某图片
+(UIImage *)stretchableImageWithLeftCapWidth:(float)width topCapHeight:(float)height ImageNamed:(NSString *)imageNamed;

//缩放图片
- (UIImage *)scaleToSize:(CGSize)newsize;

//填充图片颜色
- (UIImage *)imageWithOverlayColor:(UIColor *)color;

//按照百分比填充颜色
- (UIImage*) imageTransparent:(UIColor*)color Percent:(float)f;


- (UIImage *)scaledImageV2WithWidth:(CGFloat)aWidth andHeight:(CGFloat)aHeight;
- (UIImage *) scaledImageWithWidth:(CGFloat)width andHeight:(CGFloat)height;
- (UIImage *)scaledHeadImageWithWidth:(CGFloat)aWidth andHeight:(CGFloat)aHeight;

///  图片压缩
+(NSData *)compressImage:(UIImage *)aSrcImage       //原始图
              andQuality:(CGFloat)aQuality          //图片压缩质量
              andMaxSize:(CGSize)maxSize             //图片最大尺寸，宽*高
        andMaxDataLength:(NSUInteger)maxDataLength; //返回NSData 的长度,单位是KByte


@end
