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
    UITabBar *tabBar = self.tabBar;
    UITabBarItem *item0 = [tabBar.items objectAtIndex:0];
    UITabBarItem *item1 = [tabBar.items objectAtIndex:1];
    UITabBarItem *item2 = [tabBar.items objectAtIndex:2];
    UIImage *play_b = [UIImage imageNamed:@"play-blue"];
    UIImage *play_g = [UIImage imageNamed:@"play-gray"];
    UIImage *circle_b = [UIImage imageNamed:@"circle-b"];
    UIImage *circle_g = [UIImage imageNamed:@"circle-g"];
    UIImage *my_b = [UIImage imageNamed:@"my-blue"];
    UIImage *my_g = [UIImage imageNamed:@"my-gray"];
    //--------设置选中时的图片颜色tintColor-------
    if (NSFoundationVersionNumber >= NSFoundationVersionNumber_iOS_7_0) {
        [UITabBar appearance].tintColor = RGBA(46, 181, 220, 1);
        [UITabBar appearance].barTintColor = [UIColor whiteColor];
        // 对item设置相应地图片
        item0.selectedImage = [play_b imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];;
        item0.image = [play_g imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        item1.selectedImage = [circle_b imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];;
        item1.image = [circle_g imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        item2.selectedImage = [my_b imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];;
        item2.image = [my_g imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }else{
        [item0 setFinishedSelectedImage:play_b withFinishedUnselectedImage:play_g];
        [item1 setFinishedSelectedImage:circle_b withFinishedUnselectedImage:circle_g];
        [item2 setFinishedSelectedImage:my_b withFinishedUnselectedImage:my_g];
    }
//    DLog(@"%lu",(unsigned long)self.tabBar.items.count);
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
    if (item.tag == 0) {
        [MobClick event:@"s_cqw"];
    }else if (item.tag == 1){
        [MobClick event:@"s_qz"];
    }else{
        [MobClick event:@"s_wd"];
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
