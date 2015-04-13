//
//  BaseViewController.m
//  HuWai
//
//  Created by WmVenusMac on 15-1-16.
//  Copyright (c) 2015年 xici. All rights reserved.
//



#import "BaseViewController.h"
#import "NSString+JSON.h"

/*
NSDictionary *argsTpMap(id firstObject,...)
{
    NSMutableDictionary *md = [[NSMutableDictionary alloc]init];
    @try {
        va_list arguments;
        
        id param;
        id object;
        NSString *key = firstObject;
        BOOL isFrist = true;
        if(key) {
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
    }
    @finally {
        return md;
    }
}
*/

@interface BaseViewController ()

@property (nonatomic) HttpRequestAction requestAction;

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = APP_BACKGROUND_COLOR;//RGBA(242, 242, 243, 1);
    //去掉返回按钮的文字显示
    if (self.navigationController.viewControllers.count>0) {
//        self.navigationItem.leftItemsSupplementBackButton = YES;
        UIBarButtonItem *backbutton = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil];
//        UIBarButtonItem *backbutton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"arrow-back"] style:UIBarButtonItemStylePlain target:self action:nil];
        
        self.navigationItem.backBarButtonItem = backbutton;
    }

    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated
{
    if ([APPInfo shareInit].apnsType) {
        [APPInfo shareInit].apnsType = nil;
        
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - custom method
-(void)popToLastView:(BOOL)animated
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)dismissNavigationView:(BOOL)animated
{
    [self.navigationController dismissViewControllerAnimated:animated completion:nil];
}
#pragma mark - 消息提示
-(void)showMessageWithThreeSecondAtCenter:(NSString *)message afterDelay:(NSTimeInterval)interval
{
    if (![CommonFoundation isEmptyString:message]) {
        [self.view makeToast:message duration:interval position:CSToastPositionCenter];
    }
}

#pragma mark - 加载 一般用于get请求
-(NSMutableDictionary *)argsToMap:(va_list)args firstObj:(id)firstObj
{
    NSMutableDictionary *paramDic = [[NSMutableDictionary alloc]init];
    if (firstObj) {
        id value;
        NSString *key;
        value = va_arg(args, id);
        if (!value) {
            value = @"";
        }
        [paramDic setValue:value forKey:firstObj];
        while ((key = va_arg(args, NSString *))) {
            value = va_arg(args, id);
            if (!value) {
                value = @"";
            }
            [paramDic setValue:value forKey:key];
        }
    }
    return paramDic;
}
#pragma mark - load data

-(void)loadAction:(HttpRequestAction)action params:(id)firstObject, ...
{
    NSMutableDictionary *md = [[NSMutableDictionary alloc]init];
    if(firstObject) {
        va_list arguments;
        va_start(arguments, firstObject);
        md = [self argsToMap:arguments firstObj:firstObject];
        va_end(arguments);
    }
    self.requestAction = action;
    
    [self executeRequestWithUri:[ApiServer uriStringFromAction:action] method:RequestMethodGet withHUD:NO message:nil params:md];
}

-(void)loadActionWithHUD:(HttpRequestAction)action params:(id)firstObject, ...
{
    NSMutableDictionary *md = [[NSMutableDictionary alloc]init];
    if(firstObject) {
        va_list arguments;
        va_start(arguments, firstObject);
        md = [self argsToMap:arguments firstObj:firstObject];
        va_end(arguments);
    }
    self.requestAction = action;
    
    [self executeRequestWithUri:[ApiServer uriStringFromAction:action] method:RequestMethodGet withHUD:YES message:nil params:md];
}

-(void)loadActionWithHUD:(HttpRequestAction)action message:(NSString *)message params:(id)firstObject, ...
{
    NSMutableDictionary *md = [[NSMutableDictionary alloc]init];
    if(firstObject) {
        va_list arguments;
        va_start(arguments, firstObject);
        md = [self argsToMap:arguments firstObj:firstObject];
        va_end(arguments);
    }
    self.requestAction = action;
    
    [self executeRequestWithUri:[ApiServer uriStringFromAction:action] method:RequestMethodGet withHUD:YES message:message params:md];
}

#pragma mark - post method 数据请求post 一般用于参数传递 请求数据
-(void)postAction:(HttpRequestAction)action params:(id)firstObject, ...
{
    NSMutableDictionary *md = [[NSMutableDictionary alloc]init];
    if(firstObject) {
        va_list arguments;
        va_start(arguments, firstObject);
        md = [self argsToMap:arguments firstObj:firstObject];
        va_end(arguments);
    }
    
    self.requestAction = action;
    
    NSString *uriString = [ApiServer uriStringFromAction:action];
    [self executeRequestWithUri:uriString method:RequestMethodPost withHUD:NO message:nil params:md];
}

-(void)postActionWithHUD:(HttpRequestAction)action params:(id)firstObject, ...
{
    NSMutableDictionary *md = [[NSMutableDictionary alloc]init];
    if(firstObject) {
        va_list arguments;
        va_start(arguments, firstObject);
        md = [self argsToMap:arguments firstObj:firstObject];
        va_end(arguments);
    }
    
    self.requestAction = action;
    
    NSString *uriString = [ApiServer uriStringFromAction:action];
    [self executeRequestWithUri:uriString method:RequestMethodPost withHUD:YES message:nil params:md];
}

-(void)postActionWithHUD:(HttpRequestAction)action message:(NSString *)message params:(id)firstObject, ...
{
    NSMutableDictionary *md = [[NSMutableDictionary alloc]init];
    if(firstObject) {
        va_list arguments;
        va_start(arguments, firstObject);
        md = [self argsToMap:arguments firstObj:firstObject];
        va_end(arguments);
    }
    
    self.requestAction = action;
    
    NSString *uriString = [ApiServer uriStringFromAction:action];
    [self executeRequestWithUri:uriString method:RequestMethodPost withHUD:YES message:message params:md];
}
#pragma mark - post uri with need to replace string 需要做替换时使用
-(void)postAppendUriAction:(HttpRequestAction)action withValue:(NSString *)appendValue params:(id)firstObject, ...
{
    NSMutableDictionary *md = [[NSMutableDictionary alloc]init];
    if(firstObject) {
        va_list arguments;
        va_start(arguments, firstObject);
        md = [self argsToMap:arguments firstObj:firstObject];
        va_end(arguments);
    }
    
    self.requestAction = action;

    NSString *uriString = [self replaceAppendUri:action value:appendValue];
    [self executeRequestWithUri:uriString method:RequestMethodPost withHUD:NO message:nil params:md];
}

-(void)postAppendUriActionWithHUD:(HttpRequestAction)action withValue:(NSString *)appendValue params:(id)firstObject, ...{
    NSMutableDictionary *md = [[NSMutableDictionary alloc]init];
    if(firstObject) {
        va_list arguments;
        va_start(arguments, firstObject);
        md = [self argsToMap:arguments firstObj:firstObject];
        va_end(arguments);
    }
    self.requestAction = action;
    
    NSString *uriString = [self replaceAppendUri:action value:appendValue];
    [self executeRequestWithUri:uriString method:RequestMethodPost withHUD:YES message:nil params:md];
}

-(void)postAppendUriActionWithHUD:(HttpRequestAction)action withValue:(NSString *)appendValue message:(NSString *)message params:(id)firstObject, ...
{
    NSMutableDictionary *md = [[NSMutableDictionary alloc]init];
    if(firstObject) {
        va_list arguments;
        va_start(arguments, firstObject);
        md = [self argsToMap:arguments firstObj:firstObject];
        va_end(arguments);
    }
    
    self.requestAction = action;
    
    NSString *uriString = [self replaceAppendUri:action value:appendValue];
    [self executeRequestWithUri:uriString method:RequestMethodPost withHUD:YES message:message params:md];
}

-(NSString *)replaceAppendUri:(HttpRequestAction)action value:(NSString *)value
{
    NSString *uriString = [ApiServer uriStringFromAction:action];
    NSRange rang = [uriString rangeOfString:@":"];
    if ((rang.location != NSNotFound) && value) {
        uriString = [[uriString substringWithRange:NSMakeRange(0, rang.location)] stringByAppendingString:value];
    }
    return uriString;
}

#pragma mark - 发起请求
-(void)executeRequestWithUri:(NSString *)uristring method:(HttpRequestMethod)method withHUD:(BOOL)hud message:(NSString *)message params:(NSMutableDictionary *)params
{
    if (hud) {
        if(self.hud == nil) {
            self.hud = [[MBProgressHUD alloc] init];
            if (message) {
                self.hud.labelText = message;
            }
            [self.view addSubview:self.hud];
        }
        [self.hud show:YES];
    }
    //组织参数
    //----每次请求自动带上token值
    NSString *token = [CacheBox getCache:CACHE_TOKEN];
    if (token) {
        [params setObject:token forKey:@"token"];
    }
    //系统统计需求加入的统计信息字段
    [params setObject:@"ios" forKey:@"system"];
    [params setObject:[[UIDevice currentDevice] systemVersion] forKey:@"systemversion"];
    [params setObject:[CommonFoundation deviceString] forKey:@"model"];
    [params setObject:APP_VERSION forKey:@"appversion"];
#ifdef DEBUG
    if (method == RequestMethodPost) {
        DLog(@"Post data:%@",params);
    }
#endif
    
    __block HttpRequestAction weakAction = self.requestAction;
    [[HttpClient httpManager] executeRequest:uristring method:method params:params successBlockCallback:^(Response *response) {
        [self.hud hide:YES];
//        //保存每次请求更新的token
//        if (response.token) {
//            [CacheBox saveCache:CACHE_TOKEN value:response.token];
////            [APPInfo shareInit].token = response.token;
//        }
        DLog(@"Request url:%@\n Success Response string:%@",response.url,[response.contentText JSONValue]);
        [self requestWithResponse:weakAction response:response];
    } failBlockCallBack:^(Response *response) {
        [self.hud hide:YES];
        DLog(@"Request url:%@\n Fail Response string:%@\n Error:%@",response.url,response.contentText,response.error);
        [self requestWithResponse:weakAction response:response];
    }];
}

#pragma mark 请求返回调用
-(void)requestWithResponse:(HttpRequestAction)actionType response:(Response *)response
{
    if (response.code == 20000) {
        [self onRequestFinished:actionType response:response];
    }else if (response.error){
        [self onRequestFailed:actionType response:response];
        [self showMessageWithThreeSecondAtCenter:response.error.localizedDescription afterDelay:2.0];
        return;
    }else if (response.code == 50002){
        BaseNavigationController *loginNav = [self.storyboard instantiateViewControllerWithIdentifier:@"loginNavBoard"];
        //        [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:loginNav animated:YES completion:nil];
        [self.navigationController presentViewController:loginNav animated:YES completion:^{
            //监听登录，完成登录刷新页面

        }];
        return;
    }else if ((response.code == 40000) ||(response.code == 40001)){
        DLog(@"%@",response);
        return;
    }
    
    if (!self.hideShowMessage) {
        [self showMessageWithThreeSecondAtCenter:response.message afterDelay:2.0];
    }else{
        self.hideShowMessage = NO;
    }
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

#pragma mark - custom method
-(NSString *)genderToString:(NSInteger)gender
{
    if (gender == 0) {
        return @"女";
    }else if(gender == 1){
        return @"男";
    }
    return nil;
}
@end
