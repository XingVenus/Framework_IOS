//
//  PayView.h
//  HuWai
//
//  Created by WmVenusMac on 15-4-3.
//  Copyright (c) 2015年 xici. All rights reserved.
//

#import "BaseViewController.h"
#import "OrderDetailModel.h"

@interface PayView : BaseViewController<UIWebViewDelegate, UIActionSheetDelegate> {
    
    UIWebView	*theWebView;
    NSString	*urlString;
    UIActivityIndicatorView  *whirl;
    
}

-(void) updateToolbar;

@property (nonatomic, strong) NSString *urlString;
@property (nonatomic, strong) NSString *orderId;
@property (nonatomic, strong) OrderDetailModel *orderDetailModel;

@end
