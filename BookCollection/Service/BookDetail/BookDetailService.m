//
//  BookDetailService.m
//  BookCollection
//
//  Created by Kwok_Rui on 2017/6/18.
//  Copyright © 2017年 Netease. All rights reserved.
//

#import "BookDetailService.h"
#import "BookDBHelper.h"

#import "BookEntityDAO.h"
#import "BookAuthorDAO.h"
#import "BookTranslatorDAO.h"
#import "BookTagDAO.h"

@implementation BookDetailService

+ (long long)favBook:(BookEntity *)bookEntity
{
    FMDatabase *db = [FMDatabase databaseWithPath:[BookDBHelper dbPath]];
    if (![db open])
    {
        return 0;
    }
    //保存图书
    long long bookId = [BookEntityDAO insertModel:bookEntity withDataBase:db];
    if (!bookId)
    {
        return bookId;
    }
    //保存作者
    [bookEntity.authors enumerateObjectsUsingBlock:^(BookAuthor *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.bookId = bookId;
        [BookAuthorDAO insertModel:obj withDataBase:db];
    }];
    //保存译者
    [bookEntity.translators enumerateObjectsUsingBlock:^(BookTranslator *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.bookId = bookId;
        [BookTranslatorDAO insertModel:obj withDataBase:db];
    }];
    //保存标签
    [bookEntity.tags enumerateObjectsUsingBlock:^(BookTag * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.bookId = bookId;
        [BookTagDAO insertModel:obj withDatabase:db];
    }];
    
    [db close];
    return bookId;
}

+ (BookEntity *)searchFaveBookWithDoubanId:(long long)doubanId
{
    FMDatabase *db = [FMDatabase databaseWithPath:[BookDBHelper dbPath]];
    if (![db open])
    {
        return 0;
    }
    
    BookEntity *book = [BookEntityDAO queryModelByDoubanId:doubanId withDatabase:db];
    [db close];
    return book;
}

+ (BOOL)unFavBookWithId:(long long)id;
{
    FMDatabase *db = [FMDatabase databaseWithPath:[BookDBHelper dbPath]];
    
    if (![db open])
    {
        return NO;
    }
    
    [BookEntityDAO deleteModelWithId:id withDatabase:db];
    [BookAuthorDAO deleteModelWithId:id withDatabase:db];
    [BookTranslatorDAO deleteModelWithId:id withDatabase:db];
    [BookTagDAO deleteModelWithId:id withDatabase:db];
//    BOOL succ = [BookEntityDAO deleteModelWithId:id withDatabase:db];
    [db close];
    return YES;
}

@end
