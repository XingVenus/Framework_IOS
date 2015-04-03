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

}

-(CALayer *)separateLineLayer
{
    if (!_separateLineLayer) {
        _separateLineLayer = [CALayer layer];
        _separateLineLayer.backgroundColor = APP_DIVIDELINE_COLOR.CGColor;
        _separateLineLayer.frame = CGRectMake(0, 40, SCREEN_WIDTH, 0.5);
    }
    return _separateLineLayer;
}

-(void)layoutSubviews
{
    self.contentView.frame = CGRectInset(self.bounds, 0, 5);
    [self.layer addSublayer:self.separateLineLayer];
    [self setLayerLineAndBackground];
    [self setNeedsDisplay];
}

@end
