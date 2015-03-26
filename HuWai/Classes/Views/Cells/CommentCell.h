//
//  CommentCell.h
//  HuWai
//
//  Created by WmVenusMac on 15-3-24.
//  Copyright (c) 2015年 xici. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "UserMessageModel.h"

@interface CommentCell : BaseTableViewCell
@property (nonatomic, strong) TTTAttributedLabel *titleLabel;
@property (nonatomic, strong) UIView *userBackView;
@property (nonatomic, strong) UIImageView *userIcon;
@property (nonatomic, strong) UILabel  *userNameLabel;
@property (nonatomic, strong) TTTAttributedLabel *userQuestionLabel;

@property (nonatomic, strong) UIView *leaderBackView;
@property (nonatomic, strong) UIImageView *leaderIcon;
@property (nonatomic, strong) UILabel *leaderNameLabel;
@property (nonatomic, strong) TTTAttributedLabel *leaderAnswer;

@property (nonatomic, strong) UILabel *timeLabel;

+ (CGFloat)heightForCellWithText:(MessageInfo *)item availableWidth:(CGFloat)availableWidth;
@end
