//
//  BookTagDAO.h
//  BookCollection
//
//  Created by Kwok_Rui on 2017/6/18.
//  Copyright © 2017年 Netease. All rights reserved.
//

#import "BookBaseDAO.h"
#import "BookTag.h"

@interface BookTagDAO : BookBaseDAO

+ (long long)insertModel:(BookTag *)model withDatabase:(FMDatabase *)db;

+ (BOOL)deleteModelWithId:(long long)id withDatabase:(FMDatabase *)db;

+ (NSArray <BookTag *> *)queryModelWithBookId:(long long)bookId withDatabase:(FMDatabase *)db;
@end
