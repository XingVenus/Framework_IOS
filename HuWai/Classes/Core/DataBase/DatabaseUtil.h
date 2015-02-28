//
//  DatabaseUtil.h
//  Sanbao
//
//  Created by WmVenusMac on 14-6-28.
//  Copyright (c) 2014年 venus. All rights reserved.

/*
 CREATE  TABLE "main"."commonperson" ("id" INTEGER PRIMARY KEY  AUTOINCREMENT  NOT NULL , "pid" INTEGER, "name" VARCHAR, "gender" VARCHAR, "identity" VARCHAR, "phone" VARCHAR, "ownerid" INTEGER)
 */
//

#import <Foundation/Foundation.h>
#import "FMDBFactory.h"

typedef NSArray *(^MessageBlock)(void);
@interface DatabaseUtil : NSObject
{
    FMDatabase *_dbConnect;
}

+(instancetype)shareDatabase;

-(NSInteger)insertTableName:(NSString *)tablename keyArray:(NSArray *)keyArrary valueArrary:(NSArray *)valueArrary;
-(BOOL)deleteFromTableName:(NSString *)tableName conditionString:(NSString *)condition;
-(BOOL)updateToTableName:(NSString *)tableName kValues:(NSDictionary *)updateValue condition:(NSDictionary *)condition;
-(NSArray *)selectFromTable:(NSString *)tableName conditions:(NSDictionary *)params;

@end
