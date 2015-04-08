//
//  CommentCell.m
//  HuWai
//
//  Created by WmVenusMac on 15-3-24.
//  Copyright (c) 2015年 xici. All rights reserved.
//

#import "CommentCell.h"
#import "NSString+RectSize.h"

@implementation CommentCell

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)baseSetup
{
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.userBackView];
    [self.userBackView addSubview:self.userIcon];
    [self.userBackView addSubview:self.userNameLabel];
    [self.userBackView addSubview:self.userQuestionLabel];
    [self.contentView addSubview:self.leaderBackView];
    [self.leaderBackView addSubview:self.leaderIcon];
    [self.leaderBackView addSubview:self.leaderNameLabel];
    [self.leaderBackView addSubview:self.leaderAnswer];
    [self.contentView addSubview:self.timeLabel];
}

+(CGFloat)heightForCellWithText:(id)item availableWidth:(CGFloat)availableWidth
{
    MessageInfo *info = (MessageInfo *)item;
    CGFloat totalHeight = 0;
    CGFloat titleHeight = [info.title stringRectSizeWithfontSize:15.0 andWidth:SCREEN_WIDTH - 10*2 withLineSpacing:4.0].height;
    totalHeight += titleHeight;
    CGFloat fromHeight = [info.from_content stringRectSizeWithfontSize:14.0 andWidth:SCREEN_WIDTH -10*2 -5-5-5-50 withLineSpacing:4.0].height;
    
    if (fromHeight>28) {
        totalHeight += fromHeight;
    }else{
        totalHeight += 28;
    }
    CGFloat replyHeight = [info.reply_content stringRectSizeWithfontSize:14.0 andWidth:SCREEN_WIDTH -10*2 -5-5-5-50 withLineSpacing:4.0].height;
    if (replyHeight>28) {
        totalHeight += replyHeight;
    }else{
        totalHeight += 28;
    }
    return totalHeight+110;
}

-(void)configureCellWithItem:(id)item atIndexPath:(NSIndexPath *)indexPath
{
    MessageInfo *info = (MessageInfo *)item;
    self.titleLabel.text = info.title;
    self.titleLabel.height = [info.title stringRectSizeWithfontSize:15.0 andWidth:SCREEN_WIDTH - 10*2 withLineSpacing:4.0].height;
    [self.userIcon sd_setImageWithURL:[NSURL URLWithString:info.from_avatar] placeholderImage:nil];
    self.userNameLabel.text = info.from_username;
    self.userQuestionLabel.text = info.from_content;
    CGFloat fromHeight = [info.from_content stringRectSizeWithfontSize:14.0 andWidth:CGRectGetWidth(self.userBackView.frame)-5-5-5-50 withLineSpacing:4.0].height;
    if (fromHeight>28) {
        self.userQuestionLabel.height = fromHeight;
    }else{
        self.userQuestionLabel.height = 28;
    }
    [self.leaderIcon sd_setImageWithURL:[NSURL URLWithString:info.reply_avatar] placeholderImage:nil];
    self.leaderNameLabel.text = info.reply_username;
    self.leaderAnswer.text = info.reply_content;
    CGFloat replyHeight = [info.reply_content stringRectSizeWithfontSize:14.0 andWidth:CGRectGetWidth(self.leaderBackView.frame) - 50-5-5-5 withLineSpacing:4.0].height;
    if (replyHeight>28) {
        self.leaderAnswer.height = replyHeight;
    }else{
        self.leaderAnswer.height = 28;
    }
    self.timeLabel.text = info.reply_time;
    
    self.userBackView.height = 10 + 20 +2 +self.userQuestionLabel.height;
    self.leaderBackView.height = 10 + 20 + 2 + self.leaderAnswer.height;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.contentView.frame = CGRectInset(self.bounds, 0, 5);
    [self setLayerLineAndBackground];
    
    self.userBackView.top = CGRectGetMaxY(self.titleLabel.frame) + 5;
    self.leaderBackView.top = CGRectGetMaxY(self.userBackView.frame) + 5;
    self.timeLabel.top = CGRectGetMaxY(self.leaderBackView.frame) + 5;
    
    [self setNeedsDisplay];
}

-(TTTAttributedLabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[TTTAttributedLabel alloc] initWithFrame:CGRectMake(10, 6, SCREEN_WIDTH - 10*2, 0)];
        _titleLabel.numberOfLines = 0;
        _titleLabel.lineSpacing = 4.0;
        _titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
        _titleLabel.font = [UIFont systemFontOfSize:15.0];
    }
    return _titleLabel;
}

-(UIView *)userBackView
{
    if (!_userBackView) {
        _userBackView = [[UIView alloc] initWithFrame:CGRectMake(10, 0, SCREEN_WIDTH - 10*2, 60)];
//        _userBackView.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.6];
    }
    return _userBackView;
}
-(UIImageView *)userIcon
{
    if (!_userIcon) {
        _userIcon = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.userBackView.frame) - 55, 5, 50, 50)];
        _userIcon.contentMode = UIViewContentModeScaleAspectFill;
        _userIcon.clipsToBounds = YES;
    }
    return _userIcon;
}

-(UILabel *)userNameLabel
{
    if (!_userNameLabel) {
        _userNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.userBackView.frame) - 60 - 180, 5, 180, 20)];
        _userNameLabel.textAlignment = NSTextAlignmentRight;
        _userNameLabel.font = [UIFont systemFontOfSize:15.0];
    }
    return _userNameLabel;
}

-(TTTAttributedLabel *)userQuestionLabel
{
    if (!_userQuestionLabel) {
        _userQuestionLabel = [[TTTAttributedLabel alloc] initWithFrame:CGRectMake(5, CGRectGetMaxY(self.userNameLabel.frame)+2, CGRectGetWidth(self.userBackView.frame) - 5-5-5-50, 28)];
        _userQuestionLabel.numberOfLines = 0;
        _userQuestionLabel.lineSpacing = 4.0;
        _userQuestionLabel.textColor = [UIColor grayColor];
        _userQuestionLabel.lineBreakMode = NSLineBreakByWordWrapping;
        _userQuestionLabel.font = [UIFont systemFontOfSize:14.0];
    }
    return _userQuestionLabel;
}

-(UIView *)leaderBackView
{
    if (!_leaderBackView) {
        _leaderBackView = [[UIView alloc] initWithFrame:CGRectMake(10, 0, SCREEN_WIDTH - 10*2, 60)];
        _leaderBackView.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.2];
    }
    return _leaderBackView;
}

-(UIImageView *)leaderIcon
{
    if (!_leaderIcon) {
        _leaderIcon = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 50, 50)];
        _leaderIcon.contentMode = UIViewContentModeScaleAspectFill;
        _leaderIcon.clipsToBounds = YES;
    }
    return _leaderIcon;
}

-(UILabel *)leaderNameLabel
{
    if (!_leaderNameLabel) {
        _leaderNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.leaderIcon.frame)+5, 5, 180, 20)];
        _leaderNameLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _leaderNameLabel;
}

-(TTTAttributedLabel *)leaderAnswer
{
    if (!_leaderAnswer) {
        _leaderAnswer = [[TTTAttributedLabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.leaderIcon.frame)+5, CGRectGetMaxY(self.leaderNameLabel.frame)+2, CGRectGetWidth(self.leaderBackView.frame) - 50-5-5-5, 28)];
        _leaderAnswer.numberOfLines = 0;
        _leaderAnswer.lineSpacing = 4.0;
        _leaderAnswer.textColor = [UIColor grayColor];
        _leaderAnswer.lineBreakMode = NSLineBreakByWordWrapping;
        _leaderAnswer.font = [UIFont systemFontOfSize:14.0];
    }
    return _leaderAnswer;
}

-(UILabel *)timeLabel
{
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 160, 0, 150, 20)];
        _timeLabel.font = [UIFont systemFontOfSize:14.0];
        _timeLabel.textColor = [UIColor lightGrayColor];
        _timeLabel.textAlignment = NSTextAlignmentRight;
    }
    return _timeLabel;
}
@end
