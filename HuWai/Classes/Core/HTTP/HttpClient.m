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

-(void)beforeExecute;
-(void)afterExecute:(NSError*)error;

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
    WEAKSELF;
    [self beforeExecute];
    if (method == RequestMethodPost) {
        //post请求
        [_manager POST:uri parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            Response *response = [weakSelf extractRespon:operation responseObj:responseObject error:nil ];
            if(successcallback != nil)
                successcallback(response);
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
            Response *response = [weakSelf extractRespon:operation responseObj:nil error:error ];
            [self afterExecute:error]; //错误信息提示
            if(failcallback != nil)
                failcallback(response);
        }];
    }else{
        //get method
        [_manager GET:uri parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
            Response *response = [weakSelf extractRespon:operation responseObj:responseObject error:nil ];
            if (successcallback!=nil) {
                successcallback(response);
            }
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            Response *response = [weakSelf extractRespon:operation responseObj:nil error:error];
            [self afterExecute:error];//错误信息提示
            if (failcallback != nil) {
                failcallback(response);
            }
        }];
    }
}

#pragma mark 组织返回数据
-(Response *)extractRespon:(AFHTTPRequestOperation *)operation responseObj:(id)responseObject error:(NSError *)error
{
    Response* response = [[Response alloc]init];
    response.afManager = _manager;
    if (responseObject) {
        
        [response fillWithJsonDict:(NSDictionary *)responseObject];
        response.url = [operation.request.URL absoluteString];
        response.contentText = operation.responseString;

    }else{
        
        response.url = [operation.request.URL absoluteString];
        response.contentText = operation.responseString;
        response.error = error;
    }
    
    return response;
}

#pragma mark 请求执行前的网络判断
-(void)beforeExecute
{
    NSOperationQueue *operationQueue = _manager.operationQueue;
    __weak  __typeof(NSOperationQueue) *weekOperationQueue = operationQueue;
    [_manager.reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
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
-(void)afterExecute:(NSError *)error
{
    if (error == nil) {
        return;
    }
    if ([error code] == NSURLErrorNotConnectedToInternet) {
        [self alertErrorMessage:@"网络不给力"];
        return;
    }
    [self alertErrorMessage:@"数据请求失败，请稍后再试。"];
}

-(void)alertErrorMessage:(NSString *)message
{
    [[[UIAlertView alloc] initWithTitle:@"提示" message:message delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil, nil]show];
}
@end
