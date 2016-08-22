//
//  NSObject+Runtime.m
//  BasicArchitectureProject
//  Created by 陈红荣 on 15/5/22.
//  Copyright © 2015年 chenHongRong. All rights reserved.
//

#import "NSObject+Runtime.h"

#import <objc/runtime.h>

@implementation NSObject (Runtime)

/**
 *  获取所有属性及对应的值
 *
 */
-(NSDictionary *)getAllPropertiesAndValues{
    NSMutableDictionary *props = [NSMutableDictionary dictionary];
    unsigned int outCount;
    //属性的链表
    objc_property_t *properties =class_copyPropertyList([self class], &outCount);
    //遍历链表
    for (int i = 0; i<outCount; i++)
    {
        objc_property_t property = properties[i];
        //获取属性字符串
        const char* propertyName =property_getName(property);
        //转换成NSString
        NSString *key = [NSString stringWithUTF8String:propertyName];
        //获取属性对应的value
        id value = [self valueForKey:key];
        if (value)
        {
            [props setObject:value forKey:key];
        }
    }
    //释放结构体数组内存
    free(properties);
    return props;
}

/**
 *  获取对象的所有属性
 *
 *  @return 属性数组
 */
- (NSArray *)getAllProperties
{
    unsigned int count;
    //获取属性的链表
    objc_property_t *properties  =class_copyPropertyList([self class], &count);
    
    NSMutableArray *propertiesArray = [NSMutableArray arrayWithCapacity:count];
    
    for (int i = 0; i < count ; i++)
    {
        objc_property_t property = properties[i];
        const char* propertyName =property_getName(property);
        [propertiesArray addObject: [NSString stringWithUTF8String:propertyName]];
    }
    
    free(properties);
    
    return propertiesArray;
}

/**
 *  获取对象的所有方法
 */
-(NSArray *)getAllMethods
{
    unsigned int count_f =0;
    //获取方法链表
    Method* methodList_f = class_copyMethodList([self class],&count_f);
    
    NSMutableArray *methodsArray = [NSMutableArray arrayWithCapacity:count_f];
    
    for(int i=0;i<count_f;i++)
    {
        Method temp_f = methodList_f[i];
        //方法的调用地址
        //IMP imp_f = method_getImplementation(temp_f);
        //方法
        SEL name_f = method_getName(temp_f);
        //方法名字符串
        const char* name_s =sel_getName(method_getName(temp_f));
        //参数数量
        int arguments = method_getNumberOfArguments(temp_f);
        //返回方法的参数和返回值的描述的字串
        const char* encoding =method_getTypeEncoding(temp_f);
        NSLog(@"方法名：%@,参数个数：%d,编码方式：%@",[NSString stringWithUTF8String:name_s],
              arguments,[NSString stringWithUTF8String:encoding]);
        
        NSString *methodStr = NSStringFromSelector(name_f);
        [methodsArray addObject:methodStr];
        
    }
    free(methodList_f);
    
    return methodsArray;
}

@end
