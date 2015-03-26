//
//  FAQ.h
//  HuWai
//
//  Created by WmVenusMac on 15-3-25.
//  Copyright (c) 2015年 xici. All rights reserved.
//

#import "BaseViewController.h"
#import "GCPlaceholderTextView.h"

@protocol FAQDelegate <NSObject>

@optional
-(void)didSubmitFAQ;

@end

@interface FAQ : BaseViewController

@property (nonatomic, weak) id<FAQDelegate> delegate;
@property (nonatomic, strong) NSString *actID;
@property (nonatomic, strong) IBOutlet GCPlaceholderTextView *textView;

-(IBAction)submitFAQ:(id)sender;
@end
