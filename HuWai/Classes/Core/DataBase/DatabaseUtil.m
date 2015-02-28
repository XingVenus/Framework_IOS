//
//  DatabaseUtil.m
//  Sanbao
//
//  Created by WmVenusMac on 14-6-28.
//  Copyright (c) 2014年 venus. All rights reserved.
//
/*
 *
 *CREATE TABLE "message" ("id" INTEGER PRIMARY KEY  AUTOINCREMENT  NOT NULL  UNIQUE ,"username" VARCHAR, "send" VARCHAR, "receive" VARCHAR, "content" TEXT, "timestamp" VARCHAR DEFAULT CURRENT_TIMESTAMP)
 *
 *
 */

//[TWFmdbUtil execSqlInFmdb:^(FMDatabase *db) {
//	//处理业务逻辑
//	FMResultSet *s = [db executeQuery:@"SELECT * FROM myTable"];
//	while ([s next]) {
//        //retrieve values for each record
//	}
//}];

#import "DatabaseUtil.h"

@implementation DatabaseUtil

+(instancetype)shareDatabase
{
    static DatabaseUtil *databaseManager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        databaseManager = [[self alloc] init];
    });
    return databaseManager;
}

-(id)init
{
    self = [super init];
    if (self) {
        //初始化
        //1、获得数据库文件在工程中的数据库路径——源路径。
        NSString *sourcesDBPath = [[NSBundle mainBundle] pathForResource:DATABASE_NAME ofType:nil];
        //2、目标文件路径
        NSString *destDBPath = [APP_DOC_DIR stringByAppendingPathComponent:DATABASE_NAME];
        if ([self initDatabaseFromPath:sourcesDBPath toPath:destDBPath]) {
            //数据库连接
            _dbConnect = [FMDBFactory getDatabaseWithPath:destDBPath];
        }
    }
    return self;
}

#pragma mark 初始化转移数据库文件
-(BOOL)initDatabaseFromPath:(NSString *)fromPath toPath:(NSString *)toPath
{
    //通过NSFileManager类，将工程中的数据库文件复制到沙盒中。
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:toPath]) {
        NSError *error;
        if ([fileManager copyItemAtPath:fromPath toPath:toPath error:&error]) {
            DLog(@"database move success");
            return YES;
        }
        DLog(@"database move failed,%ld,%@",(long)[error code],[error domain]);
        return NO;
    }
    return YES; //存在则返回
}

#pragma mark - 数据库基本操作
#pragma mark 添加 insert
-(NSInteger)insertTableName:(NSString *)tablename keyArray:(NSArray *)keyArrary valueArrary:(NSArray *)valueArrary
{
    id result = [FMDBFactory execSqlInFmdb:^id(FMDatabase *db) {
        NSString *keyString = [keyArrary componentsJoinedByString:@","];
        NSString *valueString = [valueArrary componentsJoinedByString:@"','"];
        NSString *sql = [NSString stringWithFormat:@"INSERT INTO %@ (%@) values ('%@')",tablename, keyString, valueString];
        BOOL ret = [db executeUpdate:sql];
        if (ret) {
            return [NSNumber numberWithLongLong:[db lastInsertRowId]];
        }else{
            DLog(@"failed to insert message %d, %@",[db lastErrorCode],[db lastErrorMessage]);
            return [NSNumber numberWithBool:ret];
        }

    }];
    return [result intValue];
}

#pragma mark 删除
-(BOOL)deleteFromTableName:(NSString *)tableName conditionString:(NSString *)condition
{
    id result = [FMDBFactory execSqlInFmdb:^id(FMDatabase *db) {
        NSString *sql = [NSString stringWithFormat:@"DELETE FROM %@ WHERE %@",tableName, condition];
        BOOL res = [db executeUpdate:sql];
        if (res) {
            DLog(@"success to delete");
        }else{
            DLog(@"failed to delete %d , %@",[db lastErrorCode],[db lastErrorMessage]);
        }
        return [NSNumber numberWithBool:res];
    }];
    
    return [result boolValue];
}

#pragma mark 修改
-(BOOL)updateToTableName:(NSString *)tableName kValues:(NSDictionary *)updateValue condition:(NSDictionary *)condition
{
    id result = [FMDBFactory execSqlInFmdb:^id(FMDatabase *db) {
        NSString *updateValueString;
        NSString *conditionString;
        __block NSMutableArray *updateValueArray = [NSMutableArray arrayWithCapacity:1];
        __block NSMutableArray *conditionsArray = [NSMutableArray arrayWithCapacity:1];
        [updateValue enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
            NSString *setString = [NSString stringWithFormat:@" %@ = '%@'",key, obj];
            [updateValueArray addObject:setString];
        }];
        
        [condition enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
            NSString *conString = [NSString stringWithFormat:@" %@ = '%@'",key, obj];
            [conditionsArray addObject:conString];
        }];
        
        if (updateValueArray.count>0) {
            updateValueString = [updateValueArray componentsJoinedByString:@","];
            NSString *sql = [NSString stringWithFormat:@"UPDATE %@ SET %@", tableName, updateValueString];
            if (conditionsArray.count>0) {
                conditionString = [conditionsArray componentsJoinedByString:@" AND "];
                sql = [sql stringByAppendingFormat:@" WHERE %@",conditionString];
            }
            BOOL ret = [db executeUpdate:sql];
            if (ret) {
                DLog(@"success to update %@",tableName);
            }else{
                DLog(@"failed to update %@,code:%d, message:%@",tableName, [db lastErrorCode], [db lastErrorMessage]);
            }
            
            return [NSNumber numberWithBool:ret];
        }
        return [NSNumber numberWithBool:NO];
    }];
    
    return [result boolValue];
}

#pragma mark 查询
/*
 *  if not need condition, can set condition with 1
 */
-(NSArray *)selectFromTable:(NSString *)tableName conditions:(NSDictionary *)params
{
    id result = [FMDBFactory execSqlInFmdb:^(FMDatabase *db) {
        NSString *conditionString;
        __block NSMutableArray *paramsArray = [NSMutableArray arrayWithCapacity:1];
        [params enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
            NSString *kvStr = [NSString stringWithFormat:@" %@ = '%@'",key, obj?obj:@""];
            [paramsArray addObject:kvStr];
        }];
        if (paramsArray.count>0) {
            conditionString = [paramsArray componentsJoinedByString:@" AND "];
        }
        NSString *sql = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE %@",tableName, conditionString ? conditionString : @"1"];
        FMResultSet *s = [db executeQuery:sql];
        NSMutableArray *result = [[NSMutableArray alloc] initWithCapacity:1];

        while ([s next]) {
            NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithCapacity:1];
            for (int i = 0; i < [s columnCount]; i++) {
                NSString *value = [s stringForColumnIndex:i];
                [dic setObject:(value?value:@"") forKey:[s columnNameForIndex:i]];
            }
            [result addObject:dic];
        }
        return result;
    }];
    if ([result isKindOfClass:[NSArray class]] && [result count]>0) {
        return result;
    }
    return nil;
}

#pragma mark - custom specific method


@end
