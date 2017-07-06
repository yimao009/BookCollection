//
//  BookListTableViewController.m
//  BookCollection
//
//  Created by Kwok_Rui on 2017/6/22.
//  Copyright © 2017年 Netease. All rights reserved.
//

#import "BookListTableViewController.h"
#import "   BookListService.h"
#import "BookListTableViewCell.h"
#import "BookListTableViewCell+BookEntity.h"
#import "BookDetailService.h"

#import "BookFPSLabel.h"

@interface BookListTableViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,weak) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray<BookEntity *> *bookEntities;
@end

@implementation BookListTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor redColor];
    
    [self initTableView];
    [self getData];
    
    BookFPSLabel *label = [[BookFPSLabel alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 20)];
    label.backgroundColor = [UIColor greenColor];
    [self.view addSubview:label];
    [self.view bringSubviewToFront:label];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self getData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - getData
- (void)getData
{
    self.bookEntities = [[BookListService getAllBookEntites] mutableCopy];
    [self.tableView reloadData];
}

#pragma mark - initTableView
- (void)initTableView
{
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame)) style:UITableViewStylePlain];
    [self.view addSubview:tableView];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.backgroundColor = UIColorFromRGB(0xF9F9F9);
    tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth |UIViewAutoresizingFlexibleHeight;
    tableView.tableFooterView = [UIView new];
    self.tableView = tableView;
}

#pragma mark - UITableView datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.bookEntities.count;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *reuseIdentifer = @"bookListTableViewCell";
    BookListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifer];
    if (nil == cell)
    {
        cell = [[BookListTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifer];
    }
    BookEntity *bookEntity = self.bookEntities[indexPath.row];
    [cell configureWithBookEntity:bookEntity];
    return cell;
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        BookEntity *bookEntity = self.bookEntities[indexPath.row];
        BOOL succ = [BookDetailService unFavBookWithId:bookEntity.id];
        if (succ)
        {
            [tableView beginUpdates];
            [self.bookEntities removeObject:bookEntity];
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            [tableView endUpdates];
            
        }
    }
}
#pragma mark - UITableView delegate
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"取消收藏";
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return  100.0f;
}
- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
@end
