//
//  CommentList.h
//  HuWai
//
//  Created by WmVenusMac on 15-3-24.
//  Copyright (c) 2015年 xici. All rights reserved.
//

#import "BaseTableViewController.h"

@protocol CommentListDelegate <NSObject>

@optional
-(void)didGetCommentList;

@end

@interface CommentList : BaseTableViewController

@property(nonatomic, strong) id<CommentListDelegate> delegate;
@end
