//
//  ActivityCell.h
//  HuWai
//
//  Created by WmVenusMac on 15-1-27.
//  Copyright (c) 2015年 xici. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "PAAImageView.h"
#import "BaseTableViewCell.h"

#define kHeghtRatio     1.7

@interface ActivityCell : BaseTableViewCell

@property (strong, nonatomic) UIImageView *backImageView;
@property (strong, nonatomic) PAAImageView *avatarImageView;
@property (strong, nonatomic) UILabel *nickNameLabel;
@property (strong, nonatomic) TTTAttributedLabel *describeLabel;
@property (strong, nonatomic) UILabel *grayBackLabel;
@property (nonatomic, strong) UIButton *priceBtn;

@property (nonatomic, strong) CALayer *backLayer;

@end
