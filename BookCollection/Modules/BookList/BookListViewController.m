//
//  BookListViewController.m
//  BookCollection
//
//  Created by Kwok_Rui on 2017/5/18.
//  Copyright © 2017年 Netease. All rights reserved.
//

#import "BookListViewController.h"

#import "BookListTableViewController.h"
#import "BookListCollectionViewController.h"

typedef NS_ENUM(NSUInteger, BookListMode) {
    BookListModeTable,
    BookListModeCollection,
};

@interface BookListViewController ()
@property (nonatomic,assign) BookListMode bookListMode;
@end

@implementation BookListViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initNavigationBar];
    
    self.bookListMode = BookListModeTable;

    [self switchToMode:self.bookListMode];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - initNavigationBar
- (void)initNavigationBar
{
    self.navigationItem.title = @"我的藏书";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"list-switch-collection"] style:UIBarButtonItemStylePlain target:self action:@selector(didTapSwitchButton:)];
}

- (void)didTapSwitchButton:(UIBarButtonItem *)barButton
{
    [self.childViewControllers makeObjectsPerformSelector:@selector(willMoveToParentViewController:) withObject:nil];
    [self.view.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.childViewControllers makeObjectsPerformSelector:@selector(removeFromParentViewController)];
    [self.childViewControllers makeObjectsPerformSelector:@selector(didMoveToParentViewController:) withObject:nil];
    
    if (self.bookListMode == BookListModeTable)
    {
        self.bookListMode = BookListModeCollection;
        barButton.image = [UIImage imageNamed:@"list-switch-table"];
    }else
    {
        self.bookListMode = BookListModeTable;
        barButton.image = [UIImage imageNamed:@"list-switch-collection"];
    }
    [self switchToMode:self.bookListMode];
}

- (void)switchToMode:(BookListMode)mode
{
    if (mode == BookListModeTable)
    {
        BookListTableViewController *controller = [[BookListTableViewController alloc] init];
        [controller willMoveToParentViewController:self];
        [self addChildViewController:controller];
        [self.view addSubview:controller.view];
        controller.view.frame = self.view.bounds;
        [controller didMoveToParentViewController:self];
    }else
    {
        BookListCollectionViewController *controller = [[BookListCollectionViewController alloc] init];
        [controller willMoveToParentViewController:self];
        [self addChildViewController:controller];
        [self.view addSubview:controller.view];
        controller.view.frame = self.view.bounds;
        [controller didMoveToParentViewController:self];
    }
}
@end
