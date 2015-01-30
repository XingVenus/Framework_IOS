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
    //    [super layoutSubviews];
//    self.contentView.frame = CGRectInset(self.bounds, 0, 5);
    self.describeLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [self.describeLabel sizeToFit];
    
}

- (void)configureCellWithItem:(id)item atIndexPath:(NSIndexPath *)indexPath
{
    self.titleLabel.text = @"iPhone或者iPad开发中";
    self.dateLabel.text = @"2015-1-30 18:17";
    self.describeLabel.text = @"[UIApplication sharedApplication].statusBarHidden=YES即可实现隐藏，可是状态条所占空间依然无法为程序所用，将UIView的frame的y值设置为-20也有点不合理。";
}

@end
