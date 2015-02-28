//
//  EnrollMemberCell.m
//  HuWai
//
//  Created by WmVenusMac on 15-2-28.
//  Copyright (c) 2015年 xici. All rights reserved.
//

#import "EnrollMemberCell.h"

@implementation EnrollMemberCell

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)configureCellWithItem:(id)item atIndexPath:(NSIndexPath *)indexPath
{
    self.checkBtn.tag = indexPath.row;
    self.nameLabel.text = @"老张";
    self.sexLabel.text = @"男";
    self.IDCardNo.text = @"320637287654567890";
}

@end
