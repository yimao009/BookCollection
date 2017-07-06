//
//  BookBaseModel.m
//  BookCollection
//
//  Created by Kwok_Rui on 2017/6/14.
//  Copyright © 2017年 Netease. All rights reserved.
//

#import "BookBaseModel.h"
#import "BookTag.h"

@implementation BookBaseModel

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    NSString *msg = [NSString stringWithFormat:@"%s is not implemented""for the class %@",sel_getName(_cmd),self];
    @throw [NSException exceptionWithName:@"BookModelInitializerException" reason:msg userInfo:nil];
}

- (id)copyWithZone:(nullable NSZone *)zone
{
    NSString *msg = [NSString stringWithFormat:@"%s is not implemented""for the class %@",sel_getName(_cmd),self];
    @throw [NSException exceptionWithName:@"BookModelInitializerException" reason:msg userInfo:nil];
}

- (instancetype)initWithFMResultSet:(FMResultSet *)result
{
    NSString *msg = [NSString stringWithFormat:@"%s is not implemented"" for the class %@",sel_getName(_cmd),self];
    @throw [NSException exceptionWithName:@"BookModelInitializerException" reason:msg userInfo:nil];
}

#pragma mark - convert
- (NSArray <BookTag *>*)modleArrayFromDictArray:(NSArray *)array withModelClass:(Class)modelClass
{
    //断言
    NSParameterAssert(modelClass!=nil);
    NSParameterAssert([modelClass isSubclassOfClass:BookBaseModel.class]);
    
    NSMutableArray *models = [@[] mutableCopy];
    [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        BookBaseModel *model = [[modelClass alloc] initWithDictionary:obj];
        [models addObject:model];
    }];
    return models;
}
@end
