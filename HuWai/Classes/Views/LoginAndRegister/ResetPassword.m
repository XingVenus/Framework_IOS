//
//  ResetPassword.m
//  HuWai
//
//  Created by WmVenusMac on 15-1-23.
//  Copyright (c) 2015年 xici. All rights reserved.
//

#import "ResetPassword.h"

@interface ResetPassword ()

@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UITextField *confirmField;

- (IBAction)submitNewPassword:(id)sender;

@end

@implementation ResetPassword

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

- (IBAction)submitNewPassword:(id)sender {
    NSString *errorMessage;
    if ([CommonFoundation isEmptyString:self.passwordField.text] || [CommonFoundation isEmptyString:self.confirmField.text]) {
        errorMessage = @"密码不能为空";
    }else if (![self.passwordField.text isEqualToString:self.confirmField.text]){
        errorMessage = @"两次输入的密码不正确";
    }
    [self showMessageWithThreeSecondAtCenter:errorMessage afterDelay:1];
    if (_resetToken && _phoneNumber) {
        [self postActionWithHUD:ResetpasswordAction params:@"phone",_phoneNumber,@"password",[CommonFoundation trimString:self.confirmField.text],@"verify_token",_resetToken,nil];
    }
}

-(void)onRequestFinished:(HttpRequestAction)tag response:(Response *)response
{
    
}
#pragma mark 隐藏键盘
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}
@end
