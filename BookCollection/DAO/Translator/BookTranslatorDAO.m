//
//  BookTranslatorDAO.m
//  BookCollection
//
//  Created by Kwok_Rui on 2017/6/18.
//  Copyright © 2017年 Netease. All rights reserved.
//

#import "BookTranslatorDAO.h"

@implementation BookTranslatorDAO

+ (long long)insertModel:(BookTranslator *)model withDataBase:(FMDatabase *)db
{
    BOOL succ = [db executeUpdate:@"INSERT INTO TB_BOOK_TRANSLATOR (bookId,name) VALUES (?,?)",@(model.bookId),model.name];
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
    BOOL succ = [db executeUpdate:@"DELETE FROM TB_BOOK_TRANSLATOR WHERE id = ?",@(id)];
    
    if(succ)
    {
        return YES;
    }else
    {
        return NO;
    }
}

+ (NSArray<BookTranslator *> *)queryModelWithBookId:(long long)bookId withDatabase:(FMDatabase *)db
{
    FMResultSet *s = [db executeQuery:@"SELECT * FROM TB_BOOK_TRANSLATOR WHERE bookId = ?",@(bookId)];
    NSMutableArray *array = [@[] mutableCopy];
    while (s.next)
    {
        BookAuthor *author = [[BookAuthor alloc] initWithFMResultSet:s];
        [array addObject:author];
    }
    [s close];
    return array;
}
@end
