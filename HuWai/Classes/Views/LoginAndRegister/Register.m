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
    if (![CommonFoundation stringisValidPhoneNo:self.phoneNumber.text]) {
        [self.view makeToast:@"请输入正确的手机号码" duration:2 position:CSToastPositionCenter];
    }
    
    [self postAction:SendSmsAction params:@"phone",[CommonFoundation trimString:self.phoneNumber.text],@"type",@"regist",nil];
}
#pragma mark 发起注册
- (IBAction)registerAction:(id)sender {
    NSString *errorString = nil;
    if (![CommonFoundation stringisValidPhoneNo:self.phoneNumber.text]) {
        errorString = @"请输入正确的手机号码";
    }else if ([CommonFoundation isEmptyString:self.password.text]){
        errorString = @"密码不能为空";
    }else if ([CommonFoundation isEmptyString:self.nickName.text]){
        errorString = @"请输入昵称";
    }else if ([CommonFoundation isEmptyString:self.textCode.text]){
        errorString = @"请输入短信验证码";
    }
    
    if (errorString) {
        [self.view makeToast:errorString duration:2 position:CSToastPositionCenter];
        return;
    }
    
    //验证短信码
    [self postAppendUriAction:SmsTokenAction withValue:_smsToken params:@"phone",[CommonFoundation trimString:self.phoneNumber.text],@"code",[CommonFoundation trimString:self.textCode.text],@"type",@"regist",nil];
}

-(void)onRequestFinished:(HttpRequestAction)tag response:(Response *)response
{
    if (response.code.intValue == 20000) {
        if (tag == SendSmsAction) {
            _smsToken = [response.data objectForKey:@"smsToken"];
        }else if (tag == SmsTokenAction){
            //发送注册请求
            [self postAction:UserRegisterAction params:@"phone",[CommonFoundation trimString:self.phoneNumber.text],@"password",[CommonFoundation trimString:self.password.text],@"username",[CommonFoundation trimString:self.nickName.text],@"token",response.data[@"token"],nil];
        }else if (tag == UserRegisterAction){
            //返回用户信息
        }
    }
    
    [self.view makeToast:response.message duration:2 position:CSToastPositionCenter];
}
@end
