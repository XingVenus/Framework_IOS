//
//  MyOrderCell.h
//  HuWai
//
//  Created by WmVenusMac on 15-3-3.
//  Copyright (c) 2015年 xici. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "TTTAttributedLabel.h"

@interface MyOrderCell : BaseTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier withInsurance:(BOOL)insurance isWating:(BOOL)iswating;

@property (nonatomic, strong) UILabel *leaderLabel;
@property (nonatomic, strong) TTTAttributedLabel *activityLabel;
@property (nonatomic, strong) UILabel *activityPriceLabel;
@property (nonatomic, strong) UILabel *aNumLabel;

@property (nonatomic, strong) TTTAttributedLabel *insuranceLabel;
@property (nonatomic, strong) UILabel *insurancePriceLabel;
@property (nonatomic, strong) UILabel *inNumLabel;

@property (nonatomic, strong) UIButton *cancelBtn;
@property (nonatomic, strong) UIButton *paymentBtn;

@property (nonatomic, strong) UIImageView *activityImage;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UILabel *totalLabel;

@end
