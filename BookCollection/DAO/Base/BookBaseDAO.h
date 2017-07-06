//
//  BookBaseDAO.h
//  BookCollection
//
//  Created by Kwok_Rui on 2017/6/18.
//  Copyright © 2017年 Netease. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BookBaseModel.h"
#import <FMDB/FMDB.h>

@interface BookBaseDAO : NSObject

+ (long long)insertModel:(BookBaseModel *)model withDataBase:(FMDatabase *)db;

+ (BOOL)deleteModelWithId:(long long)id withDatabase:(FMDatabase *)db;

@end
