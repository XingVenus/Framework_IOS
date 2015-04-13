//
//  Loginxici.m
//  HuWai
//
//  Created by WmVenusMac on 15-3-20.
//  Copyright (c) 2015年 xici. All rights reserved.
//

#import "Loginxici.h"
#import "Register.h"

@interface Loginxici ()
{
    NSString *_acount;
    NSString *_pwd;
    NSDictionary *_xiciInfo;
}

@property (weak, nonatomic) IBOutlet UITextField *xiciAcount;
@property (weak, nonatomic) IBOutlet UITextField *xiciPwd;

- (IBAction)xiciLoginAction:(id)sender;

@end

@implementation Loginxici

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.view endEditing:YES];
}
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    Register *regView = segue.destinationViewController;
    if ([segue.identifier isEqualToString:@"xiciPerfect"]) {
        regView.title = @"完善信息";
        regView.fromType = AcountTypeXiCi;
        regView.xiciInfo = _xiciInfo;
        regView.xiciPwd = _pwd;
    }
}

- (IBAction)xiciLoginAction:(id)sender
{
    [MobClick event:@"xcdl"];
    _acount = [CommonFoundation trimString:self.xiciAcount.text];
    _pwd = [CommonFoundation trimString:self.xiciPwd.text];
    NSString *error = nil;
    if ([CommonFoundation isEmptyString:_acount]) {
        error = @"账号不能为空";
    }else if ([CommonFoundation isEmptyString:_pwd]){
        error = @"密码不能为空";
    }
    if (error) {
        [self showMessageWithThreeSecondAtCenter:error afterDelay:1];
    }else{
        [self postActionWithHUD:LoginXiciAction params:@"username",_acount,@"password",_pwd,nil];
    }
}

-(void)onRequestFinished:(HttpRequestAction)tag response:(Response *)response
{
    if (tag == LoginXiciAction) {
        if (response.token) {
            //＝＝＝直接跳转
            //返回用户信息
            APPInfo *infoObj = [APPInfo shareInit];
            //保存token
            [CacheBox saveCache:CACHE_TOKEN value:response.token];
            //赋值更新用户信息
            [infoObj updateUserInfo:response.data];
            [self dismissNavigationView:YES];
        }else{
            //完善信息
            _xiciInfo = response.data;
            [self performSegueWithIdentifier:@"xiciPerfect" sender:self];
        }
    }
}
@end
