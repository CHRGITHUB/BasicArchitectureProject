//
// BaseNavigationController.m
//  BasicArchitectureProject
//  Created by 陈红荣 on 15/5/22.
//  Copyright © 2015年 chenHongRong. All rights reserved.
//

#import "BaseNavigationController.h"

//导航栏背景色
#define COLOR_NAVBAR_BG RGB(253,99,99)
//导航栏文字颜色
#define COLOR_BAR_TITLE [UIColor whiteColor]
//导航栏文字大小
#define FONT_BAR_TITIE 20.f


@interface BaseNavigationController()

//导航栏背景色
@property(nonatomic,strong)UIColor *backGroundColor;

//导航栏文字颜色
@property(nonatomic,strong)UIColor *titleColor;

//导航栏文字大小
@property(nonatomic,assign)float titleSize;

@end

@implementation BaseNavigationController

-(void)viewDidLoad
{
    [super viewDidLoad];
    self.backGroundColor = COLOR_NAVBAR_BG;
    self.titleColor = COLOR_BAR_TITLE;
    self.titleSize = FONT_BAR_TITIE;
    [self customNavigationBar];
    
    
}

#pragma mark --自定义导航栏
-(void)customNavigationBar
{
    self.navigationBar.titleTextAttributes = @{
            NSForegroundColorAttributeName:[UIColor whiteColor],
            NSFontAttributeName:[UIFont boldSystemFontOfSize:self.titleSize]
                                               };
    self.navigationBar.barTintColor = self.backGroundColor;
    self.navigationBar.tintColor = self.titleColor;
    
    
}








@end
