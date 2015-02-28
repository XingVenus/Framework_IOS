//
//  FMDBFactory.h
//  Sanbao
//
//  Created by WmVenusMac on 14-6-28.
//  Copyright (c) 2014年 venus. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FMDB/FMDB.h>
@interface FMDBFactory : NSObject
+ (FMDatabase *)getDatabaseWithPath:(NSString *)filePath;
+ (id)execSqlInFmdb:(id (^)(FMDatabase *db))block;
@end
