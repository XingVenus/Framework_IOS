//
//  BaseViewController.h
//  HuWai
//
//  Created by WmVenusMac on 15-1-16.
//  Copyright (c) 2015年 xici. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MBProgressHUD/MBProgressHUD.h>
#import "BaseNavigationController.h"
#import "ApiServer.h"
#import "BlankView.h"

//NSDictionary *argsTpMap(id firstObject,...);

@interface BaseViewController : UIViewController

@property (nonatomic, assign) BOOL hideShowMessage;
@property (strong, nonatomic) MBProgressHUD * hud;
@property (nonatomic, strong) BlankView *blankView;  //默认空白页面的显示

-(void)showMessageWithThreeSecondAtCenter:(NSString *)message;
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
//请求成功的返回
-(void)onRequestFinished:(HttpRequestAction)tag response:(Response *)response;
//请求失败的返回
-(void)onRequestFailed:(HttpRequestAction)tag response:(Response *)response;

-(NSMutableDictionary *)argsToMap:(va_list)args firstObj:(id)firstObj;
-(IBAction)popToLastView:(id)sender;
-(IBAction)dismissNavigationView:(BOOL)animated;

//-----custom method to use
-(NSString *)genderToString:(NSInteger)gender;
@end
