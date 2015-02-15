//
//  ActivityCell.m
//  HuWai
//
//  Created by WmVenusMac on 15-1-27.
//  Copyright (c) 2015年 xici. All rights reserved.
//

#import "ActivityCell.h"

@implementation ActivityCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [self.contentView addSubview:self.backImageView];
//        self.backgroundView = self.backImageView;
        [self.contentView addSubview:self.priceBtn];
        [self.contentView addSubview:self.grayBackLabel];
        [self.contentView addSubview:self.avatarImageView];
        [self.contentView addSubview:self.nickNameLabel];
        [self.contentView addSubview:self.describeLabel];
    }
    return self;
}

-(UIImageView *)backImageView
{
    if (!_backImageView) {
        _backImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 5, SCREEN_WIDTH-10*2, (SCREEN_WIDTH-20)/kHeghtRatio)];
    }
    return _backImageView;
}

-(UIButton *)priceBtn
{
    if (!_priceBtn) {
        _priceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_priceBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _priceBtn.titleLabel.font = [UIFont boldSystemFontOfSize:14.0];
        [_priceBtn setShowsTouchWhenHighlighted:NO];
        [_priceBtn setAdjustsImageWhenHighlighted:NO];
        [_priceBtn setBackgroundImage:[UIImage imageNamed:@"price-bg"] forState:UIControlStateNormal];
        _priceBtn.frame = CGRectMake(SCREEN_WIDTH - 96, 30, 76, 25);
    }
    return _priceBtn;
}

-(UILabel *)grayBackLabel
{
    if (!_grayBackLabel) {
        _grayBackLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.backImageView.frame) - 60, SCREEN_WIDTH-10*2, 60)];
        _grayBackLabel.backgroundColor = [UIColor colorWithWhite:0.3 alpha:.7];
    }
    return _grayBackLabel;
}

-(PAAImageView *)avatarImageView
{
    if (!_avatarImageView) {
        _avatarImageView = [[PAAImageView alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(self.backImageView.frame) - 100 , 50, 50) backgroundProgressColor:[UIColor whiteColor] progressColor:[UIColor whiteColor]];
    }
    return _avatarImageView;
}

-(UILabel *)nickNameLabel
{
    if (!_nickNameLabel) {
        _nickNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(75, CGRectGetMidY(self.avatarImageView.frame) - 10, 150, 21)];
        _nickNameLabel.backgroundColor = [UIColor clearColor];
        _nickNameLabel.font = [UIFont boldSystemFontOfSize:17.0];
        _nickNameLabel.textColor = [UIColor whiteColor];
    }
    return _nickNameLabel;
}

-(RTLabel *)describeLabel
{
    if (!_describeLabel) {
        _describeLabel = [[RTLabel alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(self.grayBackLabel.frame) - 50, SCREEN_WIDTH - 25*2, 40)];
        _describeLabel.lineSpacing = 8.0;
        _describeLabel.backgroundColor = [UIColor clearColor];
        _describeLabel.font = [UIFont boldSystemFontOfSize:14.0];
        _describeLabel.textColor = [UIColor whiteColor];
    }
    return _describeLabel;
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)layoutSubviews
{
//    [super layoutSubviews];
    self.contentView.frame = CGRectInset(self.bounds, 10, 5);
}

-(void)configureCellWithItem:(ActivityInfo *)item atIndexPath:(NSIndexPath *)indexPath
{
    [self.backImageView sd_setImageWithURL:[NSURL URLWithString:item.image] placeholderImage:nil];
    self.avatarImageView.placeHolderImage = [UIImage imageNamed:@"avatar"];
    [self.avatarImageView setImageURL:[NSURL URLWithString:item.avatar]];
    self.nickNameLabel.text = item.username;
    self.describeLabel.text = item.title;
    [self.priceBtn setTitle:[item.price stringByAppendingString:@"元"] forState:UIControlStateNormal];

}

@end
