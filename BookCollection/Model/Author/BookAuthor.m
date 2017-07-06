//
//  BookAuthor.m
//  BookCollection
//
//  Created by Kwok_Rui on 2017/6/14.
//  Copyright © 2017年 Netease. All rights reserved.
//

#import "BookAuthor.h"

@implementation BookAuthor

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    BookAuthor *author = [[[self class] alloc]init];
    author.bookId = [[dict objectForKey:@"bookId"] longLongValue];
    author.name = [dict objectForKey:@"name"];
    return author;
}

- (instancetype)initWithFMResultSet:(FMResultSet *)result
{
    BookAuthor *author = [[BookAuthor alloc] init];
    author.bookId = [result longLongIntForColumn:@"bookId"];
    author.name = [result stringForColumn:@"name"];
    return author;
}

-  (id)copyWithZone:(NSZone *)zone
{
    BookAuthor *author = [[[self class] allocWithZone:zone] init];
    author.bookId = self.bookId;
    author.name = [self.name copy];
    return author;
}
@end
