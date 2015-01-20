//
//  BaseViewController.m
//  HuWai
//
//  Created by WmVenusMac on 15-1-16.
//  Copyright (c) 2015年 xici. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark 加载 一般用于get请求
-(void)loadAction:(HttpRequestAction)action params:(id)firstObject, ...
{
    va_list arguments;
    
    NSMutableDictionary *md = [[NSMutableDictionary alloc]init];
    id param;
    id object = firstObject;
    NSString *key;
    BOOL isFrist = true;
    if(object != nil) {
        va_start(arguments, firstObject);
        
        while((param = va_arg(arguments, id))) {
            if(param == nil)
                break;
            if(isFrist) {
                key = param;
                isFrist = false;
            } else {
                object = param;
                key = va_arg(arguments, id);
                if(key == nil) {
                    break;
                }
            }
            [md setObject:object forKey:key];
        }
        va_end(arguments);
    }
    
    if(self.hud == nil) {
        self.hud = [[MBProgressHUD alloc] init];
        self.hud.labelText = self.promptMessage ? self.promptMessage : @"正在加载...";
        [self.hud setRemoveFromSuperViewOnHide:YES];
        [self.view addSubview:self.hud];
    }
    [self.hud show:YES];
    
    [[HttpClient httpManager] executeRequest:[self uriStringFromAction:action] method:RequestMethodGet params:md successBlockCallback:^(Response *response) {
        [self.hud hide:YES];
        [self onRequestFinished:action response:response];
    } failBlockCallBack:^(Response *response) {
        [self.hud hide:YES];
        [self onRequestFinished:action response:response];
    }];
}

#pragma mark 数据请求post 一般用于参数传递 请求数据
-(void)postAction:(HttpRequestAction)action params:(id)firstObject, ...
{
    va_list arguments;
    
    NSMutableDictionary *md = [[NSMutableDictionary alloc]init];
    id param;
    id object = firstObject;
    NSString *key;
    BOOL isFrist = true;
    if(object != nil) {
        va_start(arguments, firstObject);
        
        while((param = va_arg(arguments, id))) {
            if(param == nil)
                break;
            if(isFrist) {
                key = param;
                isFrist = false;
            } else {
                object = param;
                key = va_arg(arguments, id);
                if(key == nil) {
                    break;
                }
            }
            [md setObject:object forKey:key];
        }
        va_end(arguments);
    }
    
    if(self.hud == nil) {
        self.hud = [[MBProgressHUD alloc] init];
        self.hud.labelText = self.promptMessage ? self.promptMessage : @"正在加载";
        [self.hud setRemoveFromSuperViewOnHide:YES];
        [self.view addSubview:self.hud];
    }
    [self.hud show:YES];
    
    [[HttpClient httpManager] executeRequest:[self uriStringFromAction:action] method:RequestMethodPost params:md successBlockCallback:^(Response *response) {
        [self.hud hide:YES];
        DLog(@"Request url:%@, Success Response string:%@",response.url,response.contentText);
        [self onRequestFinished:action response:response];
    } failBlockCallBack:^(Response *response) {
        [self.hud hide:YES];
        DLog(@"Request url:%@, Fail Response string:%@, Error:%@",response.url,response.contentText,response.error);
        [self onRequestFinished:action response:response];
    }];
}

#pragma mark 请求uri定位
-(NSString *)uriStringFromAction:(HttpRequestAction)action
{
    NSString *uristring = nil;
    switch (action) {
        case UserLoginAction:
        {
            uristring = UserLogin_Uri;
        }
            break;
        case UserRegisterAction:
        {
            uristring = UserRegister_Uri;
        }
            break;
        case SendSmsAction:
        {
            uristring = SendSms_Uri;
        }
            break;
        default:
            break;
    }
    return uristring;
}

-(void)onRequestFinished:(NSInteger)tag response:(Response *)response
{
    
}
@end
