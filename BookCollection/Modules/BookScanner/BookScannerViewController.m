//
//  BookScannerViewController.m
//  BookCollection
//
//  Created by Kwok_Rui on 2017/5/18.
//  Copyright © 2017年 Netease. All rights reserved.
//

#import "BookScannerViewController.h"
#import "BookScanView.h"
#import <AVFoundation/AVCaptureSession.h>
#import <AVFoundation/AVMediaFormat.h>

#import <AVFoundation/AVCaptureDevice.h>
#import <AVFoundation/AVCaptureInput.h>
#import <AVFoundation/AVCaptureOutput.h>
#import <AVFoundation/AVCaptureVideoPreviewLayer.h>
#import <AVFoundation/AVMetadataObject.h>

#import <AFNetworking/AFNetworking.h>

#import "BookDetailViewController.h"

#import "BookDetailService.h"

@interface BookScannerViewController ()<AVCaptureMetadataOutputObjectsDelegate>

@property (nonatomic,strong) BookScanView *scanView;
@property (nonatomic,strong) AVCaptureSession *captureSession;
@property (nonatomic,strong) UIActivity *activity;

@end

@implementation BookScannerViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [self initNavigation];
    [self initSubviews];
    
//    [self AddDatabaseWithTestBigData:@"灵魂" withStart:0];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

#pragma mark - Navigation
- (void)initNavigation
{
//    生成一个全透明的导航栏
//    self.navigationController.navigationBar.translucent = YES;
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
//    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    
//    返回按钮
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setBackgroundImage:[UIImage imageNamed:@"back-button"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(didTapBackBtn:) forControlEvents:UIControlEventTouchUpInside];
    [backBtn sizeToFit];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    
//    手电筒
    UIButton *flashBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [flashBtn setBackgroundImage:[UIImage imageNamed:@"light-off"] forState:UIControlStateNormal];
    [flashBtn setBackgroundImage:[UIImage imageNamed:@"light-on"] forState:UIControlStateSelected];
    [flashBtn sizeToFit];
    [flashBtn addTarget:self action:@selector(didTapFlashBtn:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:flashBtn];
}

- (void)didTapBackBtn:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)didTapFlashBtn:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    btn.selected = !btn.selected;
#warning 手电筒实现
    //TODO
}

#pragma mark - navigation bar config
- (BOOL)shouldShowShadowImage
{
    return NO;
}
- (UIImage *)navigationBarBackgroundImage
{
    return [UIImage new];
}

#pragma mark - subviews
- (void)initSubviews
{
    [self initCamera];
    [self initScannerView];
    [self initTip];
}
- (void)initCamera
{
    self.captureSession = [[AVCaptureSession alloc] init];
    
    [self.captureSession beginConfiguration];
    AVCaptureDevice *captureDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];

//    输入
    NSError *error = nil;
    AVCaptureInput *captureInput = [AVCaptureDeviceInput deviceInputWithDevice:captureDevice error:&error];
    if (error == nil)
    {
        if ([self.captureSession canAddInput:captureInput])
        {
            [self.captureSession addInput:captureInput];
        }
    }else
    {
        NSLog(@"input error:%@",error);
    }
//    输出
    AVCaptureMetadataOutput *captureOutput = [[AVCaptureMetadataOutput alloc] init];
    [captureOutput setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    if ([self.captureSession canAddOutput:captureOutput])
    {
        [self.captureSession addOutput:captureOutput];
//        NSArray *typeList = captureOutput.availableMetadataObjectTypes;
//        NSLog(@"availableMetadataObjectTypes:%@",typeList);
        captureOutput.metadataObjectTypes = @[AVMetadataObjectTypeEAN13Code];
    }
//    取出预览层 添加预览画面
    CALayer *layer = [AVCaptureVideoPreviewLayer layerWithSession:self.captureSession];
    layer.frame = self.view.layer.bounds;
    [self.view.layer addSublayer:layer];
    [self.captureSession commitConfiguration];
    
    [self.captureSession startRunning];
}
- (void)initScannerView
{
    self.scanView = [[BookScanView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds)) rectSize:CGSizeMake(230.0f, 230.0f) offsetY:-43.0f];
    self.scanView.backgroundColor = [UIColor clearColor];
    self.scanView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:self.scanView];
    
    [self.scanView startAnimation];

}
- (void)initTip
{
    NSString *tipStr = @"将条形码放入输入框内，即可自动扫描";
    UILabel *tipLabel = [[UILabel alloc] init];
    tipLabel.textColor = [UIColor whiteColor];
    tipLabel.font = [UIFont systemFontOfSize:12];
    tipLabel.text = tipStr;
    tipLabel.frame = CGRectMake(100, 500, 230, 60);
    [self.view addSubview:tipLabel];
}

#pragma mark - ISBN 识别
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    NSString *ISBN = nil;
    for (AVMetadataObject *metadata in metadataObjects)
    {
        ISBN = [(AVMetadataMachineReadableCodeObject *)metadata stringValue];
        break;
    }
    if (ISBN)
    {
        [self.captureSession stopRunning];
        [self.scanView stopAnimation];
        [self fetchBookWithISBN:ISBN];
    }
}

/**
 向数据库批量添加图书数据，在app处理大数据性能
 */
- (void)AddDatabaseWithTestBigData:(NSString *)searchKey withStart:(int)i
{
//    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc]
                                    initWithSessionConfiguration:configuration];
    NSCharacterSet *characterSet = [NSCharacterSet URLFragmentAllowedCharacterSet];
   
    NSString *str = [[NSString stringWithFormat:@"https://api.douban.com/v2/book/search?q=%@&count=100&start=%i",searchKey,i] stringByAddingPercentEncodingWithAllowedCharacters:characterSet];
    NSURL *searchURL = [NSURL URLWithString:str];
        NSURLRequest *request = [NSURLRequest requestWithURL:searchURL];
        
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
            if (error != nil)
            {
                NSLog(@"request error:%@",error);
            }else
            {
                NSArray *books = [responseObject objectForKey:@"books"];
                for (NSDictionary *dict in books)
                {
                    BookEntity *bookEntity = [[BookEntity alloc] initWithDictionary:dict];
                    BookEntity *entity = [BookDetailService searchFaveBookWithDoubanId:bookEntity.doubanId];
                    if (!entity)
                    {
                        [BookDetailService favBook:bookEntity];
                    }
                }
//                dispatch_semaphore_signal(semaphore);
            }
        }];
    [dataTask resume];
//        dispatch_semaphore_wait(semaphore,DISPATCH_TIME_FOREVER);
        
   
}

- (void)fetchBookWithISBN:(NSString *)isbn
{
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://api.douban.com/v2/book/isbn/%@",isbn]];
    
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        if (error != nil)
        {
            NSLog(@"request error:%@",error);
        }else
        {
            NSString *title = [responseObject objectForKey:@"title"];
            NSArray *authorList = [responseObject objectForKey:@"author"];
            NSString *author = nil;
            if (authorList.count > 0)
            {
                author = [authorList firstObject];
            }
            
            UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:[NSString stringWithFormat:@"ISBN:%@\n title:%@\n author:%@",isbn,title,author] preferredStyle:UIAlertControllerStyleAlert];
            
            BookEntity *bookEntity = [[BookEntity alloc] initWithDictionary:responseObject];
            
            UIAlertAction *detailAction = [UIAlertAction actionWithTitle:@"查看详情" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
                BookDetailViewController *controller = [[BookDetailViewController alloc] init];
                controller.bookEntity = bookEntity;
                [self.navigationController pushViewController:controller animated:YES];
            }];
            [alertVC addAction:detailAction];
            
            BookEntity *entity = [BookDetailService searchFaveBookWithDoubanId:bookEntity.doubanId];
            if (!entity)
            {
                UIAlertAction *nextAction = [UIAlertAction actionWithTitle:@"收藏并继续扫描" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    [self.captureSession startRunning];
                    [self.scanView startAnimation];
                    [BookDetailService favBook:bookEntity];
                }];
                [alertVC addAction:nextAction];
            }
            
            [self presentViewController:alertVC animated:YES completion:nil];
        }
    }];
    [dataTask resume];
}
@end
