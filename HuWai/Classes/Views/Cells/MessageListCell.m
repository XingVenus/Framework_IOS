//
//  MessageListCell.m
//  HuWai
//
//  Created by WmVenusMac on 15-1-30.
//  Copyright (c) 2015年 xici. All rights reserved.
//

#import "MessageListCell.h"
#import "UserMessageModel.h"

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
    self.contentView.frame = CGRectInset(self.bounds, 0, 5);
    [self setLayerLineAndBackground];
    self.describeLabel.lineSpacing = 5.0;
    self.describeLabel.height = self.bounds.size.height - 35 - 8 - 10;
    [self.describeLabel setNeedsUpdateConstraints];
    [self.describeLabel updateConstraints];
    [self setNeedsDisplay];
}

- (void)configureCellWithItem:(id)item atIndexPath:(NSIndexPath *)indexPath
{
    MessageInfo *info = (MessageInfo *)item;
    self.titleLabel.text = info.title;
    self.dateLabel.text = info.time;
    self.describeLabel.text = info.message;
}

@end
