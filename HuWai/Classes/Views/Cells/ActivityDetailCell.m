//
//  ActivityDetailCell.m
//  HuWai
//
//  Created by WmVenusMac on 15-3-11.
//  Copyright (c) 2015年 xici. All rights reserved.
//

#import "ActivityDetailCell.h"
#import "ActivityDetailModel.h"

static NSString *destination = @"目的地城市:";
static NSString *hour = @"活动时间:%@";
static NSString *play = @"玩法:%@";

@implementation ActivityDetailCell

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(void)configureCellWithItem:(id)item atIndexPath:(NSIndexPath *)indexPath
{
    DetailInfo *data = (DetailInfo *)item;
    self.destinationLabel.text = [NSString stringWithFormat:destination,data.city];
    self.activityTimeLabel.text = [NSString stringWithFormat:hour,data.time];
    self.playLabel.text = [NSString stringWithFormat:play,data.mode];
}
@end
