//
//  Login.m
//  HuWai
//
//  Created by WmVenusMac on 15-1-19.
//  Copyright (c) 2015年 xici. All rights reserved.
//

#import "Login.h"

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
    NSMutableAttributedString *hyperLinkString = [[NSMutableAttributedString alloc] initWithString:self.forgetPasswordButton.titleLabel.text];
    [hyperLinkString addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInt:NSUnderlineStyleSingle] range:NSMakeRange(0, hyperLinkString.length)];
    [self.forgetPasswordButton setAttributedTitle:hyperLinkString forState:UIControlStateNormal];
    //注册下划线
    hyperLinkString = [[NSMutableAttributedString alloc] initWithString:self.registerButton.titleLabel.text];
    [hyperLinkString addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInt:NSUnderlineStyleSingle] range:NSMakeRange(0, hyperLinkString.length)];
    [self.registerButton setAttributedTitle:hyperLinkString forState:UIControlStateNormal];
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

@end
