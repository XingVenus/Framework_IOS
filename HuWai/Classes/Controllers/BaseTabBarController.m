//
//  BaseTabBarController.m
//  HuWai
//
//  Created by WmVenusMac on 15-1-19.
//  Copyright (c) 2015年 xici. All rights reserved.
//

#import "BaseTabBarController.h"

@interface BaseTabBarController ()<UITabBarDelegate>

@end

@implementation BaseTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBarController.tabBar.delegate = self;
    //--------设置选中时的图片颜色tintColor-------
    if (NSFoundationVersionNumber >= NSFoundationVersionNumber_iOS_7_0) {
        [UITabBar appearance].tintColor = RGBA(46, 181, 220, 1);
        [UITabBar appearance].barTintColor = [UIColor whiteColor];
    }
    
//    self.tabBarController.tabBar.backgroundColor = [UIColor greenColor];
    //设置选中tab的文字的颜色,默认为tintcolor的颜色一致
//    [[UITabBarItem appearance] setTitleTextAttributes:@{UITextAttributeTextColor : RGBA(46, 181, 220, 1)} forState:UIControlStateSelected];
    // Do any additional setup after loading the view.
    /*
    //-------badgeValue-------
     //设置指定的tabbaritem的badgeValue
    UITabBarItem *item = [self.tabBar.items objectAtIndex:1];
    item.badgeValue = @"44";
     //在某个对应的viewcontroller中使用下面的方法设置badgeValue
     self.tabBarController.tabBar.selectedItem.badgeValue = @"11";
     或者
     [[self navigationController] tabBarItem].badgeValue = @"11";
     或者
     [[[[[self tabBarController] tabBar] items]
     objectAtIndex:1] setBadgeValue:@"12"];
     */

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
{
//    if (item.tag == 0) {
//        //消除全屏动画的影响
//        [[NSNotificationCenter defaultCenter] postNotificationName:@"hideNavBarWithNoAnimate" object:nil];
//    }
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma mark - View rotation

- (BOOL)shouldAutorotate {
    return NO;
}

- (NSUInteger)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return UIInterfaceOrientationPortrait;
}
@end
