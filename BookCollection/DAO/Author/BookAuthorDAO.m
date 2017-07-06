//
//  BookAuthorDAO.m
//  BookCollection
//
//  Created by Kwok_Rui on 2017/6/18.
//  Copyright © 2017年 Netease. All rights reserved.
//

#import "BookAuthorDAO.h"

@implementation BookAuthorDAO

+ (long long)insertModel:(BookAuthor *)model withDataBase:(FMDatabase *)db
{
    BOOL succ = [db executeUpdate:@"INSERT INTO TB_BOOK_AUTHOR (bookId,name) VALUES (?,?)",@(model.bookId),model.name];
    if (succ)
    {
        return [db lastInsertRowId];
    }else
    {
        return 0;
    }
}

+ (BOOL)deleteModelWithId:(long long)id withDatabase:(FMDatabase *)db
{
    BOOL succ = [db executeUpdate:@"DELETE FROM TB_BOOK_AUTHOR WHERE id = ?",@(id)];
    
    if(succ)
    {
        return YES;
    }else
    {
        return NO;
    }
}

+ (NSArray<BookAuthor *> *)queryModelWithBookId:(long long)bookId withDatabase:(FMDatabase *)db
{
    NSMutableArray *array = [@[] mutableCopy];
    FMResultSet *s = [db executeQuery:@"SELECT * FROM TB_BOOK_AUTHOR WHERE bookId = ?",@(bookId)];
    while ([s next])
    {
        BookAuthor *author = [[BookAuthor alloc] initWithFMResultSet:s];
        [array addObject:author];
    }
    [s close];
    return array;
}
@end
