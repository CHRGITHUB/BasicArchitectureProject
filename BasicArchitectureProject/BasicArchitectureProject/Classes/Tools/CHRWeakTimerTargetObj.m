//
//  CHRWeakTimerTargetObj.m
//  BasicArchitectureProject
//  Created by 陈红荣 on 15/5/22.
//  Copyright © 2015年 chenHongRong. All rights reserved.
//

#import "CHRWeakTimerTargetObj.h"

@interface CHRWeakTimerTargetObj()

@property (nonatomic, weak) id aTarget;
@property (nonatomic, assign) SEL aSelector;
@end
/**
 *  该类的作用是用来接管定时器的强引用
 */
#pragma mark - 接管定时器的强引用
@implementation CHRWeakTimerTargetObj

+ (NSTimer *)scheduledTimerWithTimeInterval:(NSTimeInterval)time target:(id)aTarget selector:(SEL)aSelector userInfo:(nullable id)userInfo repeats:(BOOL)yesOrNo {
    
    // 创建当前类对象
    CHRWeakTimerTargetObj *obj = [[CHRWeakTimerTargetObj alloc] init];
    obj.aTarget = aTarget; // 控制器
    obj.aSelector = aSelector; // 控制器的update方法
    
    return [NSTimer scheduledTimerWithTimeInterval:time target:obj selector:@selector(update:) userInfo:userInfo repeats:yesOrNo];
}

- (void)update:(NSTimer *)timer {

    [self.aTarget performSelector:self.aSelector withObject:timer];
    
}
@end
