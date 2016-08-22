//
//  NSString+Checking.h
//  BasicArchitectureProject
//  Created by 陈红荣 on 15/5/22.
//  Copyright © 2015年 chenHongRong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Checking)
//字符串判断是否为空
- (BOOL)checkEmpty;

//验证手机号码
-(BOOL)checkMobileNumber;

 //检测邮箱是否合法
 - (BOOL)isValidateEmail;

@end
