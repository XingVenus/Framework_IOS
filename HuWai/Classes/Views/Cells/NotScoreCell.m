//
//  notScoreCell.m
//  HuWai
//
//  Created by WmVenusMac on 15-2-2.
//  Copyright (c) 2015年 xici. All rights reserved.
//

#import "NotScoreCell.h"


@implementation NotScoreCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.backgroundColor = RGBA(242, 242, 243, 1);
        self.contentView.backgroundColor = RGBA(242, 242, 243, 1);
        [self.contentView addSubview:self.scoreBackView];
        [self.scoreBackView addSubview:self.describeLabel];
        [self.scoreBackView addSubview:self.titleLabel];
        [self.scoreBackView addSubview:self.subTitleLabel];
        [self.scoreBackView addSubview:self.selectLabel1];
        [self.scoreBackView addSubview:self.selectLabel2];
        [self.scoreBackView addSubview:self.starControl1];
        [self.scoreBackView addSubview:self.starControl2];
        [self.scoreBackView addSubview:self.scoreButton];
    }
    return self;
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

-(ScoreCellView *)scoreBackView
{
    if (!_scoreBackView) {
        _scoreBackView = [[ScoreCellView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 200)];
        _scoreBackView.backgroundColor = [UIColor whiteColor];
    }
    return _scoreBackView;
}

-(UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, 100, 21)];
        _titleLabel.font = [UIFont boldSystemFontOfSize:16.0];
        
    }
    return _titleLabel;
}

-(UILabel *)subTitleLabel
{
    if (!_subTitleLabel) {
        _subTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 120, 10, 120, 21)];
        _subTitleLabel.font = [UIFont systemFontOfSize:14.0];
        _subTitleLabel.textColor = [UIColor lightGrayColor];
        
    }
    return _subTitleLabel;
}

-(RTLabel *)describeLabel
{
    if (!_describeLabel) {
        _describeLabel = [[RTLabel alloc] initWithFrame:CGRectMake(15, 60, SCREEN_WIDTH - 15*2, 50)];
        _describeLabel.lineSpacing = 5;
        _describeLabel.font = [UIFont systemFontOfSize:14.0];
        _describeLabel.textColor = [UIColor darkGrayColor];
    }
    return _describeLabel;
}

-(EDStarRating *)starControl1
{
    if (!_starControl1) {
        _starControl1 = [[EDStarRating alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 150, 100, 140, 30)];
//        _starControl.backgroundColor  = [UIColor redColor];
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
        _starControl2 = [[EDStarRating alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 150, 130, 140, 30)];
        //        _starControl.backgroundColor  = [UIColor redColor];
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

-(void)configureCellWithItem:(id)item atIndexPath:(NSIndexPath *)indexPath
{
    self.titleLabel.text = @"待打分";
    self.subTitleLabel.text = @"领队:sdffffff";
    self.describeLabel.text = @"李克强出席中法建交50周年纪念活动闭幕式李克强出席中法建交50周年纪念活动闭幕式李克强出席中法建交50周年纪念活动闭幕式";
}

@end
