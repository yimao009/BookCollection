//
//  BookBaseNavigationViewController.m
//  BookCollection
//
//  Created by Kwok_Rui on 2017/6/13.
//  Copyright © 2017年 Netease. All rights reserved.
//

#import "BookBaseNavigationViewController.h"
#import "BookBaseViewController.h"

@interface BookBaseNavigationViewController ()

@end

@implementation BookBaseNavigationViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [[UINavigationBar appearance] setBarTintColor:UIColorFromRGB(0x009D82)];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if ([viewController isKindOfClass:[BookBaseViewController class]])
    {
        ((BookBaseViewController *)viewController).hidesBottomBarWhenPushed =[((BookBaseViewController *)viewController) shouldHideBottomBarWhenPushed];
    }else
    {
        
    }
    [super pushViewController:viewController animated:animated];
}

@end
