//
//  BookTagDAO.m
//  BookCollection
//
//  Created by Kwok_Rui on 2017/6/18.
//  Copyright © 2017年 Netease. All rights reserved.
//

#import "BookTagDAO.h"

@implementation BookTagDAO

+ (long long)insertModel:(BookTag *)model withDatabase:(FMDatabase *)db
{
    BOOL succ = [db executeUpdate:@"INSERT INTO TB_BOOK_TAG (bookId,count,name) VALUES (?,?,?)",@(model.bookId),@(model.count),model.name];
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
    BOOL succ = [db executeUpdate:@"DELETE FROM TB_BOOK_TAG WHERE id = ?",@(id)];
    
    if(succ)
    {
        return YES;
    }else
    {
        return NO;
    }
}
+ (NSArray<BookTag *> *)queryModelWithBookId:(long long)bookId withDatabase:(FMDatabase *)db
{
    FMResultSet *s = [db executeQuery:@"SELECT * FROM TB_BOOK_TAG WHERE bookId = ?",@(bookId)];
    NSMutableArray *array = [@[] mutableCopy];
    while (s.next)
    {
        BookTag *tag = [[BookTag alloc] initWithFMResultSet:s];
        [array addObject:tag];
    }
    [s close];
    return array;
}
@end
