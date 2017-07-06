//
//  BookEntity.h
//  BookCollection
//
//  Created by Kwok_Rui on 2017/6/14.
//  Copyright © 2017年 Netease. All rights reserved.
//

#import "BookBaseModel.h"
#import "BookTag.h"

@interface BookEntity : BookBaseModel

/**
 图书本地id
 */
@property (nonatomic,assign) long long id;

/**
 豆瓣ID
 */
@property (nonatomic,assign) long long doubanId;

/**
 ISBN10
 */
@property (nonatomic,copy) NSString *isbn10;

/**
 ISBN13
 */
@property (nonatomic,copy) NSString *isbn13;
/**
 图书名称
 */
@property (nonatomic,copy) NSString *title;

/**
 豆瓣URL
 */
@property (nonatomic,copy) NSString *doubanURL;

/**
 图书封面URL
 */
@property (nonatomic,copy) NSString *image;

/**
 出版社
 */
@property (nonatomic,copy) NSString *publisher;

/**
 发行时间
 */
@property (nonatomic,copy) NSString *pubdate;

/**
 价格
 */
@property (nonatomic,copy) NSString *price;

/**
 书籍简介
 */
@property (nonatomic,copy) NSString *summary;

/**
 作者介绍
 */
@property (nonatomic,copy) NSString *author_intro;

/**
 作者
 */
@property (nonatomic,copy) NSArray *authors;

/**
 译者
 */
@property (nonatomic,copy) NSArray *translators;

/**
 标签
 */
@property (nonatomic,copy) NSArray<BookTag *> *tags;

@end
