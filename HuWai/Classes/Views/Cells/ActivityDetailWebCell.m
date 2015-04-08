//
//  ActivityDetailWebCell.m
//  HuWai
//
//  Created by WmVenusMac on 15-4-8.
//  Copyright (c) 2015年 xici. All rights reserved.
//

#import "ActivityDetailWebCell.h"

static NSString *detailUrl = @"http://xx.huwai.ixici.info/activity/get?actid=%@";
static CGFloat webHeight;

@implementation ActivityDetailWebCell

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(void)baseSetup
{
    //set the web frame size
    CGRect webFrame = [[UIScreen mainScreen] applicationFrame];
    webFrame.origin.y = 0;
    
    //add the web view
    if (!_WebView) {
        _WebView = [[UIWebView alloc] initWithFrame:webFrame];
        //    WebView.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
        _WebView.backgroundColor = [UIColor whiteColor];
        _WebView.scalesPageToFit = YES;
        _WebView.scrollView.bounces = NO;
    }
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
}

-(void)configureCellWithItem:(id)item atIndexPath:(NSIndexPath *)indexPath
{
    NSString *weburl = [NSString stringWithFormat:detailUrl,(NSString *)item];
    DLog(@"%@",weburl);
    NSURL *url = [NSURL URLWithString:weburl];
    NSURLRequest *req = [NSURLRequest requestWithURL:url];
    [_WebView loadRequest:req];
    
    [self.contentView addSubview: _WebView];
}

-(void)dealloc
{
    if (_WebView.loading)
        [_WebView stopLoading];
    
    //deallocate web view
    _WebView.delegate = nil;
    _WebView = nil;
}
@end
