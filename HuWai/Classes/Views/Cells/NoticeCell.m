//
//  NoticeCell.m
//  HuWai
//
//  Created by WmVenusMac on 15-3-24.
//  Copyright (c) 2015年 xici. All rights reserved.
//

#import "NoticeCell.h"
#import "NSString+RectSize.h"

@implementation NoticeCell
{
    CALayer *secondLayer;
}

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
    [self.contentView addSubview:self.contentLabel];
    [self.contentView addSubview:self.fromLabel];
    [self.contentView addSubview:self.timeLabel];
    //分割线
    if (!secondLayer) {
        secondLayer = [CALayer layer];
        secondLayer.backgroundColor = APP_DIVIDELINE_COLOR.CGColor;
        [self.contentView.layer addSublayer:secondLayer];
    }
}

-(TTTAttributedLabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[TTTAttributedLabel alloc] initWithFrame:CGRectMake(10, 5, SCREEN_WIDTH - 10*2, 0)];
        _titleLabel.numberOfLines = 0;
        _titleLabel.lineSpacing = 4.0;
        _titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
        _titleLabel.font = [UIFont systemFontOfSize:15.0];
    }
    return _titleLabel;
}

-(TTTAttributedLabel *)contentLabel
{
    if (!_contentLabel) {
        _contentLabel = [[TTTAttributedLabel alloc] initWithFrame:CGRectMake(10, 0, SCREEN_WIDTH - 10*2, 0)];
        _contentLabel.numberOfLines = 0;
        _contentLabel.lineSpacing = 4.0;
        _contentLabel.textColor = [UIColor lightGrayColor];
        _contentLabel.lineBreakMode = NSLineBreakByWordWrapping;
        _contentLabel.font = [UIFont systemFontOfSize:14.0];
    }
    return _contentLabel;
}

-(UILabel *)fromLabel
{
    if (!_fromLabel) {
        _fromLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 150, 24)];
        _fromLabel.textColor = [UIColor darkGrayColor];
        _fromLabel.font = [UIFont systemFontOfSize:15.0];
        _fromLabel.text = @"来自: 小秘书";
    }
    return _fromLabel;
}

-(UILabel *)timeLabel
{
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 160, 0, 150, 24)];
        _timeLabel.font = [UIFont systemFontOfSize:14.0];
        _timeLabel.textColor = [UIColor lightGrayColor];
    }
    return _timeLabel;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.contentView.frame = CGRectInset(self.bounds, 0, 5);
    [self setLayerLineAndBackground];
    //
    secondLayer.frame = CGRectMake(0, CGRectGetMaxY(self.titleLabel.frame)+5, SCREEN_WIDTH, 0.5);
    //消息位置
    self.contentLabel.top = CGRectGetMaxY(self.titleLabel.frame) + 10;
    self.fromLabel.top = CGRectGetMaxY(self.contentLabel.frame) + 5;
    self.timeLabel.top = CGRectGetMaxY(self.contentLabel.frame) + 5;
    [self setNeedsDisplay];
}
#pragma mark 数据填充
-(void)configureCellWithItem:(id)item atIndexPath:(NSIndexPath *)indexPath
{
    MessageInfo *data = (MessageInfo *)item;
    self.titleLabel.text = data.title;
    self.titleLabel.height = [data.title stringRectSizeWithfontSize:15.0 andWidth:AvalibleWidth withLineSpacing:4].height;
    self.contentLabel.text = data.message;
    self.contentLabel.height = [data.message stringRectSizeWithfontSize:14.0 andWidth:AvalibleWidth withLineSpacing:4.0].height;
    self.timeLabel.text = data.time;
}

+ (CGFloat)heightForCellWithText:(MessageInfo *)item availableWidth:(CGFloat)availableWidth
{
    CGFloat height = 0;
    CGFloat titleHeight = [item.title stringRectSizeWithfontSize:15.0 andWidth:availableWidth withLineSpacing:4.0].height;
    CGFloat contentHeight = [item.message stringRectSizeWithfontSize:14.0 andWidth:availableWidth withLineSpacing:4.0].height;
    height = titleHeight + contentHeight;
    return height;
}
@end
