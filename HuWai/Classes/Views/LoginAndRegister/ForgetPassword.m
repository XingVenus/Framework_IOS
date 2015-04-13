//
//  ForgetPassword.m
//  HuWai
//
//  Created by WmVenusMac on 15-1-21.
//  Copyright (c) 2015年 xici. All rights reserved.
//

#import "ForgetPassword.h"
#import "ResetPassword.h"

@interface ForgetPassword ()
{
    NSString *_smsToken;
    NSString *_token;
}
@property (weak, nonatomic) IBOutlet UITextField *phoneNumber;
@property (weak, nonatomic) IBOutlet UITextField *textCode;

- (IBAction)getTextCodeAction:(id)sender;
- (IBAction)toResetPassword:(id)sender;

@end

@implementation ForgetPassword

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    ResetPassword *destController = [segue destinationViewController];
    destController.phoneNumber = [CommonFoundation trimString:self.phoneNumber.text];
    destController.resetToken = _token;
}


- (IBAction)getTextCodeAction:(id)sender {
    if (![CommonFoundation checkPhoneNo:self.phoneNumber.text]) {
        [self showMessageWithThreeSecondAtCenter:@"手机号码格式不正确" afterDelay:1];
        return;
    }
    [self postActionWithHUD:SendSmsAction params:@"phone",[CommonFoundation trimString:self.phoneNumber.text],@"type",@"lostpasswd",nil];
}

- (IBAction)toResetPassword:(id)sender {
    [MobClick event:@"wjmm"];
    if (!_smsToken || !_token || [CommonFoundation isEmptyString:self.phoneNumber.text] || [CommonFoundation isEmptyString:self.textCode.text]) {
        [self showMessageWithThreeSecondAtCenter:@"信息不完整，不能继续" afterDelay:1];
    }else{
        [self postAppendUriActionWithHUD:SmsTokenAction withValue:_smsToken params:@"phone",[CommonFoundation trimString:self.phoneNumber.text],@"code",[CommonFoundation trimString:self.textCode.text],@"type",@"lostpasswd",nil];
    }
}

-(void)onRequestFinished:(HttpRequestAction)tag response:(Response *)response
{
    if (tag == SendSmsAction) {
        _smsToken = [response.data objectForKey:@"smsToken"];
    }else if (tag == SmsTokenAction){
        _token = [response.data objectForKey:@"token"];
        [self performSegueWithIdentifier:@"resetpassword" sender:self];
    }

}
@end
