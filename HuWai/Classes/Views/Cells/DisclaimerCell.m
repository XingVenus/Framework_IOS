//
//  DisclaimerCell.m
//  HuWai
//
//  Created by WmVenusMac on 15-4-10.
//  Copyright (c) 2015年 xici. All rights reserved.
//

#import "DisclaimerCell.h"
#import "NSString+RectSize.h"

@implementation DisclaimerCell
{
    NSString *contentText;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(void)baseSetup
{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"disclaimer" ofType:@"txt"];
    NSError *error;
    contentText = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:&error];
    
    [self.contentView addSubview:self.disclaimerLabel];
    //set the web frame size
    
    self.disclaimerLabel.text = contentText;
}

-(TTTAttributedLabel *)disclaimerLabel
{
    if (!_disclaimerLabel) {
        _disclaimerLabel = [[TTTAttributedLabel alloc] initWithFrame:CGRectMake(5, 0, SCREEN_WIDTH - 5*2, 0)];
        _disclaimerLabel.numberOfLines = 0;
        _disclaimerLabel.lineSpacing = 2.0;
        _disclaimerLabel.font = [UIFont systemFontOfSize:14.0];
        _disclaimerLabel.textColor = [UIColor darkGrayColor];
    }
    return _disclaimerLabel;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    if (NSFoundationVersionNumber>NSFoundationVersionNumber_iOS_6_1) {
        self.backgroundColor = APP_BACKGROUND_COLOR;//RGBA(242, 242, 242, 1);
    }else{
        self.backgroundView = [[UIView alloc] initWithFrame:self.bounds];
        self.backgroundView.backgroundColor = APP_BACKGROUND_COLOR;//RGBA(242, 242, 242, 1);
    }
    self.contentView.backgroundColor = [UIColor whiteColor];
    self.disclaimerLabel.height = [contentText stringRectSizeWithfontSize:14 andWidth:SCREEN_WIDTH - 5*2 withLineSpacing:2].height;
}

//-(void)dealloc
//{
//    if (_WebView.loading)
//        [_WebView stopLoading];
//    
//    //deallocate web view
//    _WebView.delegate = nil;
//    _WebView = nil;
//}
@end
