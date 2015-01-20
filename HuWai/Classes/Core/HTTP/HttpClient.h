//
//  HttpClient.h
//  HuWai
//
//  Created by WmVenusMac on 15-1-14.
//  Copyright (c) 2015年 xici. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Response.h"

typedef void (^SuccessResponseBlock)(Response *response);

typedef NS_ENUM(NSInteger, HttpRequestMethod) {
    RequestMethodGet = 0,
    RequestMethodPost,
};

@interface HttpClient : NSObject

@property(strong, nonatomic)NSString* baseUrl;

+(HttpClient *)httpManager;
-(void)executeRequest:(NSString*)uri method:(HttpRequestMethod)method params:(NSDictionary*)params successBlockCallback:(SuccessResponseBlock)successcallback failBlockCallBack:(void (^)(Response* response))failcallback;
@end
