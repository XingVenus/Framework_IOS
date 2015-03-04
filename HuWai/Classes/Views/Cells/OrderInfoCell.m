//
//  OrderInfoCell.m
//  HuWai
//
//  Created by WmVenusMac on 15-3-3.
//  Copyright (c) 2015年 xici. All rights reserved.
//

#import "OrderInfoCell.h"
#import "OrderDetailModel.h"

@implementation OrderInfoCell

- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    self.contentView.layer.shouldRasterize = YES;
    self.contentView.layer.rasterizationScale = [[UIScreen mainScreen] scale];
    
    if (NSFoundationVersionNumber>NSFoundationVersionNumber_iOS_6_1) {
        self.backgroundColor = RGBA(242, 242, 242, 1);
    }else{
        self.backgroundView = [[UIView alloc] initWithFrame:self.bounds];
        self.backgroundView.backgroundColor = RGBA(242, 242, 242, 1);
    }
    self.contentView.backgroundColor = [UIColor whiteColor];
    
    CALayer *topLayer = [CALayer layer];
    topLayer.frame = CGRectMake(0, 0, SCREEN_WIDTH, 0.5);
    topLayer.backgroundColor = [UIColor lightGrayColor].CGColor;
    CALayer *bottomLayer = [CALayer layer];
    bottomLayer.frame = CGRectMake(0, self.contentView.bounds.size.height, SCREEN_WIDTH, 0.5);
    bottomLayer.backgroundColor = [UIColor lightGrayColor].CGColor;
    [self.contentView.layer addSublayer:topLayer];
    [self.contentView.layer addSublayer:bottomLayer];

}

-(void)layoutSubviews
{
//    self.totalPriceLabel.top = self.height - 7 - 31 - 10;
    self.contentView.frame = CGRectInset(self.bounds, 0, 5);

    //    [self.contentView setNeedsUpdateConstraints];
    //    [self.contentView updateConstraints];
}

-(void)configureCellWithItem:(id)item atIndexPath:(NSIndexPath *)indexPath
{
    OrderDetailModel *data = (OrderDetailModel *)item;
    self.activityLabel.text = data.activity_info.title;
    self.activityPriceLabel.text = data.activity_info.price;
    self.aNumLabel.text = data.order_info.num;
    self.totalPriceLabel.text = [NSString stringWithFormat:@"合计:%@元",data.order_info.money];
    if (data.order_info.insurance) {
        self.insuranceLabel.text = data.order_info.insurance;
        self.insurancePriceLabel.text = data.order_info.insurance_price;
        self.inNumLabel.text = data.order_info.insurance_num;
    }else{
        self.insuranceLabel.hidden = YES;
        self.insurancePriceLabel.hidden = YES;
        self.inNumLabel.hidden = YES;
        self.lineLabel.hidden  = YES;
    }
}
/*
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier withInsurance:(BOOL)insurance
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.layer.shouldRasterize = YES;
        self.contentView.layer.rasterizationScale = [[UIScreen mainScreen] scale];
        
        if (NSFoundationVersionNumber>NSFoundationVersionNumber_iOS_6_1) {
            self.backgroundColor = RGBA(242, 242, 242, 1);
        }else{
            self.backgroundView = [[UIView alloc] initWithFrame:self.bounds];
            self.backgroundView.backgroundColor = RGBA(242, 242, 242, 1);
        }
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        [self.contentView addSubview:[self orderTitle]];
        [self.contentView addSubview:self.orderStatusLabel];
        [self.contentView addSubview:self.activityLabel];
        [self.contentView addSubview:self.activityPriceLabel];
        [self.contentView addSubview:self.aNumLabel];
        
        if (insurance) {
            [self.contentView addSubview:self.insuranceLabel];
            [self.contentView addSubview:self.insurancePriceLabel];
            [self.contentView addSubview:self.inNumLabel];
            CALayer *thirdLayer = [CALayer layer];
            thirdLayer.frame = CGRectMake(0, 155, SCREEN_WIDTH, 0.5);
            thirdLayer.backgroundColor = [UIColor lightGrayColor].CGColor;
            [self.contentView.layer addSublayer:thirdLayer];
        }
    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    CALayer *topLayer = [CALayer layer];
    topLayer.frame = CGRectMake(0, 0, SCREEN_WIDTH, 0.5);
    topLayer.backgroundColor = [UIColor lightGrayColor].CGColor;
    CALayer *bottomLayer = [CALayer layer];
    bottomLayer.frame = CGRectMake(0, self.contentView.bounds.size.height, SCREEN_WIDTH, 0.5);
    bottomLayer.backgroundColor = [UIColor lightGrayColor].CGColor;
    [self.contentView.layer addSublayer:topLayer];
    [self.contentView.layer addSublayer:bottomLayer];
    
    CALayer *secondLayer = [CALayer layer];
    secondLayer.frame = CGRectMake(0, 37, SCREEN_WIDTH, 0.5);
    secondLayer.backgroundColor = [UIColor lightGrayColor].CGColor;
    [self.contentView.layer addSublayer:secondLayer];
    
    CALayer *thirdLayer = [CALayer layer];
    thirdLayer.frame = CGRectMake(0, 95, SCREEN_WIDTH, 0.5);
    thirdLayer.backgroundColor = [UIColor lightGrayColor].CGColor;
    [self.contentView.layer addSublayer:thirdLayer];
}

-(UILabel *)orderTitle
{
    UILabel *ordertitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(8 , 8, 80, 21)];
    ordertitleLabel.backgroundColor = [UIColor clearColor];
    ordertitleLabel.textAlignment = NSTextAlignmentLeft;
    ordertitleLabel.font = [UIFont boldSystemFontOfSize:16.0];
    ordertitleLabel.textColor = [UIColor blackColor];
    ordertitleLabel.text = @"订单信息";
    return ordertitleLabel;
}

-(UILabel *)orderStatusLabel
{
    if (!_orderStatusLabel) {
        _orderStatusLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 8 - 100, 8, 100, 21)];
        _orderStatusLabel.backgroundColor = [UIColor clearColor];
        _orderStatusLabel.textAlignment = NSTextAlignmentRight;
        _orderStatusLabel.font = [UIFont systemFontOfSize:14.0];
        _orderStatusLabel.textColor = [UIColor orangeColor];
    }
    return _orderStatusLabel;
}

-(TTTAttributedLabel *)activityLabel
{
    if (!_activityLabel) {
        _activityLabel = [[TTTAttributedLabel alloc] initWithFrame:CGRectMake(8, 44, SCREEN_WIDTH - 110, 42)];
        _activityLabel.numberOfLines = 0;
        _activityLabel.lineBreakMode = NSLineBreakByWordWrapping;
        _activityLabel.textColor = [UIColor darkGrayColor];
        _activityLabel.font = [UIFont systemFontOfSize:15.0];
        _activityLabel.lineSpacing = 2;
        _activityLabel.verticalAlignment = TTTAttributedLabelVerticalAlignmentCenter;
    }
    return _activityLabel;
}

-(UILabel *)activityPriceLabel
{
    if (!_activityPriceLabel) {
        _activityPriceLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 80 - 8, 44, 80, 24)];
        _activityPriceLabel.backgroundColor = [UIColor clearColor];
        _activityPriceLabel.font = [UIFont systemFontOfSize:17.0];
        _activityPriceLabel.textAlignment = NSTextAlignmentRight;
        _activityPriceLabel.textColor = [UIColor orangeColor];
    }
    return _activityPriceLabel;
}

-(UILabel *)aNumLabel
{
    if (!_aNumLabel) {
        _aNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 42 - 8, 66, 42, 20)];
        _aNumLabel.textAlignment = NSTextAlignmentRight;
        _aNumLabel.font = [UIFont systemFontOfSize:14.0];
        _aNumLabel.textColor = [UIColor lightGrayColor];
    }
    return _aNumLabel;
}

#pragma mark - 保险部分
-(TTTAttributedLabel *)insuranceLabel
{
    if (!_insuranceLabel) {
        _insuranceLabel = [[TTTAttributedLabel alloc] initWithFrame:CGRectMake(8, 104, SCREEN_WIDTH - 110, 42)];
        _insuranceLabel.numberOfLines = 0;
        _insuranceLabel.lineBreakMode = NSLineBreakByWordWrapping;
        _insuranceLabel.textColor = [UIColor darkGrayColor];
        _insuranceLabel.font = [UIFont systemFontOfSize:15.0];
        _insuranceLabel.lineSpacing = 2;
        _insuranceLabel.verticalAlignment = TTTAttributedLabelVerticalAlignmentCenter;
    }
    return _insuranceLabel;
}

-(UILabel *)insurancePriceLabel
{
    if (!_insurancePriceLabel) {
        _insurancePriceLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 80 - 8, 104, 80, 24)];
        _insurancePriceLabel.backgroundColor = [UIColor clearColor];
        _insurancePriceLabel.font = [UIFont systemFontOfSize:17.0];
        _insurancePriceLabel.textAlignment = NSTextAlignmentRight;
        _insurancePriceLabel.textColor = [UIColor orangeColor];
    }
    return _insurancePriceLabel;
}

-(UILabel *)inNumLabel
{
    if (!_inNumLabel) {
        _inNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 42 - 8, 126, 42, 20)];
        _inNumLabel.textAlignment = NSTextAlignmentRight;
        _inNumLabel.font = [UIFont systemFontOfSize:14.0];
        _inNumLabel.textColor = [UIColor lightGrayColor];
    }
    return _inNumLabel;
}

-(TTTAttributedLabel *)totalPriceLabel
{
    if (!_totalPriceLabel) {
        _totalPriceLabel = [[TTTAttributedLabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 100 - 8, 0, 100, 31)];
        _totalPriceLabel.backgroundColor = [UIColor clearColor];
        _totalPriceLabel.font = [UIFont systemFontOfSize:16.0];
    }
    return _totalPriceLabel;
}
 */
@end
