//
//  MessageListCell.m
//  HuWai
//
//  Created by WmVenusMac on 15-1-30.
//  Copyright (c) 2015年 xici. All rights reserved.
//

#import "MessageGroupCell.h"
#import "MessageGroupModel.h"
#import "JSBadgeView.h"

@implementation MessageGroupCell
{
    JSBadgeView *badgeView;
}


- (void)awakeFromNib {
    // Initialization code
    badgeView = [[JSBadgeView alloc] initWithParentView:self.iconImage alignment:JSBadgeViewAlignmentTopRight];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)layoutSubviews
{
//    self.contentView.frame = CGRectInset(self.bounds, 0, 5);
    [self setLayerLineAndBackground];
    self.describeLabel.lineSpacing = 3.0;
//    self.describeLabel.height = self.bounds.size.height - 35 - 8 - 10;
//    [self.describeLabel setNeedsUpdateConstraints];
//    [self.describeLabel updateConstraints];
    [self setNeedsDisplay];
}

- (void)configureCellWithItem:(id)item atIndexPath:(NSIndexPath *)indexPath
{
    GroupInfo *info = (GroupInfo *)item;
    if ([info.type isEqualToString:@"comment"]) {
        self.iconImage.image = [UIImage imageNamed:@"message-1"];
    }else{
        self.iconImage.image = [UIImage imageNamed:@"news"];
    }
    if (info.num.intValue>0) {
        badgeView.badgeText = [NSString stringWithFormat:@"%d",info.num.intValue];
    }else{
        badgeView.badgeText = nil;
    }
    self.titleLabel.text = info.title;
    self.dateLabel.text = info.time;
    self.describeLabel.text = info.message;
}

@end
