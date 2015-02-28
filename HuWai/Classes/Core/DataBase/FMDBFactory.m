//
//  FMDBFactory.m
//  Sanbao
//
//  Created by WmVenusMac on 14-6-28.
//  Copyright (c) 2014年 venus. All rights reserved.
//

#import "FMDBFactory.h"
static FMDatabase *dbOjb = nil;

@implementation FMDBFactory

+(FMDatabase *)getDatabaseWithPath:(NSString *)filePath
{
    if (!dbOjb) {
        dbOjb = [FMDatabase databaseWithPath:filePath];
    }
    return dbOjb;
}
+ (id)execSqlInFmdb:(id (^)(FMDatabase *db))block {
    //使用之前保证数据库是打开的
    if ([dbOjb open]) {
        @try {
            return  block(dbOjb); //调用block来回调实现具体的逻辑
        }
        @catch (NSException *exception) {
            //处理异常，也可以直接抛出，这样调用者就能捕获到异常信息
            NSLog(@"FmdbUtil exec sql exception: %@", exception);
        }
        @finally {
            [dbOjb close]; //如果[db open]就要保证能关闭
        }
    } else {
        //如果打开失败，则打印出错误信息
        NSLog(@"db open failed, errorMsg:%@", [dbOjb lastError]);
        return [NSNumber numberWithBool:NO];
    }
}

@end
