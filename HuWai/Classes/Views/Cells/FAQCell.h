//
//  FAQCell.h
//  HuWai
//
//  Created by WmVenusMac on 15-3-25.
//  Copyright (c) 2015年 xici. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "PAAImageView.h"
@interface FAQCell : BaseTableViewCell

@property (nonatomic, strong) PAAImageView *avatarView;
@property (nonatomic, strong) UILabel *usernameLabel;
@property (nonatomic, strong) TTTAttributedLabel *userContentLabel;
@property (nonatomic, strong) UIView *replyBackView;
@property (nonatomic, strong) TTTAttributedLabel *replyContentLabel;
@property (nonatomic, strong) UILabel *userTimeLabel;
@property (nonatomic, strong) UILabel *replyTimeLabel;

+(CGFloat)heightForCellWithText:(id)item availableWidth:(CGFloat)availableWidth;
@end
