//
//  OrderGoOutCell.m
//  HuWai
//
//  Created by WmVenusMac on 15-3-5.
//  Copyright (c) 2015年 xici. All rights reserved.
//

#import "OrderGoOutCell.h"
#import "OrderDetailModel.h"

@implementation OrderGoOutCell


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}

-(void)layoutSubviews
{
//    [super layoutSubviews];
    self.contentView.frame = CGRectInset(self.bounds, 0, 5);
    [self setLayerLineAndBackground];
    [self setNeedsDisplay];
}

-(void)configureCellWithItem:(id)item atIndexPath:(NSIndexPath *)indexPath
{
    NSArray *persons = (NSArray *)item;
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(8, 0, 100, 45)];
    titleLabel.font = [UIFont boldSystemFontOfSize:16.0];
    titleLabel.text = @"出行人";
    [self.contentView addSubview:titleLabel];
    if (persons.count>0) {
        for (int i=0; i<persons.count; i++) {
            CommonPersonInfo *info = persons[i];
            CALayer *sepLineLayer = [CALayer layer];
            sepLineLayer.frame = CGRectMake(0, 45+i*45, SCREEN_WIDTH, 0.5);
            sepLineLayer.backgroundColor = APP_DIVIDELINE_COLOR.CGColor;
            UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(8, 45+i*45, 80, 45)];
            nameLabel.textColor = [UIColor darkGrayColor];
            UILabel *phoneLabel = [[UILabel alloc] initWithFrame:CGRectMake(180, 45+i*45, 130, 45)];
            phoneLabel.textColor = [UIColor darkGrayColor];
            phoneLabel.textAlignment = NSTextAlignmentRight;
            
            nameLabel.text = info.name;
            phoneLabel.text = info.phone;
            [self.contentView.layer addSublayer:sepLineLayer];
            [self.contentView addSubview:nameLabel];
            [self.contentView addSubview:phoneLabel];
        }
    }
    [self.contentView setNeedsDisplay];
}
@end
