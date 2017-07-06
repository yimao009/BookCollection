//
//  BookTag.h
//  BookCollection
//
//  Created by Kwok_Rui on 2017/6/14.
//  Copyright © 2017年 Netease. All rights reserved.
//

#import "BookBaseModel.h"

@interface BookTag : BookBaseModel
/**
 图书本地id
 */
@property (nonatomic,assign) long long bookId;

/**
 标签名称
 */
@property (nonatomic,copy) NSString *name;

/**
 标签次数
 */
@property (nonatomic,assign) long count;

@end
