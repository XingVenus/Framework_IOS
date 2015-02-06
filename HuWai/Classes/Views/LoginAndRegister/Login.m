//
//  Login.m
//  HuWai
//
//  Created by WmVenusMac on 15-1-19.
//  Copyright (c) 2015年 xici. All rights reserved.
//

#import "Login.h"
#import "UIButton+ButtonUtility.h"
#import "EntryModel.h"
@interface Login ()
@property (weak, nonatomic) IBOutlet UIButton *forgetPasswordButton;
@property (weak, nonatomic) IBOutlet UIButton *registerButton;
@property (weak, nonatomic) IBOutlet UITextField *phoneNumber;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;

@end

@implementation Login

- (void)viewDidLoad {
    [super viewDidLoad];
    //下划线设置
    [self.forgetPasswordButton underSingleLineWithTitle];
    //注册下划线
    [self.registerButton underSingleLineWithTitle];
    
    [self.loginButton addTarget:self action:@selector(loginAction:) forControlEvents:UIControlEventTouchUpInside];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark 开始登录动作
-(void)loginAction:(UIButton *)sender
{
    NSString *errorStr = nil;
    if ([CommonFoundation isEmptyString:self.phoneNumber.text]) {
        errorStr = @"请输入手机号码";
    }else if ([CommonFoundation isEmptyString:self.password.text]){
        errorStr = @"密码不能为空";
    }
    if (errorStr) {
        [self.view makeToast:errorStr duration:2 position:CSToastPositionCenter];
        return;
    }
    self.showRequestHUD = NO;
    [self loadAction:GettokenAction params:nil];
}

-(void)onRequestFinished:(HttpRequestAction)tag response:(Response *)response
{
    if (response.code == 20000) {
        
        if (tag == GettokenAction) {
            //获取用户登录令牌成功
            self.showRequestHUD = YES;
            [self postAction:UserEntryAction params:@"phone",[CommonFoundation trimString:self.phoneNumber.text],@"password",[CommonFoundation trimString:self.password.text],@"loginToken",response.data[@"loginToken"],nil];
            return;
        }else if (tag == UserEntryAction){
            APPInfo *infoObj = [APPInfo shareInit];
            infoObj.login = YES;
            //赋值更新用户信息
            [infoObj updateUserInfo:response.data];
            //缓存用户登录账号
            [CacheBox saveCache:CACHE_USER_PHONE value:[CommonFoundation trimString:self.phoneNumber.text]];
            [CacheBox saveCache:CACHE_USER_PASSWORD value:[CommonFoundation trimString:self.password.text]];
        }
    }
    [self showMessageWithThreeSecondAtCenter:response.message];
}
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

-(void)dismissLoginVC
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
