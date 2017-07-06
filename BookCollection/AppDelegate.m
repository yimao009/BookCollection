//
//  AppDelegate.m
//  BookCollection
//
//  Created by Kwok_Rui on 2017/5/18.
//  Copyright © 2017年 Netease. All rights reserved.
//

#import "AppDelegate.h"
#import "BookListViewController.h"
#import "BookScannerViewController.h"
#import "BookAnalyticsViewController.h"
#import "BookBaseNavigationViewController.h"

#import "BookDBHelper.h"

@interface AppDelegate ()<UITabBarControllerDelegate>

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    [self initDB];
    [self initTabbar];
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - DB
- (void)initDB
{
    //checking DataBase
    NSString *dbPath = [BookDBHelper dbPath];
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:dbPath isDirectory:nil])
    {
        [BookDBHelper buildDataBase];
    }
#ifdef DEBUG
    NSLog(@"dbpath : %@",dbPath);
#endif
}

#pragma mark - tabbar
- (void)initTabbar
{
    UITabBarController *tabbarRootVC = [[UITabBarController alloc] init];
    tabbarRootVC.delegate = self;
    self.window.rootViewController = tabbarRootVC;
    
    tabbarRootVC.tabBar.barTintColor = [UIColor colorWithRed:245/250.0 green:245/250.0 blue:245/250.0 alpha:1];
    tabbarRootVC.tabBar.tintColor = [UIColor colorWithRed:0/250.0 green:157/250.0 blue:130/250.0 alpha:1];
    
    BookListViewController *bookListVC = [[BookListViewController alloc] init];
    bookListVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"我的藏书" image:[[UIImage imageNamed:@"tabbar-icon-collection"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[UIImage imageNamed:@"tabbar-icon-collection"]];
    bookListVC.title = @"我吃藏书";
    BookBaseNavigationViewController *bookListNav = [[BookBaseNavigationViewController alloc]initWithRootViewController:bookListVC];
    
    BookScannerViewController *bookScannerVC = [[BookScannerViewController alloc] init];
    bookScannerVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"扫码藏书" image:[[UIImage imageNamed:@"tabbar-icon-scan"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[UIImage imageNamed:@"tabbar-icon-scan"]];
    
    BookAnalyticsViewController *bookAnalyticsVC = [[BookAnalyticsViewController alloc] init];
    bookAnalyticsVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"我" image:[[UIImage imageNamed:@"tabbar-icon-me"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[UIImage imageNamed:@"tabbar-icon-me"]];
    bookAnalyticsVC.title = @"我";
    BookBaseNavigationViewController *bookAnalyticsNav = [[BookBaseNavigationViewController alloc] initWithRootViewController:bookAnalyticsVC];
    tabbarRootVC.viewControllers = @[bookListNav,bookScannerVC,bookAnalyticsNav];
    tabbarRootVC.tabBar.itemPositioning = UITabBarItemPositioningCentered;
}

#pragma mark - tabbar VC Delegate
- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController
{
    if ([viewController isKindOfClass:[BookScannerViewController class]])
    {
        BookScannerViewController *bookScannerController = [[BookScannerViewController alloc] init];
        UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:bookScannerController];
        
        [self.window.rootViewController presentViewController:navigationController animated:YES completion:nil];
        
        return NO;
    }
    return YES;
}


@end
