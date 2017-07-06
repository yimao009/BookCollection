//
//  BookEntity.m
//  BookCollection
//
//  Created by Kwok_Rui on 2017/6/14.
//  Copyright © 2017年 Netease. All rights reserved.
//

#import "BookEntity.h"
#import "BookAuthor.h"
#import "BookTranslator.h"
#import "BookTag.h"

@implementation BookEntity

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    BookEntity *bookEntity = [[[self class] alloc] init];
    
    bookEntity.doubanId = [[dict objectForKey:@"id"] longLongValue];
    bookEntity.isbn10 = [dict objectForKey:@"isbn10"];
    bookEntity.isbn13 = [dict objectForKey:@"isbn13"];
    bookEntity.title = [dict objectForKey:@"title"];
    bookEntity.doubanURL = [dict objectForKey:@"alt"];
    bookEntity.image = [[dict objectForKey:@"images"] objectForKey:@"large"];
    bookEntity.publisher = [dict objectForKey:@"publisher"];
    bookEntity.pubdate = [dict objectForKey:@"pubdate"];
    bookEntity.price = [dict objectForKey:@"price"];
    bookEntity.summary = [dict objectForKey:@"summary"];
    bookEntity.author_intro = [dict objectForKey:@"author_intro"];
    
    NSMutableArray *authors = [@[] mutableCopy];
    [[dict objectForKey:@"author"] enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        BookAuthor *model = [[BookAuthor alloc] init];
        [model setName:obj];
        [authors addObject:model];
    }];
    bookEntity.authors = authors;
    
    NSMutableArray *translators = [@[] mutableCopy];
    [[dict objectForKey:@"translator"] enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        BookTranslator *model = [[BookTranslator alloc] init];
        [model setName:obj];
        [translators addObject:model];
    }];
    
    bookEntity.translators = translators;
    
    bookEntity.tags = [self modleArrayFromDictArray:[dict objectForKey:@"tags"] withModelClass:[BookTag class]];
    
    return bookEntity;
}

- (instancetype)initWithFMResultSet:(FMResultSet *)result
{
    BookEntity *entity = [[[self class] alloc] init];
    
    entity.id = [result longLongIntForColumn:@"id"];
    entity.doubanId = [result longLongIntForColumn:@"doubanId"];
    entity.isbn10 = [result stringForColumn:@"isbn10"];
    entity.isbn13 = [result stringForColumn:@"isbn13"];
    entity.title = [result stringForColumn:@"title"] ;
    entity.doubanURL = [result stringForColumn:@"doubanURL"];
    entity.image = [result stringForColumn:@"image"];
    entity.publisher = [result stringForColumn:@"publisher"];
    entity.pubdate = [result stringForColumn:@"pubdate"];
    entity.price = [result stringForColumn:@"price"];
    entity.summary = [result stringForColumn:@"summary"];
    entity.author_intro = [result stringForColumn:@"author_intro"];
    
    return entity;
}

- (id)copyWithZone:(NSZone *)zone
{
    BookEntity *bookEntity = [[[self class] allocWithZone:zone] init] ;
    
    bookEntity.id = self.id;
    bookEntity.doubanId = self.doubanId;
    bookEntity.isbn10 = [self.isbn10 copy];
    bookEntity.isbn13 = [self.isbn13 copy];
    bookEntity.title = [self.title copy];
    bookEntity.doubanURL = [self.doubanURL copy];
    bookEntity.image = [self.image copy];
    bookEntity.publisher = [self.publisher copy];
    bookEntity.pubdate = [self.pubdate copy];
    bookEntity.price = [self.price copy];
    bookEntity.author_intro = [self.author_intro copy];
    bookEntity.authors = [self.authors copy];
    bookEntity.translators = [self.translators copy];
    bookEntity.tags = [self.tags copy];
    bookEntity.summary = [self.summary copy];
    
    return bookEntity;
}

@end
