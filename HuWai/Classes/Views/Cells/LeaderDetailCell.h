//
//  LeaderDetailCell.h
//  HuWai
//
//  Created by WmVenusMac on 15-3-6.
//  Copyright (c) 2015年 xici. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "PAAImageView.h"

@interface LeaderDetailCell : BaseTableViewCell
@property (weak, nonatomic) IBOutlet PAAImageView *avatarView;
@property (weak, nonatomic) IBOutlet TTTAttributedLabel *nameLabel;
@property (weak, nonatomic) IBOutlet TTTAttributedLabel *infoLabel;
@property (weak, nonatomic) IBOutlet TTTAttributedLabel *gradeLabel;
@property (weak, nonatomic) IBOutlet TTTAttributedLabel *leaderStartLabel;
@property (weak, nonatomic) IBOutlet TTTAttributedLabel *leaderNumberLabel;
@property (weak, nonatomic) IBOutlet TTTAttributedLabel *leaderGradeLabel;
@property (weak, nonatomic) IBOutlet UIButton *subscribeActivityBtn;


@end
