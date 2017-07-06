//
//  BookBaseModel.h
//  BookCollection
//
//  Created by Kwok_Rui on 2017/6/14.
//  Copyright © 2017年 Netease. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FMDB/FMDB.h>
@interface BookBaseModel : NSObject<NSCopying>

- (instancetype)initWithDictionary:(NSDictionary *)dict;

- (instancetype)initWithFMResultSet:(FMResultSet *)result;

#pragma mark - convert
- (NSArray *)modleArrayFromDictArray:(NSArray *)array withModelClass:(Class)modelClass;



@end
