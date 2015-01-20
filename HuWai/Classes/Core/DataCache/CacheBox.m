//
//  DataCache.m
//  wonderGuest2
//
//  Created by WmVenusMac on 14-1-13.
//  Copyright (c) 2014年 WmVenusMac. All rights reserved.
//

#import "CacheBox.h"

@implementation CacheBox

+ (void)saveCache:(NSString *)tag value:(id)value
{
    if (value) {
        NSUserDefaults *setting = [NSUserDefaults standardUserDefaults];
        NSString * key = [NSString stringWithFormat:@"cache-%@",tag];
        [setting setObject:value forKey:key];
        [setting synchronize];
    }
}

+ (id)getCache:(NSString *)tag
{
    NSUserDefaults *settings = [NSUserDefaults standardUserDefaults];
    NSString *key = [NSString stringWithFormat:@"cache-%@",tag];
    id value = [settings objectForKey:key];
    return value;
}

+ (void)removeObjectValue:(NSString *)_key
{
    NSUserDefaults *settings = [NSUserDefaults standardUserDefaults];
    NSString *key = [NSString stringWithFormat:@"cache-%@",_key];
    [settings removeObjectForKey:key];
    [settings synchronize];
}

//+(void)saveDictionaryCache:(NSDictionary *)dictionaryData forKey:(NSString *)key
//{
//    NSUserDefaults * setting = [NSUserDefaults standardUserDefaults];
//    NSString *_key = [NSString stringWithFormat:@"cache-%@",key];
//    [setting setObject:dictionaryData forKey:_key];
//    [setting synchronize];
//}
//
//+(NSDictionary *)getDictionaryCache:(NSString *)key
//{
//    NSUserDefaults * settings = [NSUserDefaults standardUserDefaults];
//    NSString *_key = [NSString stringWithFormat:@"cache-%@",key];
//    NSDictionary *value = [settings dictionaryForKey:_key];
//    return value;
//}
@end
