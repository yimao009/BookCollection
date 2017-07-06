//
//  BookDetailViewController.h
//  BookCollection
//
//  Created by Kwok_Rui on 2017/6/14.
//  Copyright © 2017年 Netease. All rights reserved.
//

#import "BookBaseViewController.h"
#import "BookEntity.h"

@interface BookDetailViewController : BookBaseViewController
@property (nonatomic,copy) BookEntity *bookEntity;
@end
