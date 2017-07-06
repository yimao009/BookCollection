//
//  BookTag.m
//  BookCollection
//
//  Created by Kwok_Rui on 2017/6/14.
//  Copyright © 2017年 Netease. All rights reserved.
//

#import "BookTag.h"

@implementation BookTag

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    BookTag *bookTag = [[[self class] alloc] init];
    bookTag.bookId = [[dict objectForKey:@"bookId"] longLongValue];
    bookTag.name = [dict objectForKey:@"name"];
    bookTag.count = [[dict objectForKey:@"count"] longValue];
    return bookTag;
}

- (instancetype)initWithFMResultSet:(FMResultSet *)result
{
    BookTag *tag = [[BookTag alloc] init];
    tag.bookId = [result longLongIntForColumn:@"bookId"];
    tag.name = [result stringForColumn:@"name"];
    tag.count = [result longForColumn:@"count"];
    return tag;
}

- (id)copyWithZone:(NSZone *)zone
{
    BookTag *bookTag = [[[self class] allocWithZone:zone]init];
    bookTag.bookId = self.bookId;
    bookTag.name = [self.name copy];
    bookTag.count = self.count;
    return bookTag;
}
@end
