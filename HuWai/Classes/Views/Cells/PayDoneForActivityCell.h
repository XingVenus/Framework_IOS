//
//  PayDoneForActivity.h
//  HuWai
//
//  Created by WmVenusMac on 15-4-8.
//  Copyright (c) 2015年 xici. All rights reserved.
//

#import "BaseTableViewCell.h"

@interface PayDoneForActivityCell : BaseTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier withInsurance:(BOOL)insurance;

@property (nonatomic, strong) UILabel *orderLabel;
@property (nonatomic, strong) TTTAttributedLabel *totalPayLabel;
@property (nonatomic, strong) TTTAttributedLabel *activityLabel;
@property (nonatomic, strong) UILabel *activityPriceLabel;
@property (nonatomic, strong) UILabel *aNumLabel;

@property (nonatomic, strong) TTTAttributedLabel *insuranceLabel;
@property (nonatomic, strong) UILabel *insurancePriceLabel;
@property (nonatomic, strong) UILabel *inNumLabel;

@property (nonatomic, strong) UIButton *forwardOrderBtn;

@property (nonatomic, strong) UIImageView *activityImage;
@property (nonatomic, strong) UILabel *noticeLabel;
@property (nonatomic, strong) UILabel *totalLabel;
@end
