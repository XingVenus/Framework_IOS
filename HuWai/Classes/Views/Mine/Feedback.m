//
//  Feedback.m
//  HuWai
//
//  Created by WmVenusMac on 15-2-3.
//  Copyright (c) 2015年 xici. All rights reserved.
//

#import "Feedback.h"

@interface Feedback ()

@end

@implementation Feedback

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.feedBackTextView.placeholder = @"欢迎您在这里吐槽";
    self.feedBackTextView.layer.cornerRadius = 5.0;
    self.feedBackTextView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.feedBackTextView.layer.borderWidth = 0.5;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)submitFeedBack:(id)sender
{
    NSString *content = [CommonFoundation trimString:self.feedBackTextView.text];
    if (![CommonFoundation isEmptyString:content] && [APPInfo shareInit].uid) {
        [self postActionWithHUD:FeedbackAction params:@"type",@"ios",@"content",content,@"uid",[APPInfo shareInit].uid,@"username",[APPInfo shareInit].username,nil];
    }
}

-(void)onRequestFinished:(HttpRequestAction)tag response:(Response *)response
{
    if (tag == FeedbackAction) {
        [self.view endEditing:YES];
        [self performSelector:@selector(popToLastView:) withObject:nil afterDelay:1.5];
    }
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
