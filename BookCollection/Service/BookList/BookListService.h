//
//  BookListService.h
//  BookCollection
//
//  Created by Kwok_Rui on 2017/6/20.
//  Copyright © 2017年 Netease. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BookEntity.h"

@interface BookListService : NSObject

+ (NSArray<BookEntity *> *)getAllBookEntites;

@end
