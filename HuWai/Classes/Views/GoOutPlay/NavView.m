//
//  NavView.m
//  HuWai
//
//  Created by WmVenusMac on 15-1-30.
//  Copyright (c) 2015年 xici. All rights reserved.
//

#import "NavView.h"

@implementation NavView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(context, [UIColor grayColor].CGColor);
    CGContextSetLineWidth(context, 0.3);
    
    CGPoint *point = (CGPoint *) malloc(sizeof(CGPoint) * 2);
    point[0] = CGPointMake(0, self.bounds.size.height - 0.3);
    point[1] = CGPointMake(self.bounds.size.width, self.bounds.size.height - 0.3);
    CGContextBeginPath(context);
    CGContextAddLines(context, point, 2);
    CGContextClosePath(context);
    CGContextStrokePath(context);
    free(point);
}


@end
