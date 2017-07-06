//
//  BookDetailService.h
//  BookCollection
//
//  Created by Kwok_Rui on 2017/6/18.
//  Copyright © 2017年 Netease. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BookEntity.h"

// 和业务场景交互
@interface BookDetailService : NSObject

/**
 收藏图书

 @param entity 图书实体
 @return 图书本地Id
 */
+ (long long)favBook:(BookEntity *)entity;

/**
 使用豆瓣Id搜索数据库中是否有已经收藏的书籍

 @param doubanId 豆瓣Id
 @return 书籍实体
 */
+ (BookEntity *)searchFaveBookWithDoubanId:(long long)doubanId;


/**
 使用豆瓣Id移除数据库中已经有的书籍

 @param id 豆瓣id
 @return 返回是否删除成功
 */
+ (BOOL)unFavBookWithId:(long long)id;

@end
