//
//  hasScoreCell.m
//  HuWai
//
//  Created by WmVenusMac on 15-2-2.
//  Copyright (c) 2015年 xici. All rights reserved.
//

#import "HasScoreCell.h"
#import "ScoreListModel.h"

@implementation HasScoreCell

-(void)drawRect:(CGRect)rect
{
    CALayer *secondLayer = [CALayer layer];
    secondLayer.frame = CGRectMake(0, 40, SCREEN_WIDTH, 0.5);
    secondLayer.backgroundColor = [UIColor lightGrayColor].CGColor;
    [self.contentView.layer addSublayer:secondLayer];
}

-(void)baseSetup
{
//    [self.contentView addSubview:self.hasScoreBackView];
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.subTitleLabel];
    [self.contentView addSubview:self.describeLabel];
    [self.contentView addSubview:self.scoreLabel];
    
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
    [self setLayerLineAndBackground];
}

//-(HasScoreCellView *)hasScoreBackView
//{
//    if (!_hasScoreBackView) {
//        _hasScoreBackView = [[HasScoreCellView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 120)];
//        _hasScoreBackView.backgroundColor = [UIColor whiteColor];
//    }
//    return _hasScoreBackView;
//}

-(UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, 100, 21)];
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.font = [UIFont boldSystemFontOfSize:16.0];
        _titleLabel.text = @"已打分";
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

-(TTTAttributedLabel *)describeLabel
{
    if (!_describeLabel) {
        _describeLabel = [[TTTAttributedLabel alloc] initWithFrame:CGRectMake(15, 50, SCREEN_WIDTH - 100, 50)];
        _describeLabel.backgroundColor = [UIColor clearColor];
        _describeLabel.lineSpacing = 6;
        _describeLabel.numberOfLines = 0;
        _describeLabel.font = [UIFont systemFontOfSize:14.0];
        _describeLabel.textColor = [UIColor darkGrayColor];
    }
    return _describeLabel;
}

-(UILabel *)scoreLabel
{
    if (!_scoreLabel) {
        _scoreLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 60, 0, 60, 30)];
        _scoreLabel.centerY = CGRectGetMidY(self.describeLabel.frame);
    }
    return _scoreLabel;
}

-(void)configureCellWithItem:(id)item atIndexPath:(NSIndexPath *)indexPath
{
    ScoreInfo *data = (ScoreInfo *)item;
    self.subTitleLabel.text = [NSString stringWithFormat:@"领队:%@",data.leader];
    self.describeLabel.text = data.title;
    self.scoreLabel.text = data.score;
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
