//
//  ActivityDetail.m
//  HuWai
//
//  Created by WmVenusMac on 15-1-29.
//  Copyright (c) 2015年 xici. All rights reserved.
//

#import "ActivityDetail.h"
#import "ActivityDetailModel.h"
#import "MaskedPageView.h"
#import "HMSegmentedControl.h"

@interface ActivityDetail ()
{
    TitleAndPriceView *titleAndPrice;
    UIButton *favoriteBtn;
    UIButton *shareBtn;
}

@property (nonatomic, strong) MaskedPageView *maskPageView;
//@property (nonatomic, strong) RTLabel *titleLabel;//标题label
@property (nonatomic, strong) RTLabel *overdueLabel;//倒计时label

@property (nonatomic, strong) HMSegmentedControl *segmentControl;

@end

@implementation ActivityDetail

- (void)viewDidLoad {
    [super viewDidLoad];
    //图片列表
    UIView *headerView = [[UIView alloc] init];
    self.maskPageView = [[MaskedPageView alloc] initWithFrame:CGRectMake(0, 10, SCREEN_WIDTH, SCREEN_WIDTH/1.7)];

    titleAndPrice = [[TitleAndPriceView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.maskPageView.frame)+10, SCREEN_WIDTH, 70)];
    titleAndPrice.backgroundColor = [UIColor whiteColor];
    [headerView addSubview:self.maskPageView];
    [headerView addSubview:titleAndPrice];
    headerView.frame = CGRectMake(0, 0, SCREEN_WIDTH, CGRectGetHeight(self.maskPageView.frame)+70+30);
    self.tableView.tableHeaderView = headerView;
    
    [self postAppendUriActionWithHUD:ActivityDetailAction withValue:self.activityId message:@"正在加载..." params:nil];
    //收藏按钮
    favoriteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    favoriteBtn.frame = CGRectMake(0, 0, 30, 35);
    [favoriteBtn addTarget:self action:@selector(favoriteAction:) forControlEvents:UIControlEventTouchUpInside];
    [favoriteBtn setImage:[UIImage imageNamed:@"collection"] forState:UIControlStateNormal];
    [favoriteBtn setImage:[UIImage imageNamed:@"collection-mutual"] forState:UIControlStateSelected];
    //分享按钮
    shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [shareBtn addTarget:self action:@selector(shareAction:) forControlEvents:UIControlEventTouchUpInside];
    shareBtn.frame = CGRectMake(0, 0, 30, 35);
    [shareBtn setImage:[UIImage imageNamed:@"share"] forState:UIControlStateNormal];
    UIBarButtonItem *r1 = [[UIBarButtonItem alloc] initWithCustomView:favoriteBtn];
    UIBarButtonItem *r2 = [[UIBarButtonItem alloc] initWithCustomView:shareBtn];
    self.navigationItem.rightBarButtonItems = @[r2,r1];
    // Do any additional setup after loading the view.
}

-(void)onRequestFinished:(HttpRequestAction)tag response:(Response *)response
{
    if (response.code == 20000) {
        if (tag == ActivityDetailAction) {
            ActivityDetailModel *detailModel = [[ActivityDetailModel alloc] initWithJsonDict:response.data];
            //数据填充
            [self fillDataHeaderView:detailModel];
        }else if (tag == AddFavoriteAction){
            [favoriteBtn setSelected:YES];
        }else if (tag == CancelFavoriteAction){
            [favoriteBtn setSelected:NO];
        }
    }
    [self showMessageWithThreeSecondAtCenter:response.message];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
   
}
#pragma mark - custom methon implement
-(void)favoriteAction:(UIButton *)sender
{
    if (sender.isSelected) {
        [self postActionWithHUD:CancelFavoriteAction params:@"id",self.activityId,nil];
    }else{
        [self postActionWithHUD:AddFavoriteAction params:@"id",self.activityId,nil];
    }
    
}

-(void)shareAction:(UIButton *)sender
{
    
}

-(void)fillDataHeaderView:(ActivityDetailModel *)data
{
    if (data.isFavorite) {
        [favoriteBtn setSelected:YES];
    }
    [self.maskPageView fillDataWithImagesArray:data.flash];
    //标题价格数据
    [titleAndPrice setDataInViews:data];
    
}
#pragma mark - tableview method

-(HMSegmentedControl *)segmentControl
{
    if (!_segmentControl) {
        _segmentControl = [[HMSegmentedControl alloc] initWithSectionTitles:@[@"详情",@"领队",@"问答",@"声明"]];
        _segmentControl.showBorderLine = YES;
        _segmentControl.frame = CGRectMake(0, 0, SCREEN_WIDTH, 45);
        _segmentControl.backgroundColor = [UIColor whiteColor];
        _segmentControl.textColor = [UIColor blackColor];
        _segmentControl.selectionIndicatorColor = [UIColor colorWithRed:46/255.0 green:181/255.0 blue:220/255.0 alpha:1];
        _segmentControl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
        _segmentControl.selectedTextColor = [UIColor colorWithRed:46/255.0 green:181/255.0 blue:220/255.0 alpha:1];
        _segmentControl.selectionStyle = HMSegmentedControlSelectionStyleFullWidthStripe;
        WEAKSELF;
        [_segmentControl setIndexChangeBlock:^(NSInteger index) {
            DLog(@"selected index is:%d",index);
            [weakSelf.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationLeft];
        }];
    }
    return _segmentControl;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 45;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return self.segmentControl;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identity = @"detailCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identity];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identity];
    }
    return cell;
}
@end

@interface TitleAndPriceView()
@property (nonatomic, strong) RTLabel *titleLabel;
@property (nonatomic, strong) RTLabel *priceLabel;
@end

@implementation TitleAndPriceView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.titleLabel];
        [self addSubview:self.priceLabel];
    }
    return self;
}

-(void)drawRect:(CGRect)rect
{
    CALayer *verticalDividerLayer = [CALayer layer];
    verticalDividerLayer.frame = CGRectMake(SCREEN_WIDTH - 100, 10, 1, 50);
    verticalDividerLayer.backgroundColor = [UIColor lightGrayColor].CGColor;
    [self.layer addSublayer:verticalDividerLayer];
    
    CALayer *topLayer = [CALayer layer];
    topLayer.frame = CGRectMake(0, 0, SCREEN_WIDTH, 0.5);
    topLayer.backgroundColor = [UIColor lightGrayColor].CGColor;
    CALayer *bottomLayer = [CALayer layer];
    bottomLayer.frame = CGRectMake(0, self.bounds.size.height, SCREEN_WIDTH, 0.5);
    bottomLayer.backgroundColor = [UIColor lightGrayColor].CGColor;
    [self.layer addSublayer:topLayer];
    [self.layer addSublayer:bottomLayer];
}

-(RTLabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[RTLabel alloc] initWithFrame:CGRectMake(15, 10, SCREEN_WIDTH - 100 - 15*2, 44)];
        _titleLabel.lineSpacing = 8.0;
        _titleLabel.lineBreakMode = RTTextLineBreakModeWordWrapping;
        _titleLabel.centerY = self.height/2;
    }
    return _titleLabel;
}

-(RTLabel *)priceLabel
{
    if (!_priceLabel) {
        _priceLabel = [[RTLabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 90, 0, 80, 30)];
        _priceLabel.centerY = self.height/2;
        
        _priceLabel.textAlignment = RTTextAlignmentRight;
    }
    return _priceLabel;
}

-(void)setDataInViews:(ActivityDetailModel *)model
{
    self.titleLabel.text = model.title;
    self.priceLabel.text = model.price;
    
    [self setNeedsDisplay];
}
@end
