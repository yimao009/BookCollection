//
//  BookDBHelper.m
//  BookCollection
//
//  Created by Kwok_Rui on 2017/6/16.
//  Copyright © 2017年 Netease. All rights reserved.
//

#import "BookDBHelper.h"

@implementation BookDBHelper

+ (NSString *)dbFolder
{
    NSString *docdir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    
    NSString *path = [docdir stringByAppendingPathComponent:@"db"];
    
    return path;
}

+ (NSString *)dbPath
{
    NSString *path = [[[self class] dbFolder] stringByAppendingPathComponent:@"book.sqlite"];
    
    return path;
}

+ (void)buildDataBase
{
    if(![[NSFileManager defaultManager] fileExistsAtPath:[[self class] dbFolder]])
    {
        [[NSFileManager defaultManager] createDirectoryAtPath:[[self class] dbFolder
                                                               ]withIntermediateDirectories:YES attributes:nil error:nil];
    }
    FMDatabase *db = [[FMDatabase alloc] initWithPath:[[self class] dbPath]];
    if (!db.open)
    {
        return;
    }
    BOOL success = [[self class] createTableWithDB:db];
    if (success)
    {
        NSLog(@"init sqlite done");
    }else
    {
        NSLog(@"init sqlite fail");
    }
}

+ (BOOL)createTableWithDB:(FMDatabase *)db
{
    BOOL succ = YES;
    NSArray *sqliteArray = [[self class] createTableSqls];
    for (NSString *sql in sqliteArray) {
        if (![db executeUpdate:sql])
        {
            succ = NO;
            break;
        }
    }
    return succ;
}

+ (NSArray *)createTableSqls
{
    return @[
             @"CREATE TABLE 'TB_BOOK_ENTITY'(\
             'id' INTEGER PRIMARY KEY AUTOINCREMENT,\
             'doubanId' INTEGER UNIQUE,\
             'isbn10' TEXT,\
             'isbn13' TEXT,\
             'title' TEXT,\
             'doubanUrl' TEXT,\
             'image' TEXT,\
             'publisher' TEXT,\
             'pubdate' TEXT,\
             'price' TEXT,\
             'summary' TEXT,\
             'author_intro' TEXT\
             )",
             @"CREATE TABLE 'TB_BOOK_TRANSLATOR'(\
             'bookId' INTEGER,\
             'name' TEXT\
             )",
             @"CREATE TABLE 'TB_BOOK_TAG' (\
             'bookId' INTEGER,\
             'count' INTEGER,\
             'name' TEXT\
             )",
             @"CREATE TABLE 'TB_BOOK_AUTHOR' (\
             'bookId' INTEGER,\
             'name' TEXT\
             )"
             ];
}


@end
