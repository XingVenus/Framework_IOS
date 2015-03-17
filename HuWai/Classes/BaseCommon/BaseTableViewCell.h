//
//  BaseTableViewCell.h
//  HuWai
//
//  Created by WmVenusMac on 15-2-3.
//  Copyright (c) 2015年 xici. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseTableViewCell : UITableViewCell


@property (nonatomic, strong) CALayer *topLayer;
@property (nonatomic, strong) CALayer *bottomLayer;

- (void)baseSetup;
- (void)configureCellWithItem:(id)item atIndexPath:(NSIndexPath *)indexPath;
-(void)setLayerLineAndBackground;
@end
