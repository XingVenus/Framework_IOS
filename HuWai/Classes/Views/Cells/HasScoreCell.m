//
//  hasScoreCell.m
//  HuWai
//
//  Created by WmVenusMac on 15-2-2.
//  Copyright (c) 2015年 xici. All rights reserved.
//

#import "HasScoreCell.h"

@implementation HasScoreCell

-(void)baseSetup
{
    self.backgroundColor = RGBA(242, 242, 243, 1);
    self.contentView.backgroundColor = RGBA(242, 242, 243, 1);
    [self.contentView addSubview:self.hasScoreBackView];
    [self.hasScoreBackView addSubview:self.titleLabel];
    [self.hasScoreBackView addSubview:self.subTitleLabel];
    [self.hasScoreBackView addSubview:self.describeLabel];
    [self.hasScoreBackView addSubview:self.scoreLabel];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.contentView.frame = CGRectInset(self.bounds, 0, 5);
}

-(HasScoreCellView *)hasScoreBackView
{
    if (!_hasScoreBackView) {
        _hasScoreBackView = [[HasScoreCellView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 120)];
        _hasScoreBackView.backgroundColor = [UIColor whiteColor];
    }
    return _hasScoreBackView;
}

-(UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, 100, 21)];
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.font = [UIFont boldSystemFontOfSize:16.0];
        
    }
    return _titleLabel;
}

-(UILabel *)subTitleLabel
{
    if (!_subTitleLabel) {
        _subTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 150, 10, 135, 21)];
        _subTitleLabel.backgroundColor = [UIColor clearColor];
        _subTitleLabel.textAlignment = NSTextAlignmentRight;
        _subTitleLabel.font = [UIFont systemFontOfSize:14.0];
        _subTitleLabel.textColor = [UIColor lightGrayColor];
        
    }
    return _subTitleLabel;
}

-(RTLabel *)describeLabel
{
    if (!_describeLabel) {
        _describeLabel = [[RTLabel alloc] initWithFrame:CGRectMake(15, 60, SCREEN_WIDTH - 100, 50)];
        _describeLabel.backgroundColor = [UIColor clearColor];
        _describeLabel.lineSpacing = 8;
        _describeLabel.font = [UIFont systemFontOfSize:14.0];
        _describeLabel.textColor = [UIColor darkGrayColor];
    }
    return _describeLabel;
}

-(UILabel *)scoreLabel
{
    if (!_scoreLabel) {
        _scoreLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 60, CGRectGetMinY(self.describeLabel.frame)+5, 60, 30)];
        
    }
    return _scoreLabel;
}

-(void)configureCellWithItem:(id)item atIndexPath:(NSIndexPath *)indexPath
{
    self.titleLabel.text = @"已打分";
    self.subTitleLabel.text = @"adfasdfadf";
    self.describeLabel.text = @"要在应用启动器中快速找到某个应用，请在搜索框中输入该应用的名称。借助搜索框，您也可在Chrome网上应用店中查找更多应用，还可执行常规的Google搜索操作。";
    self.scoreLabel.text = @"4.88分";
}

@end

@implementation HasScoreCellView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(context, [UIColor grayColor].CGColor);
    CGContextSetLineWidth(context, 0.3);
    
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, 0, 0);
    CGContextAddLineToPoint(context, self.bounds.size.width, 0);
    
    CGContextMoveToPoint(context, 0, 40);
    CGContextAddLineToPoint(context, self.bounds.size.width, 40);
    
    CGContextMoveToPoint(context, 0, self.bounds.size.height);
    CGContextAddLineToPoint(context, self.bounds.size.width, self.bounds.size.height);
    CGContextClosePath(context);
    CGContextStrokePath(context);
    
}

@end
