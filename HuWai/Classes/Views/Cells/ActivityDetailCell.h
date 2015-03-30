//
//  ActivityDetailCell.h
//  HuWai
//
//  Created by WmVenusMac on 15-3-11.
//  Copyright (c) 2015年 xici. All rights reserved.
//

#import "BaseTableViewCell.h"

@interface ActivityDetailCell : BaseTableViewCell
@property (weak, nonatomic) IBOutlet TTTAttributedLabel *destinationLabel;
@property (weak, nonatomic) IBOutlet TTTAttributedLabel *activityTimeLabel;
@property (weak, nonatomic) IBOutlet TTTAttributedLabel *playLabel;

@property (nonatomic, strong) RTLabel *contentLabel;

@end
