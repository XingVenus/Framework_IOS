//
//  PayTypeCell.m
//  HuWai
//
//  Created by WmVenusMac on 15-3-5.
//  Copyright (c) 2015年 xici. All rights reserved.
//

#import "PayTypeCell.h"

@implementation PayTypeCell


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
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
    self.contentView.frame = CGRectInset(self.bounds, 0, 5);
    [self setNeedsDisplay];
}

@end
