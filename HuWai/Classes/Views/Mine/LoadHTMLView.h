//
//  LoadHTMLView.h
//  HuWai
//
//  Created by WmVenusMac on 15-4-9.
//  Copyright (c) 2015年 xici. All rights reserved.
//

#import "BaseViewController.h"

@interface LoadHTMLView : BaseViewController
{
    UIWebView	*theWebView;
}

@property (nonatomic, strong) NSString *urlString;

@end
