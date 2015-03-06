//
//  LeaderDetailCell.h
//  HuWai
//
//  Created by WmVenusMac on 15-3-6.
//  Copyright (c) 2015年 xici. All rights reserved.
//

#import "BaseTableViewCell.h"

@interface LeaderDetailCell : BaseTableViewCell
@property (weak, nonatomic) IBOutlet UIView *avatarView;
@property (weak, nonatomic) IBOutlet TTTAttributedLabel *nameLabel;
@property (weak, nonatomic) IBOutlet TTTAttributedLabel *infoLabel;
@property (weak, nonatomic) IBOutlet TTTAttributedLabel *gradeLabel;
@property (weak, nonatomic) IBOutlet UILabel *leaderStartLabel;
@property (weak, nonatomic) IBOutlet UILabel *leaderNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *leaderGradeLabel;
@property (weak, nonatomic) IBOutlet UIButton *subcribeActivityBtn;


@end
