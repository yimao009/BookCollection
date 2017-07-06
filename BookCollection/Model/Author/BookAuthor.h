//
//  BookAuthor.h
//  BookCollection
//
//  Created by Kwok_Rui on 2017/6/14.
//  Copyright © 2017年 Netease. All rights reserved.
//

#import "BookBaseModel.h"

@interface BookAuthor : BookBaseModel

/**
 图书本地id
 */
@property (nonatomic,assign) long long bookId;

/**
 作者名称
 */
@property (nonatomic,copy) NSString *name;
@end
