//
//  PayView.h
//  HuWai
//
//  Created by WmVenusMac on 15-4-3.
//  Copyright (c) 2015年 xici. All rights reserved.
//

#import "BaseViewController.h"

@interface PayView : BaseViewController<UIWebViewDelegate, UIActionSheetDelegate> {
    
    UIWebView	*theWebView;
    NSString	*urlString;
    UIActivityIndicatorView  *whirl;
    
}

-(void) updateToolbar;

@property (nonatomic, strong) NSString *urlString;

@end
