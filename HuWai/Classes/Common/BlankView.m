//
//  BlankView.m
//  HuWai
//
//  Created by WmVenusMac on 15-2-6.
//  Copyright (c) 2015年 xici. All rights reserved.
//

#import "BlankView.h"
#import "UIButton+ButtonUtility.h"
@implementation BlankView
{
    UIButton *_btn;
}


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
    if (!_btn) {
        _btn = [UIButton buttonWithType:UIButtonTypeCustom];
        _btn.backgroundColor = [UIColor clearColor];
        _btn.titleLabel.font = [UIFont systemFontOfSize:14.0];
        [_btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        _btn.frame = self.bounds;
        [_btn setAdjustsImageWhenHighlighted:NO];
    }
    [self addSubview:_btn];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    [_btn setImage:self.imageIcon forState:UIControlStateNormal];
    [_btn setTitle:self.textTitle forState:UIControlStateNormal];
    
    switch (self.showType) {
        case ShowTitleRight:
        {
            [_btn setTitlePositionWithType:ButtonTitlePostionTypeRight withSpacing:10];
        }
            break;
        case ShowTitleBottom:
        default:
            [_btn setTitlePositionWithType:ButtonTitlePostionTypeBottom withSpacing:10];
            break;
    }
}

@end
