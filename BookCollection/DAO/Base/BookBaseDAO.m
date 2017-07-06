//
//  BookBaseDAO.m
//  BookCollection
//
//  Created by Kwok_Rui on 2017/6/18.
//  Copyright © 2017年 Netease. All rights reserved.
//

#import "BookBaseDAO.h"

@implementation BookBaseDAO

+ (long long)insertModel:(BookBaseModel *)model withDataBase:(FMDatabase *)db
{
    NSString *msg = [NSString stringWithFormat:@"%s is not implemented" " for the class %@",sel_getName(_cmd),self];
    @throw [NSException exceptionWithName:@"BookDAOMethodException" reason:msg userInfo:nil];
}

+ (BOOL)deleteModelWithId:(long long)id withDatabase:(FMDatabase *)db
{
    NSString *msg = [NSString stringWithFormat:@"%s is not implemented " "for the class %@",sel_getName(_cmd),self];
    @throw [NSException exceptionWithName:@"BookDAOMethodException" reason:msg userInfo:nil];
}
@end
