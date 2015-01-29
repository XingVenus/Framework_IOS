//
//  BaseViewController.m
//  HuWai
//
//  Created by WmVenusMac on 15-1-16.
//  Copyright (c) 2015年 xici. All rights reserved.
//

#import "BaseViewController.h"
#import "NSString+JSON.h"

@interface BaseViewController ()

@property (nonatomic) HttpRequestAction requestAction;
@property (nonatomic) HttpRequestMethod requestMethod;

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = RGBA(242, 242, 243, 1);
    self.showRequestHUD = YES;//默认显示
    if (self.navigationController.viewControllers.count>1) {
        UIBarButtonItem *backbutton = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:nil];
        self.navigationItem.backBarButtonItem = backbutton;
    }
//
//    self.navigationController.navigationItem.backBarButtonItem.title = @"fff";
//    self.navigationController.navigationItem.leftBarButtonItem.title = @"ff";
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 消息提示
-(void)showMessageWithThreeSecondAtCenter:(NSString *)message
{
    if (![CommonFoundation isEmptyString:message]) {
        [self.view makeToast:message duration:3.0 position:CSToastPositionCenter];
    }
}

#pragma mark - 加载 一般用于get请求
-(void)loadAction:(HttpRequestAction)action params:(id)firstObject, ...
{
    va_list arguments;
    
    NSMutableDictionary *md = [[NSMutableDictionary alloc]init];
    id param;
    id object;
    NSString *key = firstObject;
    BOOL isFrist = true;
    if(key != nil) {
        va_start(arguments, firstObject);
        
        while((param = va_arg(arguments, id))) {
            if(param == nil)
                break;
            if(isFrist) {
                object = param;
                isFrist = false;
            } else {
                key = param;
                object = va_arg(arguments, id);
                if(key == nil) {
                    break;
                }
            }
            [md setObject:object forKey:key];
        }
        va_end(arguments);
        
        DLog(@"Post data:%@",md);
    }
    self.requestAction = action;
    self.requestMethod = RequestMethodGet;
    //每次请求自动带上token值
    if ([APPInfo shareInit].token) {
        [md setObject:[APPInfo shareInit].token forKey:@"token"];
    }
    
    [self executeRequest:[ApiServer uriStringFromAction:action] params:md];
}


#pragma mark - 数据请求post 一般用于参数传递 请求数据
-(void)postAction:(HttpRequestAction)action params:(id)firstObject, ...
{
    NSMutableDictionary *md = [[NSMutableDictionary alloc]init];
    @try {
        va_list arguments;
        
        id param;
        id object;
        NSString *key = firstObject;
        BOOL isFrist = true;
        if(key != nil) {
            va_start(arguments, firstObject);
            
            while((param = va_arg(arguments, id))) {
                if(param == nil)
                    break;
                if(isFrist) {
                    object = param;
                    isFrist = false;
                } else {
                    key = param;
                    object = va_arg(arguments, id);
                    if(key == nil) {
                        break;
                    }
                }
                [md setObject:object forKey:key];
            }
            va_end(arguments);
        }
    }
    @catch (NSException *exception) {
        DLog(@"%s\n%@", __FUNCTION__, exception);
        return;
    }
    @finally {
        
    }
    self.requestAction = action;

    self.requestMethod = RequestMethodPost;
    //每次请求自动带上token值
    if ([APPInfo shareInit].token) {
        [md setObject:[APPInfo shareInit].token forKey:@"token"];
    }
    
    NSString *uriString = [ApiServer uriStringFromAction:action];
    [self executeRequest:uriString params:md];
}
#pragma mark uri中需要做替换时使用
-(void)postAppendUriAction:(HttpRequestAction)action withValue:(NSString *)appendValue params:(id)firstObject, ...
{
    va_list arguments;
    
    NSMutableDictionary *md = [[NSMutableDictionary alloc]init];
    id param;
    id object;
    NSString *key = firstObject;
    BOOL isFrist = true;
    if(key != nil) {
        va_start(arguments, firstObject);
        
        while((param = va_arg(arguments, id))) {
            if(param == nil)
                break;
            if(isFrist) {
                object = param;
                isFrist = false;
            } else {
                key = param;
                object = va_arg(arguments, id);
                if(key == nil) {
                    break;
                }
            }
            [md setObject:object forKey:key];
        }
        va_end(arguments);
    }
    
    self.requestAction = action;
    self.requestMethod = RequestMethodPost;
    //每次请求自动带上token值
    if ([APPInfo shareInit].token) {
        [md setObject:[APPInfo shareInit].token forKey:@"token"];
    }
    
    NSString *uriString = [ApiServer uriStringFromAction:action];
    NSRange rang = [uriString rangeOfString:@":"];
    if (appendValue) {
        uriString = [[uriString substringWithRange:NSMakeRange(0, rang.location)] stringByAppendingString:appendValue];
        [self executeRequest:uriString params:md];
    }
    
}

#pragma mark - 发起请求
-(void)executeRequest:(NSString *)uristring params:(NSDictionary *)param
{
    if (_showRequestHUD) {
        if(self.hud == nil) {
            self.hud = [[MBProgressHUD alloc] init];
            self.hud.labelText = self.promptMessage ? self.promptMessage : @"正在加载";
            [self.view addSubview:self.hud];
        }
        [self.hud show:YES];
    }
    DLog(@"Post data:%@",param);
    [[HttpClient httpManager] executeRequest:uristring method:self.requestMethod params:param successBlockCallback:^(Response *response) {
        [self.hud hide:YES];
        //保存每次请求更新的token
        if (response.token.description.length == 72) {
            [APPInfo shareInit].token = response.token;
        }
        DLog(@"Request url:%@\n Success Response string:%@",response.url,[response.contentText JSONValue]);
        [self onRequestFinished:self.requestAction response:response];
    } failBlockCallBack:^(Response *response) {
        [self.hud hide:YES];
        DLog(@"Request url:%@\n Fail Response string:%@\n Error:%@",response.url,response.contentText,response.error);
        [self onRequestFailed:self.requestAction response:response];
    }];
}

#pragma mark - This method needs to be redefined
#pragma mark 请求成功调用返回
-(void)onRequestFinished:(HttpRequestAction)tag response:(Response *)response
{
    
}
#pragma mark 请求失败调用返回
-(void)onRequestFailed:(HttpRequestAction)tag response:(Response *)response
{
    
}
@end
