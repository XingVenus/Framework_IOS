//
//  PayDoneForActivity.m
//  HuWai
//
//  Created by WmVenusMac on 15-4-8.
//  Copyright (c) 2015年 xici. All rights reserved.
//

#import "PayDoneForActivityCell.h"
#import "OrderDetailModel.h"

@implementation PayDoneForActivityCell

{
    CALayer *_secondLayer;
    CALayer *_thirdLayer;
    CALayer *_fourthLayer;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier withInsurance:(BOOL)insurance
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self.contentView addSubview:self.orderLabel];
        [self.contentView addSubview:self.totalPayLabel];
        [self.contentView addSubview:self.activityLabel];
        [self.contentView addSubview:self.activityPriceLabel];
        [self.contentView addSubview:self.aNumLabel];
        
        [self.contentView addSubview:self.activityImage];
        [self.contentView addSubview:self.noticeLabel];
        [self.contentView addSubview:self.totalLabel];
        
        if (insurance) {
            [self.contentView addSubview:self.insuranceLabel];
            [self.contentView addSubview:self.insurancePriceLabel];
            [self.contentView addSubview:self.inNumLabel];
            if (!_fourthLayer) {
                _fourthLayer = [CALayer layer];
                _fourthLayer.frame = CGRectMake(0, 155+8, SCREEN_WIDTH, 0.5);
                _fourthLayer.backgroundColor = APP_DIVIDELINE_COLOR.CGColor;
                [self.contentView.layer addSublayer:_fourthLayer];
            }
        }

        [self.contentView addSubview:self.forwardOrderBtn];
        
        
    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.contentView.frame = CGRectInset(self.bounds, 0, 5);
    
    self.forwardOrderBtn.top = self.height - 7 - 31 - 10;
    self.noticeLabel.top = self.height - 7  - 10 - 30 - 50;
    self.totalLabel.top = self.height - 7 - 10 - 24;
    
    [self setLayerLineAndBackground];
    
    if (!_secondLayer) {
        _secondLayer = [CALayer layer];
        _secondLayer.frame = CGRectMake(0, 37, SCREEN_WIDTH, 0.5);
        _secondLayer.backgroundColor = APP_DIVIDELINE_COLOR.CGColor;
        [self.contentView.layer addSublayer:_secondLayer];
    }
    
    if (!_thirdLayer) {
        _thirdLayer = [CALayer layer];
        _thirdLayer.frame = CGRectMake(0, 95+8, SCREEN_WIDTH, 0.5);
        _thirdLayer.backgroundColor = APP_DIVIDELINE_COLOR.CGColor;
        [self.contentView.layer addSublayer:_thirdLayer];
    }
    
}

#pragma mark 活动信息部分
-(UILabel *)orderLabel
{
    if (!_orderLabel) {
        _orderLabel = [[UILabel alloc] initWithFrame:CGRectMake(8, 8, 160, 21)];
        _orderLabel.backgroundColor = [UIColor clearColor];
        _orderLabel.textAlignment = NSTextAlignmentLeft;
        _orderLabel.font = [UIFont boldSystemFontOfSize:14.0];
        _orderLabel.textColor = [UIColor blackColor];
        _orderLabel.text = @"订单信息";
    }
    return _orderLabel;
}

-(UIImageView *)activityImage
{
    if (!_activityImage) {
        _activityImage = [[UIImageView alloc] initWithFrame:CGRectMake(8, 44, 65, 50)];
        _activityImage.contentMode = UIViewContentModeScaleAspectFill;
        _activityImage.clipsToBounds = YES;
    }
    return _activityImage;
}

-(TTTAttributedLabel *)totalPayLabel
{
    if (!_totalPayLabel) {
        _totalPayLabel = [[TTTAttributedLabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 170, 6, 160, 24)];
        _totalPayLabel.textColor = [UIColor darkGrayColor];
        _totalPayLabel.font = [UIFont boldSystemFontOfSize:14.0];
        _totalPayLabel.textAlignment = NSTextAlignmentRight;
    }
    return _totalPayLabel;
}

-(TTTAttributedLabel *)activityLabel
{
    if (!_activityLabel) {
        _activityLabel = [[TTTAttributedLabel alloc] initWithFrame:CGRectMake(80, 44, SCREEN_WIDTH - 80 - 70, 50)];
        _activityLabel.numberOfLines = 0;
        _activityLabel.lineBreakMode = NSLineBreakByWordWrapping;
        _activityLabel.textColor = [UIColor darkGrayColor];
        _activityLabel.font = [UIFont systemFontOfSize:14.0];
        _activityLabel.lineSpacing = 2;
        _activityLabel.verticalAlignment = TTTAttributedLabelVerticalAlignmentTop;
    }
    return _activityLabel;
}

-(UILabel *)activityPriceLabel
{
    if (!_activityPriceLabel) {
        _activityPriceLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 80 - 8, 44, 80, 24)];
        _activityPriceLabel.backgroundColor = [UIColor clearColor];
        _activityPriceLabel.font = [UIFont systemFontOfSize:14.0];
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
        _insuranceLabel = [[TTTAttributedLabel alloc] initWithFrame:CGRectMake(8, 104+8, SCREEN_WIDTH - 110, 42)];
        _insuranceLabel.numberOfLines = 0;
        _insuranceLabel.lineBreakMode = NSLineBreakByWordWrapping;
        _insuranceLabel.textColor = [UIColor darkGrayColor];
        _insuranceLabel.font = [UIFont systemFontOfSize:14.0];
        _insuranceLabel.lineSpacing = 2;
        _insuranceLabel.verticalAlignment = TTTAttributedLabelVerticalAlignmentCenter;
    }
    return _insuranceLabel;
}

-(UILabel *)insurancePriceLabel
{
    if (!_insurancePriceLabel) {
        _insurancePriceLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 80 - 8, 104+8, 80, 24)];
        _insurancePriceLabel.backgroundColor = [UIColor clearColor];
        _insurancePriceLabel.font = [UIFont systemFontOfSize:14.0];
        _insurancePriceLabel.textAlignment = NSTextAlignmentRight;
        _insurancePriceLabel.textColor = [UIColor orangeColor];
    }
    return _insurancePriceLabel;
}

-(UILabel *)inNumLabel
{
    if (!_inNumLabel) {
        _inNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 42 - 8, 126+8, 42, 20)];
        _inNumLabel.textAlignment = NSTextAlignmentRight;
        _inNumLabel.font = [UIFont systemFontOfSize:14.0];
        _inNumLabel.textColor = [UIColor lightGrayColor];
    }
    return _inNumLabel;
}

-(UILabel *)noticeLabel
{
    if (!_noticeLabel) {
        _noticeLabel = [[UILabel alloc] initWithFrame:CGRectMake(8, 0, SCREEN_WIDTH - 8*2, 40)];
        _noticeLabel.numberOfLines = 0;
        _noticeLabel.backgroundColor = [UIColor clearColor];
        _noticeLabel.font = [UIFont systemFontOfSize:14.0];
        _noticeLabel.textColor = [UIColor lightGrayColor];
    }
    return _noticeLabel;
}

-(UILabel *)totalLabel
{
    if (!_totalLabel) {
        _totalLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 160, 0, 150, 24)];
        _totalLabel.backgroundColor = [UIColor clearColor];
        _totalLabel.font = [UIFont systemFontOfSize:14.0];
        _totalLabel.textColor = [UIColor orangeColor];
        _totalLabel.textAlignment = NSTextAlignmentRight;
    }
    return _totalLabel;
}

-(UIButton *)forwardOrderBtn
{
    if (!_forwardOrderBtn) {
        _forwardOrderBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _forwardOrderBtn.frame = CGRectMake(20, 0, SCREEN_WIDTH - 20*2, 40);
        [_forwardOrderBtn setBackgroundImage:[UIImage imageNamed:@"Login"] forState:UIControlStateNormal];
        [_forwardOrderBtn setTitle:@"前往我的订单查看" forState:UIControlStateNormal];
        [_forwardOrderBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _forwardOrderBtn.titleLabel.font = [UIFont boldSystemFontOfSize:15.0];
    }
    return _forwardOrderBtn;
}

-(void)configureCellWithItem:(id)item atIndexPath:(NSIndexPath *)indexPath
{
    
    OrderDetailModel *model = (OrderDetailModel *)item;
    OrderInfo *orderInfo = (OrderInfo *)model.order_info;
    
    [self.activityImage sd_setImageWithURL:[NSURL URLWithString:orderInfo.image] placeholderImage:nil];
    self.activityLabel.text = model.activity_info.title;
    self.activityPriceLabel.text = [NSString stringWithFormat:@"￥%@",model.activity_info.price];
    self.aNumLabel.text = [NSString stringWithFormat:@"x %@",orderInfo.num];
    if (orderInfo.insurance) {
        self.insuranceLabel.text = orderInfo.insurance;
        self.insurancePriceLabel.text = [NSString stringWithFormat:@"￥%@",orderInfo.insurance_price];
        self.inNumLabel.text = [NSString stringWithFormat:@"x %@",orderInfo.insurance_num];
    }
//    self.timeLabel.text = orderInfo.time;
//    self.totalLabel.text = [NSString stringWithFormat:@"共计￥%@",orderInfo.money];
    self.totalPayLabel.text = [NSString stringWithFormat:@"支付金额￥%@",orderInfo.money];
    NSString *noteText = @"亲，请保持电话畅通本\n活动领队：%@将尽快与您确认出行事宜";
    self.noticeLabel.text = [NSString stringWithFormat:noteText,orderInfo.leader_username];
}
@end
