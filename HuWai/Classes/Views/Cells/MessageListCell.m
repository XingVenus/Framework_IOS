//
//  MessageListCell.m
//  HuWai
//
//  Created by WmVenusMac on 15-1-30.
//  Copyright (c) 2015年 xici. All rights reserved.
//

#import "MessageListCell.h"

@implementation MessageListCell

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
    
//    CGSize optimumSize = [self.describeLabel optimumSize];
//    self.describeLabel.height = optimumSize.height;
    [self.contentView addSubview:_describeLabel];

}

- (void)configureCellWithItem:(id)item atIndexPath:(NSIndexPath *)indexPath
{
    if (!_describeLabel) {
        _describeLabel = [[RTLabel alloc] initWithFrame:CGRectMake(10, 50, SCREEN_WIDTH - 10 *2, 0)];
//        _describeLabel.numberOfLines = 2;
        _describeLabel.lineSpacing = 5;
        _describeLabel.font = [UIFont systemFontOfSize:14.0];
        _describeLabel.textColor = [UIColor darkGrayColor];
        _describeLabel.height = 50;
    }
    
    self.titleLabel.text = @"iPhone或者iPad开发中iPhone或者iPad开发中";
    self.dateLabel.text = @"2015-1-30 18:17";
    self.describeLabel.text = @"苹果联合创始人沃兹：认同电脑会取代人脑苹果联合创始人沃兹：认同电脑会取代人脑苹果联合创始人沃兹：认同电脑会取代人脑iPhone或者iPad开发中";
    [self.describeLabel sizeToFit];
}

@end
