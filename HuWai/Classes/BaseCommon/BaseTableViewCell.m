//
//  BaseTableViewCell.m
//  HuWai
//
//  Created by WmVenusMac on 15-2-3.
//  Copyright (c) 2015年 xici. All rights reserved.
//

#import "BaseTableViewCell.h"

@implementation BaseTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [self baseSetup];
    }
    return self;
}

#pragma mark override this method for init tableviewcell
- (void)baseSetup {
    
}

-(void)setLayerLineAndBackground
{
    self.contentView.layer.shouldRasterize = YES;
    self.contentView.layer.rasterizationScale = [[UIScreen mainScreen] scale];
    
    if (NSFoundationVersionNumber>NSFoundationVersionNumber_iOS_6_1) {
        self.backgroundColor = APP_BACKGROUND_COLOR;//RGBA(242, 242, 242, 1);
    }else{
        self.backgroundView = [[UIView alloc] initWithFrame:self.bounds];
        self.backgroundView.backgroundColor = APP_BACKGROUND_COLOR;//RGBA(242, 242, 242, 1);
    }
    self.contentView.backgroundColor = [UIColor whiteColor];
    
    if (!_topLayer) {
        _topLayer = [CALayer layer];
        _topLayer.backgroundColor = APP_DIVIDELINE_COLOR.CGColor;
        [self.contentView.layer addSublayer:_topLayer];
    }
    _topLayer.frame = CGRectMake(0, 0, SCREEN_WIDTH, 0.5);
    if (!_bottomLayer) {
        _bottomLayer = [CALayer layer];
        _bottomLayer.backgroundColor = APP_DIVIDELINE_COLOR.CGColor;
        [self.contentView.layer addSublayer:_bottomLayer];
    }
    _bottomLayer.frame = CGRectMake(0, self.contentView.bounds.size.height, SCREEN_WIDTH, 0.5);
    
    
}
#pragma mark override this method for data fill
-(void)configureCellWithItem:(id)item atIndexPath:(NSIndexPath *)indexPath
{
    
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


@end
