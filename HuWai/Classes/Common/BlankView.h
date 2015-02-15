//
//  BlankView.h
//  HuWai
//
//  Created by WmVenusMac on 15-2-6.
//  Copyright (c) 2015年 xici. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, ShowTitleType)
{
    ShowTitleBottom,
    ShowTitleRight,
};

@interface BlankView : UIView

@property (nonatomic, strong) UIImage *imageIcon;
@property (nonatomic, strong) NSString *textTitle;
@property (nonatomic) ShowTitleType showType;
@end
