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

//- (void)viewWillAppear:(BOOL)animated
//{
//    if ([APPInfo shareInit].apnsType) {
//        [APPInfo shareInit].apnsType = nil;
//        
//    }
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)requestWithResponse:(HttpRequestAction)actionType response:(Response *)response
{
    if (response.code == 20000) {
        [self onRequestFinished:actionType response:response];
    }else if (response.error){
        [self onRequestFailed:actionType response:response];
        [self showMessageWithThreeSecondAtCenter:response.error.localizedDescription afterDelay:1.0];
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
    //默认hideShowMessage为NO,显示请求返回信息
    if (!self.hideShowMessage) {
        [self showMessageWithThreeSecondAtCenter:response.message afterDelay:1.0];
    }else{
        self.hideShowMessage = NO;
    }
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
