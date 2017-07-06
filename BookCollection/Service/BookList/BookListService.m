//
//  BookListService.m
//  BookCollection
//
//  Created by Kwok_Rui on 2017/6/20.
//  Copyright © 2017年 Netease. All rights reserved.
//

#import "BookListService.h"
#import "BookEntityDAO.h"
#import "BookAuthorDAO.h"
#import "BookTagDAO.h"
#import "BookTranslatorDAO.h"

#import "BookDBHelper.h"

@implementation BookListService

//虽然这个方法返回数组 定义数据层接口  尽量将返回值定义的更精确一点
+ (NSArray<BookEntity *> *)getAllBookEntites
{
    FMDatabase *db = [FMDatabase databaseWithPath:[BookDBHelper dbPath]];
    if (![db open])
    {
        return 0;
    }
    
    NSArray *bookEntities = [BookEntityDAO quertAllModelsWithDatabase:db];
    
    for (BookEntity *entity in bookEntities)
    {
        entity.authors = [BookAuthorDAO queryModelWithBookId:entity.id withDatabase:db];
        entity.translators = [BookTranslatorDAO queryModelWithBookId:entity.id withDatabase:db];
        entity.tags = [BookTagDAO queryModelWithBookId:entity.id withDatabase:db];
    }
    return bookEntities;
}

@end
