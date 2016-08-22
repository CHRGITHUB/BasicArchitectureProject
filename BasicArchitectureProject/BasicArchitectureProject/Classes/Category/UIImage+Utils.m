//
//  UIImage+Utils.m
//  BasicArchitectureProject
//  Created by 陈红荣 on 15/5/22.
//  Copyright © 2015年 chenHongRong. All rights reserved.
//

#import "UIImage+Utils.h"

@implementation UIImage (Utils)

//使用颜色创建图片
+ (UIImage *)imageWithColor:(UIColor *)color andSize:(CGSize)size
{
    CGRect rect = CGRectMake(0.0f, 0.0f, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

//拉伸图片  主要用途动态修改某图片
+(UIImage *)stretchableImageWithLeftCapWidth:(float)width topCapHeight:(float)height ImageNamed:(NSString *)imageNamed{
    
    UIImage *img=[UIImage imageNamed:imageNamed];
    img=[img stretchableImageWithLeftCapWidth:width topCapHeight:height];
    return img;
}


#pragma mark - 修改图片大小尺寸
- (UIImage *)scaleToSize:(CGSize)newsize{
    
    // 创建一个bitmap的context
    
    // 并把它设置成为当前正在使用的context
    
    UIGraphicsBeginImageContext(newsize);
    
    // 绘制改变大小的图片
    
    [self drawInRect:CGRectMake(0, 0, newsize.width, newsize.height)];
    
    // 从当前context中创建一个改变大小后的图片
    
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // 使当前的context出堆栈
    
    UIGraphicsEndImageContext();
    
    // 返回新的改变大小后的图片
    return scaledImage;
    
}

- (UIImage *)imageWithOverlayColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, self.size.width, self.size.height);
    
    if (UIGraphicsBeginImageContextWithOptions) {
        CGFloat imageScale = 1.0f;
        if (self && [self respondsToSelector:@selector(scale)])  // The scale property is new with iOS4.
            imageScale = self.scale;
        UIGraphicsBeginImageContextWithOptions(self.size, NO, imageScale);
    }
    else {
        UIGraphicsBeginImageContext(self.size);
    }
    
    [self drawInRect:rect];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetBlendMode(context, kCGBlendModeSourceIn);
    
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

void ProviderReleaseData (void *info, const void *data, size_t size)
{
    free((void*)data);
}

- (UIImage*) imageTransparent:(UIColor*)color Percent:(float)f
{
    // 分配内存
    const int imageWidth = self.size.width;
    const int imageHeight = self.size.height;
    size_t      bytesPerRow = imageWidth * 4;
    uint32_t* rgbImageBuf = (uint32_t*)malloc(bytesPerRow * imageHeight);
    
    // 创建context
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(rgbImageBuf, imageWidth, imageHeight, 8, bytesPerRow, colorSpace,
                                                 kCGBitmapByteOrder32Little | kCGImageAlphaNoneSkipLast);
    CGContextDrawImage(context, CGRectMake(0, 0, imageWidth, imageHeight), self.CGImage);
    
    // 遍历像素
    int pixelNum = imageWidth * imageHeight*f;
    uint32_t* pCurPtr = rgbImageBuf;
    for (int i = 0; i < imageHeight;i++)
    {
        for(int i = 0;i<imageWidth;i++)
        {
            if ((*pCurPtr & 0xFFFFFF00) == 0xff440000)    // 将白色变成透明
            {
                uint8_t* ptr = (uint8_t*)pCurPtr;
                ptr[0] = 0x00;
                ptr[1] = 0xff;
                ptr[2] = 0x00;
            }
        }
    }

    
    // 将内存转成image
    CGDataProviderRef dataProvider = CGDataProviderCreateWithData(NULL, rgbImageBuf, bytesPerRow * imageHeight, ProviderReleaseData);
    CGImageRef imageRef = CGImageCreate(imageWidth, imageHeight, 8, 32, bytesPerRow, colorSpace,
                                        kCGImageAlphaLast | kCGBitmapByteOrder32Little, dataProvider,
                                        NULL, true, kCGRenderingIntentDefault);
    CGDataProviderRelease(dataProvider);
    
    UIImage* resultUIImage = [UIImage imageWithCGImage:imageRef];
    
    // 释放
    CGImageRelease(imageRef);
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    // free(rgbImageBuf) 创建dataProvider时已提供释放函数，这里不用free
    
    return resultUIImage;
}




+(NSData *)compressImage:(UIImage *)aSrcImage       //原始图
              andQuality:(CGFloat)aQuality          //图片压缩质量
              andMaxSize:(CGSize)maxSize             //图片最大尺寸，宽*高
        andMaxDataLength:(NSUInteger)maxDataLength{
    
    if (aSrcImage == nil) {
        return nil;
    }
    int imageSize = (int)maxDataLength;
    NSData *ret = nil;
    
    if (aQuality>1 || aQuality < 0.3){
        aQuality = 0.65;
    }
    
    NSLog(@"<_compressAndSend> ========== Start ==========");
    UIImage *image = aSrcImage;
    CGSize sizeBig = aSrcImage.size;
    CGFloat maxLength = (maxSize.width > maxSize.height ? maxSize.width : maxSize.height);
    double rateW = maxLength/sizeBig.width;
    double rateH = maxLength/sizeBig.height;
    double rate = rateW<rateH?rateW:rateH;
    
    image = [aSrcImage scaledImageWithWidth:sizeBig.width*rate andHeight:sizeBig.height*rate];
    NSLog(@"<_compressAndSend> 图片尺寸压缩到 = %f x %f",image.size.width,image.size.height);
    
    //原始图片文件体积
    NSData *data = UIImageJPEGRepresentation(image,aQuality);
    //    NSLog(@"<_compressAndSend> 原始图片文件大小%u,直接发送",[data length]);
    
    //如果文件体积小于  直接发送
    if ([data length] < 1024 * imageSize){
        NSLog(@"<_compressAndSend> 图片文件体积小于%ldK,直接发送",maxDataLength);
        ret = data;
    }else{
        NSLog(@"<_compressAndSend> 图片文件体积大于%ldK,准备压缩后发送",maxDataLength);
        NSData *data  = UIImageJPEGRepresentation(image,aQuality);
        NSInteger i = 1;
        while([data length] > 1024 *imageSize)
        {
            NSLog(@"<_compressAndSend> 正在进行第%ld次压缩,压缩前文件体积：%lu",(long)i,[data length]);
            
            rate = rate * 0.8;
            image = [aSrcImage scaledImageWithWidth:sizeBig.width * rate andHeight:sizeBig.height * rate];
            data = UIImageJPEGRepresentation(image,aQuality);
            NSLog(@"<_compressAndSend> 第%ld次压缩完成,压缩后文件体积：%lu",(long)i,[data length]);
            i++;
        }
        ret = data;
    }
    return ret;
}


- (UIImage *)scaledImageV2WithWidth:(CGFloat)aWidth andHeight:(CGFloat)aHeight{
    CGRect rect = CGRectIntegral(CGRectMake(0, 0, aWidth,aHeight));
    UIGraphicsBeginImageContext(rect.size);
    [self drawInRect:rect];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
}

- (UIImage *)scaledImageWithWidth:(CGFloat)aWidth andHeight:(CGFloat)aHeight
{
    aWidth = aWidth > self.size.width ? self.size.width : aWidth;
    aHeight = aHeight > self.size.height ? self.size.height : aHeight;
    
    CGRect rect = CGRectIntegral(CGRectMake(0, 0, aWidth,aHeight));
    UIGraphicsBeginImageContext(rect.size);
    [self drawInRect:rect];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
}


- (UIImage *)scaledHeadImageWithWidth:(CGFloat)aWidth andHeight:(CGFloat)aHeight
{
    CGSize endSize = CGSizeMake(aWidth, aHeight);
    CGRect backRect = CGRectMake(0, 0, aWidth, aHeight);
    float imagex =0;
    float imagey =0;
    
    BOOL needBack = NO;
    if (self.size.width > self.size.height) {
        aWidth = aWidth > self.size.width ? self.size.width : aWidth;
        imagex =0;
        float ff = self.size.width /aWidth;
        aHeight = self.size.height/ff;
        imagey = (aWidth-aHeight)/2;
        needBack =YES;
        backRect = CGRectMake(0, 0, aWidth, aWidth);
        endSize = CGSizeMake(aWidth, aWidth);
    }
    else if(self.size.width < self.size.height)
    {
        aHeight = aHeight > self.size.height ? self.size.height : aHeight;
        imagey =0;
        float ff = self.size.height /aHeight;
        aWidth = self.size.width/ff;
        imagex = (aHeight-aWidth)/2;
        needBack =YES;
        backRect = CGRectMake(0, 0, aHeight, aHeight);
        endSize = CGSizeMake(aHeight, aHeight);
    }
    else
    {
        aWidth = aWidth > self.size.width ? self.size.width : aWidth;
        aHeight = aHeight > self.size.height ? self.size.height : aHeight;
    }
    CGRect rect = CGRectMake(imagex, imagey, aWidth,aHeight);
    UIGraphicsBeginImageContext(endSize);  //rect.size);
    
    if (needBack) {
        // get a reference to that context we created
        CGContextRef context = UIGraphicsGetCurrentContext();
        
        UIColor *color = [UIColor blackColor];
        CGContextSetFillColorWithColor(context, color.CGColor);
        CGContextAddRect(context, backRect);
        CGContextDrawPath(context,kCGPathFill);
    }
    [self drawInRect:rect];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
}

@end
