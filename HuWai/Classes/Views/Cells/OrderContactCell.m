//
//  OrderContactCell.m
//  HuWai
//
//  Created by WmVenusMac on 15-3-2.
//  Copyright (c) 2015年 xici. All rights reserved.
//

#import "OrderContactCell.h"
#import "OrderDetailModel.h"

@implementation OrderContactCell


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    [self setLayerLineAndBackground];
}

-(void)layoutSubviews
{
    self.contentView.frame = CGRectInset(self.bounds, 0, 5);
//    [self.contentView setNeedsUpdateConstraints];
//    [self.contentView updateConstraints];
    [self setNeedsDisplay];
}

-(void)configureCellWithItem:(id)item atIndexPath:(NSIndexPath *)indexPath
{
    ContactsInfo *data = (ContactsInfo *)item;
    self.personNameLabel.text = data.realname;
    self.personPhoneLabel.text = data.tel;
    self.emergencyNameLabel.text = data.o_realname;
    self.emergencyPhoneLabel.text = data.o_tel;
}
@end
