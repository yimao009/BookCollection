//
//  BookListTableViewCell+BookEntity.h
//  BookCollection
//
//  Created by Kwok_Rui on 2017/6/23.
//  Copyright © 2017年 Netease. All rights reserved.
//

#import "BookListTableViewCell.h"
@class BookEntity;
@interface BookListTableViewCell (BookEntity)

- (void)configureWithBookEntity:(BookEntity *)bookEntity;

@end
