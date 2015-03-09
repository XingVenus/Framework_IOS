//
//  notScoreCell.m
//  HuWai
//
//  Created by WmVenusMac on 15-2-2.
//  Copyright (c) 2015年 xici. All rights reserved.
//

#import "NotScoreCell.h"
#import "ScoreListModel.h"

@implementation NotScoreCell

-(void)baseSetup
{
    
    self.contentView.layer.shouldRasterize = YES;
    self.contentView.layer.rasterizationScale = [[UIScreen mainScreen] scale];
    
    if (NSFoundationVersionNumber>NSFoundationVersionNumber_iOS_6_1) {
        self.backgroundColor = RGBA(242, 242, 242, 1);
    }else{
        self.backgroundView = [[UIView alloc] initWithFrame:self.bounds];
        self.backgroundView.backgroundColor = RGBA(242, 242, 242, 1);
    }
    self.contentView.backgroundColor = [UIColor whiteColor];
    
    
//    self.backgroundColor = RGBA(242, 242, 243, 1);
//    self.contentView.backgroundColor = RGBA(242, 242, 243, 1);
    [self.contentView addSubview:self.scoreBackView];
    [self.contentView addSubview:self.describeLabel];
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.subTitleLabel];
    [self.contentView addSubview:self.selectLabel1];
    [self.contentView addSubview:self.selectLabel2];
    [self.contentView addSubview:self.starControl1];
    [self.contentView addSubview:self.starControl2];
    [self.contentView addSubview:self.scoreButton];
}

//- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
//{
//    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
//    if (self) {
//        // Initialization code
//        
//    }
//    return self;
//}

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
    //打分按钮位置
    self.scoreButton.top = CGRectGetHeight(self.bounds) - 50 - 10;
    //添加分割线
    CALayer *topLayer = [CALayer layer];
    topLayer.frame = CGRectMake(0, 0, SCREEN_WIDTH, 0.5);
    topLayer.backgroundColor = [UIColor lightGrayColor].CGColor;
    CALayer *bottomLayer = [CALayer layer];
    bottomLayer.frame = CGRectMake(0, self.contentView.bounds.size.height, SCREEN_WIDTH, 0.5);
    bottomLayer.backgroundColor = [UIColor lightGrayColor].CGColor;
    [self.contentView.layer addSublayer:topLayer];
    [self.contentView.layer addSublayer:bottomLayer];
    
    CALayer *secondline = [CALayer layer];
    secondline.frame = CGRectMake(0, 40, SCREEN_WIDTH, 0.5);
    secondline.backgroundColor = [UIColor lightGrayColor].CGColor;
    [self.contentView.layer addSublayer:secondline];
}

//-(ScoreCellView *)scoreBackView
//{
//    if (!_scoreBackView) {
//        _scoreBackView = [[ScoreCellView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 220)];
//        _scoreBackView.backgroundColor = [UIColor whiteColor];
//    }
//    return _scoreBackView;
//}

-(UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, 100, 21)];
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.font = [UIFont boldSystemFontOfSize:16.0];
        _titleLabel.text = @"待打分";
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
        _describeLabel = [[TTTAttributedLabel alloc] initWithFrame:CGRectMake(15, 50, SCREEN_WIDTH - 15*2, 45)];
        _describeLabel.backgroundColor = [UIColor clearColor];
        _describeLabel.lineSpacing = 5;
        _describeLabel.numberOfLines = 0;
        _describeLabel.font = [UIFont systemFontOfSize:14.0];
        _describeLabel.textColor = [UIColor darkGrayColor];
    }
    return _describeLabel;
}

-(UILabel *)selectLabel1
{
    if (!_selectLabel1) {
        _selectLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(self.describeLabel.frame) + 10, 120, 21)];
        _selectLabel1.backgroundColor = [UIColor clearColor];
        _selectLabel1.font = [UIFont systemFontOfSize:14.0];
        _selectLabel1.textColor = [UIColor darkGrayColor];
        _selectLabel1.text = @"活动描述是否准确:";
    }
    return _selectLabel1;
}

-(UILabel *)selectLabel2
{
    if (!_selectLabel2) {
        _selectLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(self.describeLabel.frame) + 40, 120, 21)];
        _selectLabel2.backgroundColor = [UIColor clearColor];
        _selectLabel2.font = [UIFont systemFontOfSize:14.0];
        _selectLabel2.textColor = [UIColor darkGrayColor];
        _selectLabel2.text = @"领队服务是否满意:";
    }
    return _selectLabel2;
}

-(EDStarRating *)starControl1
{
    if (!_starControl1) {
        _starControl1 = [[EDStarRating alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.selectLabel1.frame) + 5, 100, 140, 30)];
        _starControl1.backgroundColor  = [UIColor clearColor];
        _starControl1.starImage = [[UIImage imageNamed:@"five-star-g"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        _starControl1.starHighlightedImage = [[UIImage imageNamed:@"five-star-o"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        _starControl1.maxRating = 5.0;
//        _starControl.delegate = self;
        //    _starRating.horizontalMargin = 12.0;
        _starControl1.editable = YES;
//        _starControl.rating = 2.5;
        _starControl1.displayMode = EDStarRatingDisplayHalf;
        [_starControl1  setNeedsDisplay];
    }
    return _starControl1;
}

-(EDStarRating *)starControl2
{
    if (!_starControl2) {
        _starControl2 = [[EDStarRating alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.selectLabel1.frame) + 5, 130, 140, 30)];
        _starControl2.backgroundColor  = [UIColor clearColor];
        _starControl2.starImage = [[UIImage imageNamed:@"five-star-g"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        _starControl2.starHighlightedImage = [[UIImage imageNamed:@"five-star-o"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        _starControl2.maxRating = 5.0;
        //        _starControl.delegate = self;
        //    _starRating.horizontalMargin = 12.0;
        _starControl2.editable = YES;
        //        _starControl.rating = 2.5;
        _starControl2.displayMode = EDStarRatingDisplayHalf;
        [_starControl2  setNeedsDisplay];
    }
    return _starControl2;
}

-(UIButton *)scoreButton
{
    if (!_scoreButton) {
        _scoreButton = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 125, 0, 110, 40)];
        [_scoreButton setTitle:@"提交打分" forState:UIControlStateNormal];
        [_scoreButton setBackgroundImage:[UIImage imageNamed:@"Submit-score-mutual"] forState:UIControlStateNormal];
        [_scoreButton setBackgroundImage:[UIImage imageNamed:@"Submit-score"] forState:UIControlStateHighlighted];
        _scoreButton.titleLabel.font = [UIFont boldSystemFontOfSize:14.0];
        _scoreButton.titleLabel.textColor = [UIColor whiteColor];
    }
    return _scoreButton;
}

-(void)configureCellWithItem:(id)item atIndexPath:(NSIndexPath *)indexPath
{
    ScoreInfo *data = (ScoreInfo *)item;
    self.scoreButton.tag = indexPath.row;
    self.subTitleLabel.text = [NSString stringWithFormat:@"领队:%@",data.leader];
    self.describeLabel.text = data.title;
    self.starControl1.rating = data.accuracyRate;
    self.starControl2.rating = data.satisfiedRate;
}

@end



@implementation ScoreCellView


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
