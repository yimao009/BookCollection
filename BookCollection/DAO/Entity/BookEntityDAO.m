//
//  BookEntityDAO.m
//  BookCollection
//
//  Created by Kwok_Rui on 2017/6/18.
//  Copyright © 2017年 Netease. All rights reserved.
//

#import "BookEntityDAO.h"

@implementation BookEntityDAO

+ (long long)insertModel:(BookEntity *)model withDataBase:(FMDatabase *)db
{
    BOOL succ = [db executeUpdate:@"INSERT INTO TB_BOOK_ENTITY (doubanId,isbn10,isbn13,title,doubanUrl,image,publisher,pubdate,price,summary,author_intro) VALUES (?,?,?,?,?,?,?,?,?,?,?)",@(model.doubanId),model.isbn10,model.isbn13,model.title,model.doubanURL,model.image,model.publisher,model.pubdate,model.price,model.summary,model.author_intro];
    if (succ)
    {
        return [db lastInsertRowId];
    }else
    {
        return 0;
    }
}

+ (BookEntity *)queryModelByDoubanId:(long long)doubanId withDatabase:(FMDatabase *)db
{
    FMResultSet *result = [db executeQuery:@"SELECT * FROM TB_BOOK_ENTITY WHERE doubanId = ?",@(doubanId)];
    if ([result next])
    {
        BookEntity *entity = [[BookEntity alloc] initWithFMResultSet:result];
        return entity;
    }
    return nil;
}

+ (BOOL)deleteModelWithId:(long long)id withDatabase:(FMDatabase *)db
{
    BOOL succ = [db executeUpdate:@"DELETE FROM TB_BOOK_ENTITY WHERE id = ?",@(id)];
    
    if(succ)
    {
        return YES;
    }else
    {
        return NO;
    }
}

+ (NSArray<BookEntity *> *)quertAllModelsWithDatabase:(FMDatabase *)db
{
    NSMutableArray *results = [@[] mutableCopy];
//    ORDER BY id desc
    FMResultSet *s = [db executeQuery:@"SELECT * FROM TB_BOOK_ENTITY"];
    while ([s next])
    {
        BookEntity *entity = [[BookEntity alloc] initWithFMResultSet:s];
        [results addObject:entity];
    }
    [s close];
    return results;
}
@end
