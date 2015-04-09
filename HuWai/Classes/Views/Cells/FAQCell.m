//
//  FAQCell.m
//  HuWai
//
//  Created by WmVenusMac on 15-3-25.
//  Copyright (c) 2015年 xici. All rights reserved.
//

#import "FAQCell.h"
#import "FAQModel.h"
#import "NSString+RectSize.h"
@implementation FAQCell

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(void)baseSetup
{
    [self.contentView addSubview:self.avatarView];
    [self.contentView addSubview:self.usernameLabel];
    [self.contentView addSubview:self.userTimeLabel];
    [self.contentView addSubview:self.userContentLabel];
    [self.contentView addSubview:self.replyBackView];
    [self.replyBackView addSubview:self.replyContentLabel];
    [self.replyBackView addSubview:self.replyTimeLabel];
}

-(PAAImageView *)avatarView
{
    if (!_avatarView) {
        _avatarView = [[PAAImageView alloc] initWithFrame:CGRectMake(15, 15 , 50, 50) backgroundProgressColor:[UIColor whiteColor] progressColor:[UIColor whiteColor]];
    }
    return _avatarView;
}

-(UILabel *)usernameLabel
{
    if (!_usernameLabel) {
        _usernameLabel = [[UILabel alloc] initWithFrame:CGRectMake(80, 10, 180, 20)];
        _usernameLabel.textColor = [UIColor darkGrayColor];
        _usernameLabel.font = [UIFont systemFontOfSize:15.0];
    }
    return _usernameLabel;
}

-(UILabel *)userTimeLabel
{
    if (!_userTimeLabel) {
        _userTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 160, 10, 150, 20)];
        _userTimeLabel.font = [UIFont systemFontOfSize:14.0];
        _userTimeLabel.textColor = [UIColor lightGrayColor];
        _userTimeLabel.textAlignment = NSTextAlignmentRight;
    }
    return _userTimeLabel;
}
#pragma mark should redefine height attribute
-(TTTAttributedLabel *)userContentLabel
{
    if (!_userContentLabel) {
        _userContentLabel = [[TTTAttributedLabel alloc] initWithFrame:CGRectMake(80, 10+20, SCREEN_WIDTH - 80 - 10, 0)];
        _userContentLabel.numberOfLines = 0;
        _userContentLabel.lineSpacing = 3.0;
        _userContentLabel.font = [UIFont systemFontOfSize:14.0];
        _userContentLabel.textColor = [UIColor lightGrayColor];
    }
    return _userContentLabel;
}
#pragma mark should redefine top and height attribute
-(UIView *)replyBackView
{
    if (!_replyBackView) {
        _replyBackView = [[UIView alloc] initWithFrame:CGRectMake(80, 0, SCREEN_WIDTH - 80 - 10, 0)];
        _replyBackView.backgroundColor = RGBA(254, 248, 224, 1);
    }
    return _replyBackView;
}

#pragma mark should redefine height attribute
-(TTTAttributedLabel *)replyContentLabel
{
    if (!_replyContentLabel) {
        _replyContentLabel = [[TTTAttributedLabel alloc] initWithFrame:CGRectMake(5, 5, self.replyBackView.width - 5*2, 0)];
        _replyContentLabel.numberOfLines = 0;
        _replyContentLabel.lineSpacing = 3.0;
        _replyContentLabel.font = [UIFont systemFontOfSize:14.0];
        _replyContentLabel.textColor = [UIColor lightGrayColor];
    }
    return _replyContentLabel;
}

#pragma mark should redefine top relative to replyBackView
-(UILabel *)replyTimeLabel
{
    if (!_replyTimeLabel) {
        _replyTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.replyBackView.width - 155, 0, 150, 20)];
        _replyTimeLabel.font = [UIFont systemFontOfSize:14.0];
        _replyTimeLabel.textColor = [UIColor lightGrayColor];
        _replyTimeLabel.textAlignment = NSTextAlignmentRight;
    }
    return _replyTimeLabel;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
//    self.contentView.frame = CGRectInset(self.bounds, 0, 5);
    [self setLayerLineAndBackground];
    
    self.replyBackView.top = CGRectGetMaxY(self.userContentLabel.frame) + 5;
    self.replyTimeLabel.top = CGRectGetMaxY(self.replyContentLabel.frame) + 5;
}

+(CGFloat)heightForCellWithText:(id)item availableWidth:(CGFloat)availableWidth
{
    FAQInfo *info = (FAQInfo *)item;
    CGFloat total = 0;
    CGFloat userContentHeight = [info.content stringRectSizeWithfontSize:14.0 andWidth:SCREEN_WIDTH - 80 -10 withLineSpacing:3.0].height;
    total = userContentHeight + 5 + 20;
    if (![CommonFoundation isEmptyString:info.reply]) {
        CGFloat replyContentHeight = [info.reply stringRectSizeWithfontSize:14.0 andWidth:SCREEN_WIDTH - 80 -10 -10 withLineSpacing:3.0].height;
        total = total + 5 + replyContentHeight + 5*3 + 20;
    }
    total += 10*2;
    if (total>80) {
        return total;
    }else{
        return 80;
    }
}

-(void)configureCellWithItem:(id)item atIndexPath:(NSIndexPath *)indexPath
{
    FAQInfo *info = (FAQInfo *)item;
    self.avatarView.placeHolderImage = [UIImage imageNamed:@"avatar"];
    [self.avatarView setImageURL:[NSURL URLWithString:info.avatar]];

    self.usernameLabel.text = info.username;
    self.userTimeLabel.text = info.time;
    self.userContentLabel.text = info.content;
    self.userContentLabel.height = [info.content stringRectSizeWithfontSize:14.0 andWidth:SCREEN_WIDTH - 80 -10 withLineSpacing:3.0].height;
    if (![CommonFoundation isEmptyString:info.reply]) {
        self.replyBackView.hidden = NO;
        self.replyContentLabel.text = info.reply;
        NSString *titleStr = [NSString stringWithFormat:@"领队回复:%@",info.reply];
        [self.replyContentLabel setText:titleStr afterInheritingLabelAttributesAndConfiguringWithBlock:^ NSMutableAttributedString *(NSMutableAttributedString *mutableAttributedString) {
            NSRange fontRange = [[mutableAttributedString string] rangeOfString:@"领队回复" options:NSCaseInsensitiveSearch];
            // Core Text APIs use C functions without a direct bridge to UIFont. See Apple's "Core Text Programming Guide" to learn how to configure string attributes.
            UIFont *boldSystemFont = [UIFont systemFontOfSize:14];
            CTFontRef font = CTFontCreateWithName((__bridge CFStringRef)boldSystemFont.fontName, boldSystemFont.pointSize, NULL);
            if (font) {
                [mutableAttributedString addAttribute:(NSString *)kCTFontAttributeName value:(__bridge id)font range:fontRange];
                [mutableAttributedString addAttribute:(NSString *)kCTForegroundColorAttributeName value:(__bridge id)[RGBA(78, 144, 207, 1) CGColor] range:fontRange];
                CFRelease(font);
            }
            
            return mutableAttributedString;
        }];
        
        self.replyContentLabel.height = [info.reply stringRectSizeWithfontSize:14.0 andWidth:SCREEN_WIDTH - 80 -10 -10 withLineSpacing:3.0].height;
        self.replyTimeLabel.text = info.reply_time;
        
        self.replyBackView.height = self.replyContentLabel.height + self.replyTimeLabel.height + 5*3;
    }else{
        self.replyBackView.hidden = YES;
    }
}
@end
