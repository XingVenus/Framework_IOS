//
//  DataCache.h
//  wonderGuest2
//
//  沙盒缓存数据
//
//  Created by WmVenusMac on 14-1-13.
//  Copyright (c) 2014年 WmVenusMac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CacheBox : NSObject

//将数据保存到沙盒
+ (void)saveCache:(NSString *)tag value:(id)value;

//读取本地沙盒
+ (id)getCache:(NSString *)tag;

+ (void)removeObjectValue:(NSString *)_key;

////保存字典数据到沙盒
//+ (void)saveDictionaryCache:(NSDictionary *)dictionaryData forKey:(NSString *)key;
////读取沙盒的字典数据
//+ (NSDictionary *)getDictionaryCache:(NSString *)key;
@end
