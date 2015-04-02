//
//  BaseNavigationController.m
//  Sanbao
//
//  Created by WmVenusMac on 14-6-16.
//  Copyright (c) 2014年 venus. All rights reserved.
//

#import "BaseNavigationController.h"
#import "UIColor+Hex.h"

@interface BaseNavigationController ()

@end

@implementation BaseNavigationController

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleDefault;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
//    [[UINavigationBar appearance] setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
//    [[UINavigationBar appearance] setShadowImage:[[UIImage alloc] init]];
/*
    [[UINavigationBar appearance] setShadowImage:[UIImage imageNamed:@"2pxWidthLineImage"]];
     */
    // Do any additional setup after loading the view.
    if (NSFoundationVersionNumber >= NSFoundationVersionNumber_iOS_7_0) {
        [[UINavigationBar appearance] setBarTintColor:[UIColor colorFromHexString:@"#21b5de"]];//整个背景[UIColor colorFromHexString:@"#29B5D8"]
        [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];//RGBA(46, 181, 220, 1)];//item字体颜色RGBA(54, 178, 214, 1)
    }
    else {
        [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    }
//
    [[UINavigationBar appearance] setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName, [UIFont systemFontOfSize:18], NSFontAttributeName, nil]];
    //item字体颜色  在ios6中是背景色
//    [[UINavigationBar appearance] setTintColor:RGBA(46, 181, 220, 1)];
//    if (NSFoundationVersionNumber>=NSFoundationVersionNumber_iOS_7_0) {
//        self.navigationBar.tintColor = [UIColor colorWithWhite:.2 alpha:1];
//    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.viewControllers.count) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}

#pragma mark - View rotation

- (BOOL)shouldAutorotate {
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return UIInterfaceOrientationPortrait;
}

@end
