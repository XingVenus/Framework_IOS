//
//  UIButton+ButtonTitlePosition.h
//  HuWai
//  实现button中图片与文字同时出现时，不同位置显示的需要
//  Created by WmVenusMac on 15-1-20.
//  Copyright (c) 2015年 xici. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, ButtonTitlePostionType) {
    ButtonTitlePostionTypeBottom = 0,
    ButtonTitlePostionTypeLeft,
    ButtonTitlePostionTypeTop,
    ButtonTitlePostionTypeRight
};

@interface UIButton (ButtonTitlePosition)

- (void)setTitlePositionWithType:(ButtonTitlePostionType)type withSpacing:(CGFloat)space;

@end
