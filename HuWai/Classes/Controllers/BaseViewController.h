//
//  BaseViewController.h
//  HuWai
//
//  Created by WmVenusMac on 15-1-16.
//  Copyright (c) 2015年 xici. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MBProgressHUD/MBProgressHUD.h>
#import "Api.h"

@interface BaseViewController : UIViewController

@property (nonatomic, strong) NSString *promptMessage;

-(void)postAction:(HttpRequestAction) action params:(id)firstObject, ...;
-(void)loadAction:(HttpRequestAction) action params:(id)firstObject, ...;
-(void)onRequestFinished:(NSInteger)tag response:(Response *)response;
//-(NSDictionary*)argsToMap:(va_list)args;
//@property(strong, nonatomic) UILabel *loadingLabel;
@property(strong, nonatomic) MBProgressHUD * hud;

@end
