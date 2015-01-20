//
//  ViewController.m
//  HuWai
//
//  Created by WmVenusMac on 15-1-13.
//  Copyright (c) 2015年 xici. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self postAction:SendSmsAction params:@"13962122591",@"phone",@"regist",@"type",nil];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
