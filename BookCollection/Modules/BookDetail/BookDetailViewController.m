//
//  BookDetailViewController.m
//  BookCollection
//
//  Created by Kwok_Rui on 2017/6/14.
//  Copyright © 2017年 Netease. All rights reserved.
//

#import "BookDetailViewController.h"

#import "BookAuthor.h"
#import "BookTag.h"
#import "BookTranslator.h"

#import <UIImageView+WebCache.h>

#import "BookDetailService.h"

#define kBackgroundHeight 270.5f //背景高度
#define kNavHeight 64.0f

@interface BookDetailViewController ()<UIScrollViewDelegate>
@property (nonatomic,strong) UIImageView *backgroundImageView;
@end

@implementation BookDetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];

    //获取状态栏高度 和 导航栏高度
    // (statusbar)
    CGRect rectOfStatusbar = [[UIApplication sharedApplication] statusBarFrame];
    NSLog(@"statusbar height: %f", rectOfStatusbar.size.height);   // 高度
    
    //（navigationbar）
    CGRect rectOfNavigationbar = self.navigationController.navigationBar.frame;
    NSLog(@"navigationbar height: %f", rectOfNavigationbar.size.height);
    
    [self initNavigation];
    [self initSubViews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation
- (void)initNavigation
{
    self.navigationItem.title = @"书籍详情";
}

- (BOOL)shouldShowShadowImage
{
    return NO;
}

- (UIImage *)navigationBarBackgroundImage
{
    return [UIImage new];
}

- (BOOL)shouldHideBottomBarWhenPushed
{
    return YES;
}

#pragma mark - subViews
- (void)initSubViews
{
    [self initBackgroundView];
    [self initScrollView];
}

- (void)initBackgroundView
{
    self.backgroundImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"detail-topbg"]];
    self.backgroundImageView.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.frame), kBackgroundHeight);
    self.backgroundImageView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [self.view addSubview:self.backgroundImageView];
}

- (void)initScrollView
{
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, kNavHeight, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds)-kNavHeight)];
    scrollView.alwaysBounceVertical = YES;
    scrollView.delegate = self;
    scrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:scrollView];
    
    //头部
    UIView *headView = [[UIView alloc] init];
    headView.translatesAutoresizingMaskIntoConstraints = NO;
    [scrollView addSubview:headView];
    
    [scrollView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[headView(==206.5)]"
                                                                      options:NSLayoutFormatAlignAllCenterX
                                                                      metrics:nil
                                                                        views:NSDictionaryOfVariableBindings(headView,scrollView)]];
    
    [scrollView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[headView(==scrollView)]"
                                                                       options:0
                                                                       metrics:nil
                                                                         views:NSDictionaryOfVariableBindings(headView,scrollView)]];
    //封面
    UIImageView *coverImageView = [[UIImageView alloc] init];
    coverImageView.translatesAutoresizingMaskIntoConstraints = NO;
    coverImageView.backgroundColor = [UIColor whiteColor];
    [coverImageView sd_setImageWithURL:[NSURL URLWithString:self.bookEntity.image]];
    [headView addSubview:coverImageView];
    
    [headView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-16-[coverImageView(115)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(coverImageView)]];
    
    [headView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-16-[coverImageView(161)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(coverImageView)]];
    
    //标题
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    titleLabel.font = [UIFont systemFontOfSize:17.0f];
    titleLabel.text = self.bookEntity.title;
    titleLabel.textColor = [UIColor whiteColor];
    [headView addSubview:titleLabel];
    
    [headView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[coverImageView]-14-[titleLabel]-(>=15)-|" options:NSLayoutFormatAlignAllTop metrics:nil views:NSDictionaryOfVariableBindings(coverImageView,titleLabel)]];
    
    //详细信息
    NSMutableArray *itemsText = [@[] mutableCopy];
    
    if (self.bookEntity.authors)
    {
        NSString *authorList = @"";
        for (BookAuthor *author in self.bookEntity.authors)
        {
            authorList = [[authorList stringByAppendingString:author.name] stringByAppendingString:@" "];
        }
        [itemsText addObject:[NSString stringWithFormat:@"作者:%@",authorList]];
    }
    
    if (self.bookEntity.translators)
    {
        NSString *translatorsList = @"";
        for (BookTranslator *translator in self.bookEntity.translators)
        {
            translatorsList = [[translatorsList stringByAppendingString:translator.name] stringByAppendingString:@" "];
        }
        [itemsText addObject:[NSString stringWithFormat:@"译者:%@",translatorsList]];
    }
    
    if (self.bookEntity.publisher)
    {
        [itemsText addObject:[NSString stringWithFormat:@"出版社:%@",self.bookEntity.publisher]];
    }
    if (self.bookEntity.pubdate)
    {
        [itemsText addObject:[NSString stringWithFormat:@"出版时间:%@",self.bookEntity.pubdate]];
    }
    if (self.bookEntity.price)
    {
        [itemsText addObject:[NSString stringWithFormat:@"价钱:%@",self.bookEntity.price]];
    }
    if (self.bookEntity.isbn13)
    {
        [itemsText addObject:[NSString stringWithFormat:@"ISBN:%@",self.bookEntity.isbn13]];
    }else
    {
        [itemsText addObject:[NSString stringWithFormat:@"ISBN:%@",self.bookEntity.isbn10]];
    }
    
    __block UILabel *lastLabel = titleLabel;
    
    [itemsText enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UILabel *itemLabel = [[UILabel alloc] init];
        itemLabel.translatesAutoresizingMaskIntoConstraints = NO;
        itemLabel.text = obj;
        itemLabel.textColor = [UIColor whiteColor];
        itemLabel.font = [UIFont systemFontOfSize:11.0f];
        [headView addSubview:itemLabel];
        
        [headView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[coverImageView]-14-[itemLabel]-(>=15)-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(coverImageView,itemLabel)]];
        [headView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[lastLabel]-4-[itemLabel]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(itemLabel,lastLabel)]];
        
        lastLabel = itemLabel;
    }];
    
    //收藏按钮
    UIButton *favButton = [UIButton buttonWithType:UIButtonTypeCustom];
    favButton.translatesAutoresizingMaskIntoConstraints = NO;
    favButton.titleLabel.font = [UIFont systemFontOfSize:12.0f];
    [favButton setBackgroundColor:[UIColor whiteColor]];
    [favButton setTitle:@"收藏" forState:UIControlStateNormal];
    [favButton setTitle:@"已收藏" forState:UIControlStateDisabled];
    [favButton setTitleColor:UIColorFromRGB(0x00A25B) forState:UIControlStateNormal];
    [favButton setTitleColor:UIColorFromRGB(0xB8B8B8) forState:UIControlStateDisabled];
    favButton.layer.cornerRadius = 2.0f;
    [favButton addTarget:self action:@selector(didTapFavButton:) forControlEvents:UIControlEventTouchUpInside];
    [headView addSubview:favButton];
    
    BookEntity *entity = [BookDetailService searchFaveBookWithDoubanId:self.bookEntity.doubanId];
    if (entity)
    {
        [favButton setEnabled:NO];
    }
    
    [headView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[coverImageView]-14-[favButton(==70)]" options:NSLayoutFormatAlignAllBottom metrics:nil views:NSDictionaryOfVariableBindings(coverImageView,favButton)]];
    
    [headView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[favButton(==27)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(favButton)]];
    
    //底部
    UIView *bodyView = [[UIView alloc] init];
    bodyView.translatesAutoresizingMaskIntoConstraints = NO;
    bodyView.backgroundColor = [UIColor whiteColor];
    [scrollView addSubview:bodyView];
    
    [scrollView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[bodyView(==scrollView)]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(bodyView,scrollView)]];
    [scrollView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[headView]-0-[bodyView]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(bodyView,scrollView,headView)]];
    
    //内容简介
    UILabel *summaryLabel = [[UILabel alloc] init];
    summaryLabel.textColor = UIColorFromRGB(0x555555);
    summaryLabel.text = @"内容简介";
    summaryLabel.font = [UIFont systemFontOfSize:16.0f];
    summaryLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [bodyView addSubview:summaryLabel];
    
    //内容简介详情
    UILabel *detailLabel = [[UILabel alloc] init];
    detailLabel.text = self.bookEntity.summary;
    detailLabel.textColor = UIColorFromRGB(0x999999);
    detailLabel.font = [UIFont systemFontOfSize:15.0f];
    detailLabel.translatesAutoresizingMaskIntoConstraints = NO;
    detailLabel.numberOfLines = 0;
    [bodyView addSubview:detailLabel];
    
    [bodyView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-15-[summaryLabel]-6.5-[detailLabel]-15-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(summaryLabel,detailLabel)]];
    [bodyView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-15-[summaryLabel]-15-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(summaryLabel)]];
    [bodyView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-15-[detailLabel]-15-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(detailLabel)]];
}

#pragma mark - scroll response
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //向下滚动
    if (scrollView.contentOffset.y < 0)
    {
        self.backgroundImageView.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), kBackgroundHeight - scrollView.contentOffset.y);
    }else
    {
        self.backgroundImageView.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), kBackgroundHeight);
    }
}

#pragma mark - actions
- (void)didTapFavButton:(UIButton *)sender
{
    long long bookId = [BookDetailService favBook:self.bookEntity];
    if (bookId > 0)
    {
        [sender setEnabled:NO];
    }
}

@end
