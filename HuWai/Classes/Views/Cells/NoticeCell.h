//
//  NoticeCell.h
//  HuWai
//
//  Created by WmVenusMac on 15-3-24.
//  Copyright (c) 2015年 xici. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "UserMessageModel.h"
#define AvalibleWidth   SCREEN_WIDTH - 10*2

@interface NoticeCell : BaseTableViewCell

@property (nonatomic ,strong) TTTAttributedLabel *titleLabel;
@property (nonatomic ,strong) TTTAttributedLabel *contentLabel;
@property (nonatomic ,strong) UILabel *fromLabel;
@property (nonatomic ,strong) UILabel *timeLabel;

+ (CGFloat)heightForCellWithText:(MessageInfo *)item availableWidth:(CGFloat)availableWidth;
@end
