//
//  FAQ.m
//  HuWai
//
//  Created by WmVenusMac on 15-3-25.
//  Copyright (c) 2015年 xici. All rights reserved.
//

#import "FAQ.h"

@interface FAQ ()

@end

@implementation FAQ

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.textView.placeholder = @"关于这个活动的提问";
    self.textView.layer.cornerRadius = 5.0;
    self.textView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.textView.layer.borderWidth = 0.5;
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

- (void)viewDidUnload
{
    [super viewDidUnload];
    [self setTextView:nil];
}

-(void)submitFAQ:(id)sender
{
    [self.textView resignFirstResponder];
    NSString *contentText = [CommonFoundation trimString:self.textView.text];
    if (self.actID && ![CommonFoundation isEmptyString:contentText]) {
        [self postActionWithHUD:ActivityAskAction params:@"id",self.actID,@"content",contentText,nil];
    }else{
        [self showMessageWithThreeSecondAtCenter:@"请填写提问内容" afterDelay:1];
    }
}

-(void)onRequestFinished:(HttpRequestAction)tag response:(Response *)response
{
    if (tag == ActivityAskAction) {
        if (_delegate && [_delegate respondsToSelector:@selector(didSubmitFAQ)]) {
            [_delegate didSubmitFAQ];
        }
        [self performSelector:@selector(popToLastView:) withObject:nil afterDelay:1];
    }
}
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

@end
