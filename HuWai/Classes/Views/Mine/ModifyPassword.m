//
//  ModifyPassword.m
//  HuWai
//
//  Created by WmVenusMac on 15-1-26.
//  Copyright (c) 2015年 xici. All rights reserved.
//

#import "ModifyPassword.h"

@interface ModifyPassword ()
@property (weak, nonatomic) IBOutlet UITextField *firstPassword;
@property (weak, nonatomic) IBOutlet UITextField *secondPassword;
- (IBAction)submitPassword:(UIBarButtonItem *)sender;

@end

@implementation ModifyPassword

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [MobClick beginLogPageView:self.title];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:self.title];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)submitPassword:(UIBarButtonItem *)sender {
    NSString *message = nil;
    NSString *firstP = [CommonFoundation trimString:self.firstPassword.text];
    NSString *secondP = [CommonFoundation trimString:self.secondPassword.text];
    if ([CommonFoundation isEmptyString:firstP] || [CommonFoundation isEmptyString:secondP]) {
        message = @"密码信息不能为空";
    }else if(![firstP isEqualToString:secondP]){
        message = @"两次密码不一致,请重新输入";
    }
    
    if (!message) {
        //提交
        [self postActionWithHUD:ModifyPasswordAction params:@"password",secondP,nil];
    }else{
        [self showMessageWithThreeSecondAtCenter:message afterDelay:1];
    }
}

-(void)onRequestFinished:(HttpRequestAction)tag response:(Response *)response
{
    if (tag == ModifyPasswordAction) {
        BaseNavigationController *loginNav = [self.storyboard instantiateViewControllerWithIdentifier:@"loginNavBoard"];
        [self.navigationController presentViewController:loginNav animated:YES completion:^{
            [self.navigationController performSelector:@selector(popToRootViewControllerAnimated:) withObject:nil];
        }];
    }
}
@end
