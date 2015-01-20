//
//  NSString+JSONCategories.m
//  Sanbao
//
//  Created by WmVenusMac on 14-7-8.
//  Copyright (c) 2014年 venus. All rights reserved.
//

#import "NSString+JSON.h"

@implementation NSString (JSON)
-(id)JSONValue
{
    NSData* data = [self dataUsingEncoding:NSUTF8StringEncoding];
    __autoreleasing NSError* error = nil;
    id result = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    if (error != nil) return nil;
    return result;
}
@end

@implementation NSObject (JSON)

-(NSData *)JSONString
{
    NSError* error = nil;
    id result = [NSJSONSerialization dataWithJSONObject:self
                                                options:kNilOptions error:&error];
    if (error != nil) return nil;
    return result;
}
@end