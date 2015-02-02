//
//  BaseViewWithSeparateLine.m
//  HuWai
//
//  Created by WmVenusMac on 15-2-2.
//  Copyright (c) 2015年 xici. All rights reserved.
//

#import "BaseViewWithSeparateLine.h"

@implementation BaseViewWithSeparateLine


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
        // Drawing code
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(context, [UIColor grayColor].CGColor);
    CGContextSetLineWidth(context, kLineWidth);
//    CGPoint *point = (CGPoint *) malloc(sizeof(CGPoint) * 4);
//    point[0] = CGPointMake(0, self.bounds.size.height);
//    point[1] = CGPointMake(self.bounds.size.width, self.bounds.size.height);
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, 0, 0);
    CGContextAddLineToPoint(context, self.bounds.size.width, 0);
    CGContextMoveToPoint(context, 0, self.bounds.size.height);
    CGContextAddLineToPoint(context, self.bounds.size.width, self.bounds.size.height);
    CGContextClosePath(context);
    CGContextStrokePath(context);
//    free(point);
}

-(void)setPathPointArray:(NSArray *)pathPointArray
{
    _pathPointArray = pathPointArray;
    [self drawLinePath:pathPointArray];
}

-(void)drawLinePath:(NSArray *)points
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(context, [UIColor grayColor].CGColor);
    CGContextSetLineWidth(context, kLineWidth);
    
    CGPoint *point = (CGPoint *) malloc(sizeof(CGPoint) * points.count);
    for (int i=0; i<points.count; i++) {
        point[i] = [points[i] CGPointValue];
    }
    CGContextBeginPath(context);
    CGContextAddLines(context, point, 2);
    CGContextClosePath(context);
    CGContextStrokePath(context);
    free(point);
}
@end
