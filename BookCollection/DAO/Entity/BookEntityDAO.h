//
//  BookEntityDAO.h
//  BookCollection
//
//  Created by Kwok_Rui on 2017/6/18.
//  Copyright © 2017年 Netease. All rights reserved.
//

#import "BookBaseDAO.h"
#import "BookEntity.h"

@interface BookEntityDAO : BookBaseDAO

+ (long long)insertModel:(BookEntity *)model withDataBase:(FMDatabase *)db;

+ (BookEntity *)queryModelByDoubanId:(long long)doubanId withDatabase:(FMDatabase *)db;

+ (BOOL)deleteModelWithId:(long long)id withDatabase:(FMDatabase *)db;

+ (NSArray <BookEntity *> *)quertAllModelsWithDatabase:(FMDatabase *)db;
@end
