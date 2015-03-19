//
//  SLButton.m
//  HuWai
//
//  Created by WmVenusMac on 15-3-18.
//  Copyright (c) 2015年 xici. All rights reserved.
//

#import "SLButton.h"

@implementation SLButton

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    CGRect textFrame = [self titleLabel].frame;
    CGRect imageFrame = [self imageView].frame;
    
    textFrame.origin.x = imageFrame.origin.x;
    self.titleLabel.frame = textFrame;
    
    imageFrame.origin.x = CGRectGetMaxX(self.titleLabel.frame)+5;
    self.imageView.frame = imageFrame;
        
//        self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;

//    CGPoint center = self.imageView.center;
//    center.x = self.frame.size.width/2;
//    center.y = self.imageView.frame.size.height/2;
//    self.imageView.center = center;
    //Center text
//    textFrame.origin.x = 0;
//    textFrame.origin.y = self.imageView.frame.size.height + 5;
//    textFrame.size.width = self.frame.size.width;
//    
//    self.titleLabel.frame = textFrame;
//    self.titleLabel.textAlignment = NSTextAlignmentCenter;
}
@end
