//
//  BaseViewController.h
//  HuWai
//
//  Created by WmVenusMac on 15-1-16.
//  Copyright (c) 2015年 xici. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MBProgressHUD/MBProgressHUD.h>

#import "ApiServer.h"
@interface BaseViewController : UIViewController

@property (nonatomic, strong) NSString *promptMessage; //hud的消息提示
@property (nonatomic,getter=isShowRequestHUD) BOOL showRequestHUD;  //是否显示请求提示hud框

-(void)showMessageWithThreeSecondAtCenter:(NSString *)message;

-(void)postAction:(HttpRequestAction) action params:(id)firstObject, ...;
-(void)postAppendUriAction:(HttpRequestAction)action withValue:(NSString *)appendValue params:(id)firstObject, ...;
-(void)loadAction:(HttpRequestAction) action params:(id)firstObject, ...;
//请求成功的返回
-(void)onRequestFinished:(HttpRequestAction)tag response:(Response *)response;
//请求失败的返回
-(void)onRequestFailed:(HttpRequestAction)tag response:(Response *)response;
//-(NSDictionary*)argsToMap:(va_list)args firstObj:(id)firstObj;
//@property(strong, nonatomic) UILabel *loadingLabel;
@property(strong, nonatomic) MBProgressHUD * hud;

@end
