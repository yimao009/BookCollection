//
//  BookBaseViewController.m
//  BookCollection
//
//  Created by Kwok_Rui on 2017/6/13.
//  Copyright © 2017年 Netease. All rights reserved.
//

#import "BookBaseViewController.h"

@interface BookBaseViewController ()

@end

@implementation BookBaseViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self adjustNavigator];
}

#pragma mark - navigation config
- (void)adjustNavigator
{
//    是否显示导航栏底部的线
    if ([self shouldShowShadowImage])
    {
        [self.navigationController.navigationBar setShadowImage:nil];
    }else
    {
        [self.navigationController.navigationBar setShadowImage:[UIImage new]];
        [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault
         ];
    }
    
//    是否使用自定义背景（透明）
    if ([self navigationBarBackgroundImage])
    {
        [self.navigationController.navigationBar setBackgroundImage:[self navigationBarBackgroundImage] forBarMetrics:UIBarMetricsDefault];
    }else
    {
        
        [self.navigationController.navigationBar setBarTintColor:UIColorFromRGB(0x009D82)]; 
        [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    }
}
- (UIImage *)navigationBarBackgroundImage
{
    return nil;
}

- (BOOL)shouldShowShadowImage
{
    return NO;
}

- (BOOL)shouldHideBottomBarWhenPushed
{
    return NO;
}

@end
