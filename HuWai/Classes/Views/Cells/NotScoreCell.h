//
//  notScoreCell.h
//  HuWai
//
//  Created by WmVenusMac on 15-2-2.
//  Copyright (c) 2015年 xici. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseTableViewCell.h"
#import "EDStarRating.h"

@interface ScoreCellView : UIView

@end

@interface NotScoreCell : BaseTableViewCell

@property (nonatomic, strong) ScoreCellView *scoreBackView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *subTitleLabel;
@property (nonatomic, strong) RTLabel *describeLabel;

@property (nonatomic, strong) UILabel *selectLabel1;
@property (nonatomic, strong) UILabel *selectLabel2;

@property (nonatomic, strong) UIButton *scoreButton;

@property (nonatomic, strong) EDStarRating  *starControl1;
@property (nonatomic, strong) EDStarRating  *starControl2;



@end

