//
//  Response.h
//  HuWai
//
//  Created by WmVenusMac on 15-1-15.
//  Copyright (c) 2015年 xici. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFHTTPRequestOperationManager.h"

@interface Response : NSObject

@property (strong, nonatomic) AFHTTPRequestOperationManager* afManager;
@property (nonatomic, strong) NSString *url;
@property (nonatomic, strong) NSString *contentText;//返回所有的内容
@property (nonatomic, strong) NSString *status;
@property (nonatomic, strong) NSNumber *code;
@property (nonatomic, strong) NSString *message;
@property (nonatomic, strong) NSString *token;
@property (nonatomic, strong) id data;
@property (strong, nonatomic) NSError *error;
@end
