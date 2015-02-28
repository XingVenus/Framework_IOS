//
//  EnrollMemberCell.h
//  HuWai
//
//  Created by WmVenusMac on 15-2-28.
//  Copyright (c) 2015年 xici. All rights reserved.
//

#import "BaseTableViewCell.h"

@interface EnrollMemberCell : BaseTableViewCell
@property (weak, nonatomic) IBOutlet UIButton *checkBtn;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *IDCardNo;
@property (weak, nonatomic) IBOutlet UILabel *sexLabel;

@end
