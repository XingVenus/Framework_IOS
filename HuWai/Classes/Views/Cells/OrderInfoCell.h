//
//  OrderInfoCell.h
//  HuWai
//
//  Created by WmVenusMac on 15-3-3.
//  Copyright (c) 2015年 xici. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "TTTAttributedLabel.h"

@interface OrderInfoCell : BaseTableViewCell

//- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier withInsurance:(BOOL)insurance;


@property (nonatomic, weak) IBOutlet UILabel *orderStatusLabel;
@property (nonatomic, weak) IBOutlet TTTAttributedLabel *activityLabel;
@property (nonatomic, weak) IBOutlet UILabel *activityPriceLabel;
@property (nonatomic, weak) IBOutlet UILabel *aNumLabel;

@property (nonatomic, weak) IBOutlet TTTAttributedLabel *insuranceLabel;
@property (nonatomic, weak) IBOutlet UILabel *insurancePriceLabel;
@property (nonatomic, weak) IBOutlet UILabel *inNumLabel;

@property (nonatomic, weak) IBOutlet TTTAttributedLabel *totalPriceLabel;

@property (nonatomic, weak) IBOutlet UILabel *lineLabel;
@end
