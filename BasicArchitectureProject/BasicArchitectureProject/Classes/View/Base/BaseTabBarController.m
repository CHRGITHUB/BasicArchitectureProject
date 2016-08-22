//
//  BaseTabBarController.m
//  BasicArchitectureProject
//  Created by 陈红荣 on 15/5/22.
//  Copyright © 2015年 chenHongRong. All rights reserved.
//


#import "BaseTabBarController.h"

//tabBar文字颜色
#define TitleColor RGB(253, 99, 99)

//获取storyBoard  入口VC
#define boardVc(name)     ([[UIStoryboard storyboardWithName:name bundle:nil] instantiateInitialViewController])

//标题数组
#define TitleArr @[@"首页",@"分类",@"好物"]

//图片数组 默认  图片字符串
#define NormalArr @[@"tab_首页_dark",@"tab_分类_dark",@"tab_社区_dark"]

//图片数组 高亮   图片字符串
#define SelectArr @[@"tab_首页_pressed",@"tab_分类_pressed",@"tab_社区_pressed"];

//viewControllers数组  可为storyBoard名称字符串
#define VcControllers @[boardVc(@"OneStoryboard"),boardVc(@"TwoStoryboard"),boardVc(@"ThreeStroyboard")]


@interface BaseTabBarController()<UITabBarControllerDelegate>
//标题数组
@property(nonatomic,strong)NSArray *titleArr;
//默认图片数组
@property(nonatomic,strong)NSArray *normalArr;
//选中图片数组
@property(nonatomic,strong)NSArray *selectArr;
//控制器数组
@property(nonatomic,strong)NSArray *vcArr;


@property(nonatomic,readonly)NSInteger lastSelectedIndex;
@property(nonatomic,readonly)NSInteger currentSelectedIndex;

@end

@implementation BaseTabBarController

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    self.titleArr = TitleArr;
    self.normalArr = NormalArr;
    self.selectArr = SelectArr;
    self.vcArr = VcControllers;
    self.viewControllers = self.vcArr;

    for(int i=0; i<self.viewControllers.count; i++)
    {
        UIViewController *vc  = [self.viewControllers objectAtIndex:i];
        
        vc.tabBarItem = [[UITabBarItem alloc]initWithTitle:self.titleArr[i] image:[UIImage imageNamed:self.normalArr[i]] selectedImage:[UIImage imageNamed:self.selectArr[i]]];
    }
    
    self.tabBar.tintColor = TitleColor;
    self.delegate=self;
    
}





@end













