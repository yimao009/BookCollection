//
//  BookDBHelper.h
//  BookCollection
//
//  Created by Kwok_Rui on 2017/6/16.
//  Copyright © 2017年 Netease. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FMDB/FMDB.h>

@interface BookDBHelper : NSObject

+ (NSString *)dbFolder;

+ (NSString *)dbPath;

+ (void)buildDataBase;

@end
