//
//  LoadHTMLView.m
//  HuWai
//
//  Created by WmVenusMac on 15-4-9.
//  Copyright (c) 2015年 xici. All rights reserved.
//

#import "LoadHTMLView.h"

@interface LoadHTMLView ()

@end

@implementation LoadHTMLView

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIView *contentView = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame]];
    contentView.autoresizesSubviews = YES;
    self.view = contentView;
    
    //set the web frame size
    CGRect webFrame = [[UIScreen mainScreen] applicationFrame];
    webFrame.origin.y = 0;
    
    //add the web view
    theWebView = [[UIWebView alloc] initWithFrame:webFrame];
    theWebView.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
    theWebView.scalesPageToFit = YES;
//    theWebView.delegate = self;
    
    NSURL *url = [NSURL URLWithString:self.urlString];
    NSURLRequest *req = [NSURLRequest requestWithURL:url];
    [theWebView loadRequest:req];
    
    [self.view addSubview: theWebView];
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

@end
