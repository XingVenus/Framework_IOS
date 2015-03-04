//
//  OrderContactCell.h
//  HuWai
//
//  Created by WmVenusMac on 15-3-2.
//  Copyright (c) 2015年 xici. All rights reserved.
//

#import "BaseTableViewCell.h"

@interface OrderContactCell : BaseTableViewCell
@property (weak, nonatomic) IBOutlet UILabel *personNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *personPhoneLabel;
@property (weak, nonatomic) IBOutlet UILabel *emergencyNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *emergencyPhoneLabel;

@end
