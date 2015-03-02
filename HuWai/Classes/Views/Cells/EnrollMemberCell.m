//
//  EnrollMemberCell.m
//  HuWai
//
//  Created by WmVenusMac on 15-2-28.
//  Copyright (c) 2015年 xici. All rights reserved.
//

#import "EnrollMemberCell.h"
#import "CommonPersonModel.h"

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
    CommonPersonInfo *data = (CommonPersonInfo *)item;
    self.checkBtn.tag = indexPath.row;
    [self.checkBtn setSelected:data.isSelected];
    self.nameLabel.text = data.name;
    self.sexLabel.text = [self genderToString:[data.gender intValue]];
    self.IDCardNo.text = data.identity;
}

-(NSString *)genderToString:(NSInteger)gender
{
    if (gender == 0) {
        return @"女";
    }else if(gender == 1){
        return @"男";
    }
    return nil;
}
@end
