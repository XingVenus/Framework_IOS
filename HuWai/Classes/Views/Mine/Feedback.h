//
//  Feedback.h
//  HuWai
//
//  Created by WmVenusMac on 15-2-3.
//  Copyright (c) 2015年 xici. All rights reserved.
//

#import "BaseViewController.h"
#import "GCPlaceholderTextView.h"

@interface Feedback : BaseViewController
@property (nonatomic, strong) IBOutlet GCPlaceholderTextView *feedBackTextView;

-(IBAction)submitFeedBack:(id)sender;
@end
