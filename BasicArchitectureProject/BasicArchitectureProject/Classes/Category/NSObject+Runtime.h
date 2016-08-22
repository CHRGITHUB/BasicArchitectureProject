//
//  NSObject+Runtime.h
//  BasicArchitectureProject
//  Created by 陈红荣 on 15/5/22.
//  Copyright © 2015年 chenHongRong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Runtime)

//获取所有属性及对应的值
-(NSDictionary *)getAllPropertiesAndValues;

//获取对象的所有属性
- (NSArray *)getAllProperties;

//获取对象的所有方法
-(NSArray *)getAllMethods;

@end
