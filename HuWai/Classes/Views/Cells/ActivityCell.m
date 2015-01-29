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
        _backImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH-10*2, (SCREEN_WIDTH-20)/kHeghtRatio)];
    }
    return _backImageView;
}

-(UILabel *)grayBackLabel
{
    if (!_grayBackLabel) {
        _grayBackLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(self.backImageView.frame) - 60, SCREEN_WIDTH-10*2, 60)];
        _grayBackLabel.backgroundColor = [UIColor colorWithWhite:0.3 alpha:.7];
    }
    return _grayBackLabel;
}

-(UIImageView *)avatarImageView
{
    if (!_avatarImageView) {
        _avatarImageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(self.backImageView.frame) - 100 , 50, 50)];
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

-(UILabel *)describeLabel
{
    if (!_describeLabel) {
        _describeLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(self.grayBackLabel.frame) - 45, SCREEN_WIDTH - 25*2, 0)];
        _describeLabel.backgroundColor = [UIColor clearColor];
        _describeLabel.numberOfLines = 2;
        _describeLabel.lineBreakMode = NSLineBreakByWordWrapping;
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

    self.describeLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [self.describeLabel sizeToFit];

}

-(void)configureCellWithItem:(id)item atIndexPath:(NSIndexPath *)indexPath
{
    self.backImageView.image = [UIImage imageNamed:@"activities-img"];
    self.avatarImageView.image = [UIImage imageNamed:@"avatar"];
    self.nickNameLabel.text = @"hhahahhahhah";
    self.describeLabel.text = @"以习近平为总书记的党中央深改元年工作述评以习近平为总书记的党中央深改元年工作述评以习近平为总书记的党中央深改元年工作述评";
}

@end
