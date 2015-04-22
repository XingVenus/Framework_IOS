//
//  CoreController.h
//  HuWai
//
//  Created by WmVenusMac on 15-4-14.
//  Copyright (c) 2015年 xici. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ApiServer.h"

@interface CoreController : UIViewController

//post action method
-(void)postAction:(HttpRequestAction) action params:(id)firstObject, ...;
-(void)postActionWithHUD:(HttpRequestAction) action params:(id)firstObject, ...;
-(void)postActionWithHUD:(HttpRequestAction) action message:(NSString *)message params:(id)firstObject, ...;
//post and append uri method
-(void)postAppendUriAction:(HttpRequestAction)action withValue:(NSString *)appendValue params:(id)firstObject, ...;
-(void)postAppendUriActionWithHUD:(HttpRequestAction)action withValue:(NSString *)appendValue params:(id)firstObject, ...;
-(void)postAppendUriActionWithHUD:(HttpRequestAction)action withValue:(NSString *)appendValue message:(NSString *)message params:(id)firstObject, ...;
//load action method
-(void)loadAction:(HttpRequestAction) action params:(id)firstObject, ...;
-(void)loadActionWithHUD:(HttpRequestAction) action params:(id)firstObject, ...;
-(void)loadActionWithHUD:(HttpRequestAction) action message:(NSString *)message params:(id)firstObject, ...;
/**
 *  网络请求返回预处理
 */
-(void)requestWithResponse:(HttpRequestAction)actionType response:(Response *)response;
//请求成功的返回
-(void)onRequestFinished:(HttpRequestAction)tag response:(Response *)response;
//请求失败的返回
-(void)onRequestFailed:(HttpRequestAction)tag response:(Response *)response;
/**
 *  请求参数整合
 */
-(NSMutableDictionary *)argsToMap:(va_list)args firstObj:(id)firstObj;

@end
