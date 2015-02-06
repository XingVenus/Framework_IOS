//
//  Response.h
//  HuWai
//
//  Created by WmVenusMac on 15-1-15.
//  Copyright (c) 2015年 xici. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFHTTPRequestOperationManager.h"
#import "RFJModel.h"

@interface Response : RFJModel

JProperty(BOOL status, status);
JProperty(NSInteger code, code);
JProperty(NSString *message, message);
JProperty(NSString *token, token);
JProperty(NSDictionary *data, data);

@property (strong, nonatomic) AFHTTPRequestOperationManager* afManager;
@property (nonatomic, strong) NSString *url;
@property (nonatomic, strong) NSString *contentText;//返回所有的内容
//@property (nonatomic, strong) id data;
@property (strong, nonatomic) NSError *error;
@end
