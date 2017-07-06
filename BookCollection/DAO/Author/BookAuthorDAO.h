//
//  BookAuthorDAO.h
//  BookCollection
//
//  Created by Kwok_Rui on 2017/6/18.
//  Copyright © 2017年 Netease. All rights reserved.
//

#import "BookBaseDAO.h"
#import "BookAuthor.h"

@interface BookAuthorDAO : BookBaseDAO

+ (long long)insertModel:(BookAuthor *)model withDataBase:(FMDatabase *)db;

+ (BOOL)deleteModelWithId:(long long)id withDatabase:(FMDatabase *)db;

+ (NSArray <BookAuthor *>*)queryModelWithBookId:(long long)bookId withDatabase:(FMDatabase *)db;
@end
