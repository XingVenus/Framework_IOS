//
//  MessageListCell.m
//  HuWai
//
//  Created by WmVenusMac on 15-1-30.
//  Copyright (c) 2015年 xici. All rights reserved.
//

#import "MessageListCell.h"

@implementation MessageListCell

-(void)drawRect:(CGRect)rect
{
    CALayer *topLayer = [CALayer layer];
    topLayer.frame = CGRectMake(0, 5, SCREEN_WIDTH, 0.5);
    topLayer.backgroundColor = [UIColor lightGrayColor].CGColor;
    CALayer *bottomLayer = [CALayer layer];
    bottomLayer.frame = CGRectMake(0, self.bounds.size.height-5, SCREEN_WIDTH, 0.5);
    bottomLayer.backgroundColor = [UIColor lightGrayColor].CGColor;
    [self.layer addSublayer:topLayer];
    [self.layer addSublayer:bottomLayer];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)configureCellWithItem:(id)item atIndexPath:(NSIndexPath *)indexPath
{
    _describeLabel.lineSpacing = 8;
    _describeLabel.font = [UIFont systemFontOfSize:14.0];
    _describeLabel.textColor = [UIColor darkGrayColor];
    self.titleLabel.text = @"iPhone或者iPad开发中iPhone或者iPad开发中";
    self.dateLabel.text = @"2015-1-30 18:17";
    self.describeLabel.text = @"苹果联合创始人沃兹：认同电脑会取代人脑苹果联合创始人沃兹：认同电脑会取代人脑苹果联合创始人沃兹：认同电脑会取代人脑iPhone或者iPad开发中";
//    [self.describeLabel sizeToFit];
}

@end
