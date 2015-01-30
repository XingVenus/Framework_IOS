//
//  BaseNavigationController.m
//  Sanbao
//
//  Created by WmVenusMac on 14-6-16.
//  Copyright (c) 2014年 venus. All rights reserved.
//

#import "BaseNavigationController.h"

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
//    if (floor(NSFoundationVersionNumber) >= 7.0) {
//        [[UINavigationBar appearance] setBarTintColor:RGBA(87, 196, 211, 1)];
//        [[UINavigationBar appearance] setTintColor:[UIColor grayColor]];
//    } else {
//        [[UINavigationBar appearance] setTintColor:RGBA(87, 196, 211, 1)];
//    }
//
//    [[UINavigationBar appearance] setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName, [UIFont boldSystemFontOfSize:18], NSFontAttributeName, nil]];
    if (floor(NSFoundationVersionNumber)>=7.0) {
        self.navigationBar.tintColor = [UIColor colorWithWhite:.2 alpha:1];
    }
    
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
