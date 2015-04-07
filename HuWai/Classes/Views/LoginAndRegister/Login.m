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
{
    NSString *_phoneStr;
    NSString *_pwdStr;
}
@property (weak, nonatomic) IBOutlet UIButton *forgetPasswordButton;
@property (weak, nonatomic) IBOutlet UIButton *registerButton;
@property (weak, nonatomic) IBOutlet UITextField *phoneNumber;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;

@property (weak, nonatomic) IBOutlet UIButton *xiciLoginBtn;
@property (weak, nonatomic) IBOutlet UIButton *weixinLoginBtn;
@property (weak, nonatomic) IBOutlet UIButton *qqLoginBtn;
@end

@implementation Login

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.xiciLoginBtn.layer.cornerRadius = 48/2;
    self.xiciLoginBtn.layer.masksToBounds = YES;
    self.weixinLoginBtn.layer.cornerRadius = 48/2;
    self.weixinLoginBtn.layer.masksToBounds = YES;
    self.qqLoginBtn.layer.cornerRadius = 48/2;
    self.qqLoginBtn.layer.masksToBounds = YES;
    //下划线设置
    [self.forgetPasswordButton underSingleLineWithTitle];
    //注册下划线
    [self.registerButton underSingleLineWithTitle];
    
    [self.loginButton addTarget:self action:@selector(loginAction:) forControlEvents:UIControlEventTouchUpInside];
    self.phoneNumber.text = [CacheBox getCache:CACHE_USER_PHONE]?[CacheBox getCache:CACHE_USER_PHONE]:@"";
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
    _phoneStr = [CommonFoundation trimString:self.phoneNumber.text];
    _pwdStr = [CommonFoundation trimString:self.password.text];
    if ([CommonFoundation isEmptyString:_phoneStr]) {
        errorStr = @"请输入手机号码";
    }else if ([CommonFoundation isEmptyString:_pwdStr]){
        errorStr = @"密码不能为空";
    }
    if (errorStr) {
        [self showMessageWithThreeSecondAtCenter:errorStr];
    }else{
        [self postActionWithHUD:UserEntryAction params:@"phone",_phoneStr,@"password",_pwdStr,nil];
    }

//    [self loadAction:GettokenAction params:nil];
}

-(void)onRequestFinished:(HttpRequestAction)tag response:(Response *)response
{
        
    if (tag == GettokenAction) {
        //获取用户登录令牌成功
//        [self postActionWithHUD:UserEntryAction params:@"phone",[CommonFoundation trimString:self.phoneNumber.text],@"password",[CommonFoundation trimString:self.password.text],@"loginToken",response.data[@"loginToken"],nil];
//        return;
    }else if (tag == UserEntryAction){
        [self.view endEditing:YES];
        APPInfo *infoObj = [APPInfo shareInit];
        //保存token
        [CacheBox saveCache:CACHE_TOKEN value:response.token];
        //赋值更新用户信息
        [infoObj updateUserInfo:response.data];
        //缓存用户登录账号
        [CacheBox saveCache:CACHE_USER_PHONE value:_phoneStr];
        [CacheBox saveCache:CACHE_USER_PASSWORD value:_pwdStr];
        
        [self dismissNavigationView:YES];
    }

}
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

@end
