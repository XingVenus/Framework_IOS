//
//  HttpClient.m
//  HuWai
//
//  Created by WmVenusMac on 15-1-14.
//  Copyright (c) 2015年 xici. All rights reserved.
//

#import "HttpClient.h"
#import "AFNetworking.h"

@interface HttpClient ()

-(void)beforeExecute:(Response*)response;
-(void)afterExecute:(Response*)response;

@end

@implementation HttpClient
{
    AFHTTPRequestOperationManager *_manager;
}

+(HttpClient *)httpManager
{
    static HttpClient *requestManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        requestManager = [[self alloc] init];
    });
    return requestManager;
}

-(instancetype)init
{
    self = [super init];
    if (self) {
        _manager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:[NSURL URLWithString:REQUEST_BASE_URL]];
//        _manager.requestSerializer = [AFJSONRequestSerializer serializer];
        _manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
        
        _manager.operationQueue.maxConcurrentOperationCount = 4;
    }
    return self;
}

#pragma mark 网络数据请求
-(void)executeRequest:(NSString *)uri method:(HttpRequestMethod)method params:(NSDictionary *)params successBlockCallback:(SuccessResponseBlock)successcallback failBlockCallBack:(void (^)(Response *))failcallback
{
    //AFJSONRequestOperation
//    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:[NSURL URLWithString:self.baseUrl]];
    Response* response = [[Response alloc]init];
    response.afManager = _manager;
    [self beforeExecute:response];
    if (method == RequestMethodPost) {
        //post请求
        [_manager POST:uri parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            response.url = operation.request.URL.description;
            response.contentText = operation.responseString;
            response.status = [responseObject objectForKey:@"status"];
            response.code = [responseObject objectForKey:@"code"];
            response.message = [responseObject objectForKey:@"message"];
            response.data = [responseObject objectForKey:@"data"];
            response.token = [responseObject objectForKey:@"token"];
            response.error = nil;
            if(successcallback != nil)
                successcallback(response);
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
            response.url = operation.request.URL.description;
            response.contentText = operation.responseString;
            response.status = nil;
            response.code = nil;
            response.message = nil;
            response.data = nil;
            response.token = nil;
            response.error = error;
            [self afterExecute:response];
            if(failcallback != nil)
                failcallback(response);
        }];
    }else{
        //get method
        [_manager GET:uri parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
            response.contentText = operation.responseString;
            if (successcallback!=nil) {
                successcallback(response);
            }
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            response.contentText = operation.responseString;
            if (failcallback!=nil) {
                failcallback(response);
            }
        }];
    }
}

#pragma mark 请求执行前的网络判断
-(void)beforeExecute:(Response*)response
{
    NSOperationQueue *operationQueue = response.afManager.operationQueue;
    __weak  __typeof(NSOperationQueue) *weekOperationQueue = operationQueue;
    [response.afManager.reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusReachableViaWWAN:
            case AFNetworkReachabilityStatusReachableViaWiFi:
                [weekOperationQueue setSuspended:NO];
                break;
            case AFNetworkReachabilityStatusNotReachable:
            case AFNetworkReachabilityStatusUnknown:
            default:
                [weekOperationQueue setSuspended:YES];
                break;
        }
    }];
}

#pragma mark 请求执行后的错误信息提示
-(void)afterExecute:(Response *)response
{
    if (response.error == nil) {
        return;
    }
    if ([response.error code] == NSURLErrorNotConnectedToInternet) {
        [self alertErrorMessage:@"网络不给力"];
        return;
    }
    [self alertErrorMessage:@"服务器故障，请稍后再试。"];
}

-(void)alertErrorMessage:(NSString *)message
{
    [[[UIAlertView alloc]initWithTitle:@"Error" message:message delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil, nil]show];
}
@end
