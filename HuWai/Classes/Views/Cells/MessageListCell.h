//
//  MessageListCell.h
//  HuWai
//
//  Created by WmVenusMac on 15-1-30.
//  Copyright (c) 2015年 xici. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "RTLabel.h"
@interface MessageListCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (nonatomic, weak) IBOutlet RTLabel *describeLabel;

- (void)configureCellWithItem:(id)item atIndexPath:(NSIndexPath *)indexPath;

@end
