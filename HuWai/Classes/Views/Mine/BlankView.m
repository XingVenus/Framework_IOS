//
//  BlankView.m
//  HuWai
//
//  Created by WmVenusMac on 15-2-6.
//  Copyright (c) 2015年 xici. All rights reserved.
//

#import "BlankView.h"

@implementation BlankView


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self loadView];
    }
    return self;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)loadView
{
    if (!_expressionView) {
        _expressionView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"expression-wu"]];
        _expressionView.frame = CGRectMake(0, 0, 60, 105);
//        _expressionView.contentMode = UIViewContentModeScaleAspectFit;
    }
    [self addSubview:_expressionView];
    
    if (!_textLabel) {
        _textLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_expressionView.frame)+10, self.width, 30)];
        _textLabel.backgroundColor = [UIColor clearColor];
        _textLabel.textAlignment = NSTextAlignmentCenter;
        _textLabel.font = [UIFont systemFontOfSize:14.0];
        _textLabel.textColor = [UIColor darkGrayColor];
    }
    [self addSubview:_textLabel];
}

-(void)layoutSubviews
{
    _expressionView.centerX = self.centerX;
}

@end
