//
//  LaunchView.h
//  HuWai
//
//  Created by WmVenusMac on 15-3-10.
//  Copyright (c) 2015年 xici. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LaunchView : UIView<UIScrollViewDelegate>
@property (strong, nonatomic) UIScrollView *scrollView;

/**
 *  图片名称数组 xx.jpg xx.png
 */
@property (nonatomic, strong) UIButton *skipBtn;
@property (nonatomic, assign) BOOL isSkipBtn;
-(void)fillDataWithImagesArray:(NSArray *)imgArray;
@end
