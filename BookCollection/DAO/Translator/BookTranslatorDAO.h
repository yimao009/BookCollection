//
//  BookTranslatorDAO.h
//  BookCollection
//
//  Created by Kwok_Rui on 2017/6/18.
//  Copyright © 2017年 Netease. All rights reserved.
//

#import "BookBaseDAO.h"
#import "BookTranslator.h"

@interface BookTranslatorDAO : BookBaseDAO

+ (long long)insertModel:(BookTranslator *)model withDataBase:(FMDatabase *)db;

+ (BOOL)deleteModelWithId:(long long)id withDatabase:(FMDatabase *)db;

+ (NSArray <BookTranslator *> *)queryModelWithBookId:(long long)bookId withDatabase:(FMDatabase *)db;
@end
