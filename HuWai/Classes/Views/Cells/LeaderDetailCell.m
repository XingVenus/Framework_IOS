//
//  LeaderDetailCell.m
//  HuWai
//
//  Created by WmVenusMac on 15-3-6.
//  Copyright (c) 2015年 xici. All rights reserved.
//

#import "LeaderDetailCell.h"
#import "ActivityDetailModel.h"

static NSString *LeaderStart = @"Ta一共发起了%@次活动";
static NSString *LeaderNumber = @"共有%@位小伙伴报名了Ta的活动";
static NSString *LeaderGrade = @"共收到%@位小伙伴给Ta打了分";

@implementation LeaderDetailCell

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)layoutSubviews
{
    self.avatarView.backgroundProgresscolor = [UIColor lightGrayColor];
    self.avatarView.progressColor = [UIColor lightGrayColor];
    [self.contentView setNeedsDisplay];
}

-(void)configureCellWithItem:(id)item atIndexPath:(NSIndexPath *)indexPath
{
    LeaderInfo *data = (LeaderInfo *)item;
    
    self.avatarView.placeHolderImage = [UIImage imageNamed:@"avatar"];
    [self.avatarView setImageURL:[NSURL URLWithString:data.avatar]];
    NSString *namestring = data.username;
    if (data.verified) {
        namestring = [namestring stringByAppendingString:@"(已认证)"];
    }
    self.nameLabel.text = namestring;
    NSString *infoString = [NSString stringWithFormat:@"%@ | %@ | %@\n认证信息:%@",data.gender,data.age,data.fromCity,data.validationMessage];
    self.infoLabel.lineSpacing = 6;
    self.infoLabel.text = infoString;
    NSString *gradeStr = [NSString stringWithFormat:@"%@分",data.score];
    self.gradeLabel.text = gradeStr;
    
    self.leaderStartLabel.text = [NSString stringWithFormat:LeaderStart,data.times];
    self.leaderNumberLabel.text = [NSString stringWithFormat:LeaderNumber,data.participants];
    self.leaderGradeLabel.text = [NSString stringWithFormat:LeaderGrade,data.rater];
}
@end
