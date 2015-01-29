//
//  ActivityCell.h
//  HuWai
//
//  Created by WmVenusMac on 15-1-27.
//  Copyright (c) 2015年 xici. All rights reserved.
//

#import <UIKit/UIKit.h>
#define kHeghtRatio     1.7

@interface ActivityCell : UITableViewCell

@property (strong, nonatomic) UIImageView *backImageView;
@property (strong, nonatomic) UIImageView *avatarImageView;
@property (strong, nonatomic) UILabel *nickNameLabel;
@property (strong, nonatomic) UILabel *describeLabel;
@property (strong, nonatomic) UILabel *grayBackLabel;

- (void)configureCellWithItem:(id)item atIndexPath:(NSIndexPath *)indexPath;

@end
