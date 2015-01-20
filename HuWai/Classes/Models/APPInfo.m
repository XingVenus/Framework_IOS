//
//  APPInfo.m
//  HuWai
//
//  Created by WmVenusMac on 15-1-19.
//  Copyright (c) 2015年 xici. All rights reserved.
//

#import "APPInfo.h"

@implementation APPInfo

+(instancetype)shareInit
{
    static APPInfo *infoObj = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        infoObj = [[self alloc] init];
    });
    return infoObj;
}

@end
