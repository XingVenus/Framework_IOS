//
//  hasScoreCell.h
//  HuWai
//
//  Created by WmVenusMac on 15-2-2.
//  Copyright (c) 2015年 xici. All rights reserved.
//

#import "BaseTableViewCell.h"
@interface HasScoreCellView : UIView

@end

@interface HasScoreCell : BaseTableViewCell

@property (nonatomic, strong) HasScoreCellView *hasScoreBackView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *subTitleLabel;
@property (nonatomic, strong) TTTAttributedLabel *describeLabel;
@property (nonatomic, strong) UILabel *scoreLabel;

@end
