//
//  UITextField+Utils.m
//  BasicArchitectureProject
//  Created by 陈红荣 on 15/5/22.
//  Copyright © 2015年 chenHongRong. All rights reserved.
//

#import "UITextField+Utils.h"

@implementation UITextField (Utils)

-(void)setPlaceholderTextColor:(UIColor *)color
{
    self.attributedPlaceholder = [[NSAttributedString alloc] initWithString:self.placeholder attributes:@{NSForegroundColorAttributeName:color}];
}

@end
