//
//  Register.m
//  HuWai
//
//  Created by WmVenusMac on 15-1-21.
//  Copyright (c) 2015年 xici. All rights reserved.
//

#import "Register.h"

@interface Register ()
{
    NSString *_smsToken;
    
    NSString *_phone;
    NSString *_pwd;
    NSString *_username;
    NSString *_smsCode;
}
@property (weak, nonatomic) IBOutlet UITextField *phoneNumber;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UITextField *nickName;
@property (weak, nonatomic) IBOutlet UITextField *textCode;

- (IBAction)getTextCode:(id)sender;

- (IBAction)registerAction:(id)sender;
@end

@implementation Register

- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.fromType == AcountTypeXiCi) {
        self.password.text = self.xiciPwd;
        self.nickName.text = self.xiciInfo[@"username"];
        if (![self.xiciInfo[@"username"] hasPrefix:@"游客"] && ![CommonFoundation isEmptyString:self.xiciInfo[@"username"]]) {
            self.nickName.enabled = NO;
        }
    }
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)getTextCode:(id)sender {
    if (![CommonFoundation checkPhoneNo:self.phoneNumber.text]) {
        [self showMessageWithThreeSecondAtCenter:@"请输入正确的手机号码"];
        return;
    }
    
    [self postActionWithHUD:SendSmsAction params:@"phone",[CommonFoundation trimString:self.phoneNumber.text],@"type",@"regist",nil];
}
#pragma mark 发起注册
- (IBAction)registerAction:(id)sender {
    NSString *errorString = nil;
    _phone = [CommonFoundation trimString:self.phoneNumber.text];
    _pwd = [CommonFoundation trimString:self.password.text];
    _username = [CommonFoundation trimString:self.nickName.text];
    _smsCode = [CommonFoundation trimString:self.textCode.text];
    if (![CommonFoundation checkPhoneNo:_phone]) {
        errorString = @"请输入正确的手机号码";
    }else if ([CommonFoundation isEmptyString:_pwd]){
        errorString = @"密码不能为空";
    }else if ([CommonFoundation isEmptyString:_username]){
        errorString = @"请输入昵称";
    }else if ([CommonFoundation isEmptyString:_smsCode]){
        errorString = @"请输入短信验证码";
    }
    
    if (errorString) {
        [self showMessageWithThreeSecondAtCenter:errorString];
        return;
    }
    
    //验证短信码
    [self postAppendUriAction:SmsTokenAction withValue:_smsToken params:@"phone",_phone,@"code",_smsCode,@"type",@"regist",nil];
}

-(void)onRequestFinished:(HttpRequestAction)tag response:(Response *)response
{

    if (tag == SendSmsAction) {
        _smsToken = [response.data objectForKey:@"smsToken"];
    }else if (tag == SmsTokenAction){
        //发送注册请求
        if (self.fromType == AcountTypeXiCi) {
            //西祠账号完善信息
            [self postActionWithHUD:LoginPerfectinfoAction params:@"phone",_phone,@"password",_pwd,@"username",_username,@"token",response.data[@"token"],@"uid",self.xiciInfo[@"uid"],@"type",@"xici",nil];
        }else{
            [self postActionWithHUD:UserRegisterAction params:@"phone",_phone,@"password",_pwd,@"username",_username,@"token",response.data[@"token"],nil];
        }
    }else if ((tag == UserRegisterAction) || (tag == LoginPerfectinfoAction)){
        //返回用户信息
        APPInfo *infoObj = [APPInfo shareInit];
        //保存token
        [CacheBox saveCache:CACHE_TOKEN value:response.token];
        //赋值更新用户信息
        [infoObj updateUserInfo:response.data];
        [self dismissNavigationView:YES];
    }
}
@end
