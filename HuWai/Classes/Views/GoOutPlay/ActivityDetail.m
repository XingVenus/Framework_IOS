//
//  ActivityDetail.m
//  HuWai
//
//  Created by WmVenusMac on 15-1-29.
//  Copyright (c) 2015年 xici. All rights reserved.
//

#import "ActivityDetail.h"
#import "ActivityDetailModel.h"
#import "FAQModel.h"
#import "MaskedPageView.h"
#import "HMSegmentedControl.h"
#import "Enroll.h"

#import "LeaderDetailCell.h"
#import "ActivityDetailCell.h"
#import "FAQ.h"
#import "FAQCell.h"
#import "UMSocial.h"
#import "ActivityDetailWebCell.h"

#import "DisclaimerCell.h"
#import "NSString+RectSize.h"

static inline NSRegularExpression * NumbersRegularExpression() {
    static NSRegularExpression *_regularExpression = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _regularExpression = [[NSRegularExpression alloc] initWithPattern:@"\\d+" options:NSRegularExpressionCaseInsensitive error:nil];
    });
    
    return _regularExpression;
}

@interface ActivityDetail ()<FAQDelegate,UMSocialUIDelegate,UIWebViewDelegate>
{
    TitleAndPriceView *titleAndPrice;
    UIButton *favoriteBtn;
    UIButton *shareBtn;
    ActivityDetailModel *detailModel;
    FAQModel *faqModel; //问答数据模型
    FAQ *faqController; //问答视图
    
    UIButton *subscribeBtn;
    
    CGFloat webCellHeight;
}

@property (nonatomic, strong) MaskedPageView *maskPageView;
//@property (nonatomic, strong) RTLabel *titleLabel;//标题label
@property (nonatomic, weak) IBOutlet TTTAttributedLabel *overdueLabel;//倒计时label
@property (nonatomic, strong) UIButton *faqBtn;   //问答提问按钮

@property (nonatomic, strong) HMSegmentedControl *segmentControl;
@property (weak, nonatomic) IBOutlet UIButton *signupBtn;

@end

@implementation ActivityDetail

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor whiteColor];
    //图片列表
    UIView *headerView = [[UIView alloc] init];
    self.maskPageView = [[MaskedPageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH/1.7)];

    titleAndPrice = [[TitleAndPriceView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.maskPageView.frame)+10, SCREEN_WIDTH, 70)];
    titleAndPrice.backgroundColor = [UIColor whiteColor];
    [headerView addSubview:self.maskPageView];
    [headerView addSubview:titleAndPrice];
    headerView.frame = CGRectMake(0, 0, SCREEN_WIDTH, CGRectGetHeight(self.maskPageView.frame)+70+20);
    self.tableView.tableHeaderView = headerView;
    
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
    self.navigationItem.rightBarButtonItems = @[r1];
    // Do any additional setup after loading the view.
    //问答按钮
    self.faqBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.faqBtn.frame = CGRectMake(SCREEN_WIDTH - 70, SCREEN_HEIGHT - 120, 50, 50);
    [self.faqBtn setImage:[UIImage imageNamed:@"quiz"] forState:UIControlStateNormal];
    [self.faqBtn addTarget:self action:@selector(openFaqView:) forControlEvents:UIControlEventTouchUpInside];
    self.faqBtn.hidden = YES;
    [self.view addSubview:self.faqBtn];
    //加载页面数据
    [self loadDataSource];
    //获取问答列表数据
    [self loadFAQList];
}

-(void)loadDataSource
{
    [self loadActionWithHUD:ActivityDetailAction message:@"正在加载..." params:@"id",self.activityId,nil];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [MobClick beginLogPageView:self.title];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:self.title];
}

#pragma mark 获取问答列表数据
-(void)loadFAQList
{
    [self loadAction:ActivityFAQAction params:@"id",self.activityId,nil];
}

#pragma mark - request response data
-(void)onRequestFinished:(HttpRequestAction)tag response:(Response *)response
{
    if (tag == ActivityDetailAction) {
        detailModel = [[ActivityDetailModel alloc] initWithJsonDict:response.data];
        //数据填充
        [self fillDataHeaderView:detailModel];
        [self.tableView reloadData];
    }else if (tag == AddFavoriteAction){
        [favoriteBtn setSelected:YES];
    }else if (tag == CancelFavoriteAction){
        [favoriteBtn setSelected:NO];
        if (_delegate && [_delegate respondsToSelector:@selector(didCancelCollected)]) {
            [_delegate didCancelCollected];
        }
    }else if (tag == ActivityFAQAction){
        self.hideShowMessage = YES;
        faqModel = [[FAQModel alloc] initWithJsonDict:response.data];
        if (_segmentControl.selectedSegmentIndex == 2) {
            [self.tableView reloadData];
        }
    }else if (tag == RssAddAction){
        [subscribeBtn setSelected:YES];
    }else if (tag == RssCancelAction){
        [subscribeBtn setSelected:NO];
        if (_delegate && [_delegate respondsToSelector:@selector(didCancelSubscribe)]) {
            [_delegate didCancelSubscribe];
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc
{
    faqController.delegate = nil;
}
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"enroll"]) {
        [MobClick event:@"baoming1"];
        BaseNavigationController *enrollNavController = segue.destinationViewController;
        Enroll *enrollView = (Enroll *)enrollNavController.topViewController;
        [APPInfo shareInit].payFromType = @"enroll";
        enrollView.activityID = self.activityId;
    }else if ([segue.identifier isEqualToString:@"faq"]){
        faqController = segue.destinationViewController;
        faqController.delegate = self;
        faqController.actID = self.activityId;
    }
}

#pragma mark faq delegate
-(void)didSubmitFAQ
{
    [self loadFAQList];
}

#pragma mark - custom methon implement
-(void)favoriteAction:(UIButton *)sender
{
    [MobClick event:@"h_sc"];
    if (sender.isSelected) {
        [self postActionWithHUD:CancelFavoriteAction params:@"id",self.activityId,nil];
    }else{
        [self postActionWithHUD:AddFavoriteAction params:@"id",self.activityId,nil];
    }
    
}

-(void)shareAction:(UIButton *)sender
{
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:UM_SOCIAL_KEY
                                      shareText:@"友盟社会化分享让您快速实现分享等社会化功能，http://umeng.com/social"
                                     shareImage:nil
                                shareToSnsNames:[NSArray arrayWithObjects:UMShareToSina,UMShareToQzone,UMShareToWechatSession,UMShareToWechatTimeline,nil]
                                       delegate:self];
}

-(BOOL)isDirectShareInIconActionSheet
{
    return YES;
}

-(void)didFinishGetUMSocialDataInViewController:(UMSocialResponseEntity *)response
{
    //根据`responseCode`得到发送结果,如果分享成功
    if(response.responseCode == UMSResponseCodeSuccess)
    {
        //得到分享到的微博平台名
        NSLog(@"share to sns name is %@",[[response.data allKeys] objectAtIndex:0]);
    }
}

-(void)fillDataHeaderView:(ActivityDetailModel *)data
{
    if (data.isFavorite) {
        [favoriteBtn setSelected:YES];
    }
    [self.maskPageView fillDataWithImagesArray:data.flash];
    //标题价格数据
    [titleAndPrice setDataInViews:data];
    //活动倒计时显示
    int starttime = [data.starttime intValue];
    int endtime = [data.endtime intValue];
    int dateline = [data.dateline intValue];
    if (dateline>=starttime && dateline<=endtime) {
        int secs = endtime - dateline;
        [self countDown:secs];
    }else{
        [self setActivityOverdueText:@"活动已经结束,请关注下次活动"];
        [self.signupBtn setEnabled:NO];
    }

}

#pragma mark 打开问答页面
-(void)openFaqView:(UIButton *)sender
{
    [self performSegueWithIdentifier:@"faq" sender:self];
}

#pragma mark -
#pragma mark 倒计时
-(void)countDown:(int)secs{
    WEAKSELF;
    __block int timeout = secs; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout<=0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                [weakSelf setActivityOverdueText:@"活动已经结束,请关注下次活动"];
            });
        }else{
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的显示 根据自己需求设置
                [weakSelf changeOverduelabelText:timeout];
            });
            timeout--;
        }
    });
    dispatch_resume(_timer);
}

#pragma mark 设置倒计时文字
-(void)changeOverduelabelText:(int)secs
{
    int hours = (int)secs / 3600; //总共的小时
    int minutes = (int)secs / 60 % 60; //分钟
    int seconds = (int)secs % 60; //秒
    
    NSString *overString = [NSString stringWithFormat:@"距离报名结束还有\n%i小时%.2d分%.2d秒",hours,minutes,seconds];
    [self.overdueLabel setText:overString afterInheritingLabelAttributesAndConfiguringWithBlock:^NSMutableAttributedString *(NSMutableAttributedString *mutableAttributedString) {
        NSRange stringRange = NSMakeRange(0, [mutableAttributedString length]);
        NSRegularExpression *regexp = NumbersRegularExpression();
        
        [regexp enumerateMatchesInString:[mutableAttributedString string] options:0 range:stringRange usingBlock:^(NSTextCheckingResult *result, NSMatchingFlags flags, BOOL *stop) {
            // Core Text APIs use C functions without a direct bridge to UIFont. See Apple's "Core Text Programming Guide" to learn how to configure string attributes.
            UIFont *boldSystemFont = [UIFont boldSystemFontOfSize:18];
            CTFontRef font = CTFontCreateWithName((__bridge CFStringRef)boldSystemFont.fontName, boldSystemFont.pointSize, NULL);
            if (font) {
                [mutableAttributedString addAttribute:(NSString *)kCTFontAttributeName value:(__bridge id)font range:result.range];
                [mutableAttributedString addAttribute:(NSString *)kCTForegroundColorAttributeName value:(__bridge id)[[UIColor orangeColor] CGColor] range:result.range];
                CFRelease(font);
            }
        }];
        
        return mutableAttributedString;
    }];
}
#pragma mark 设置过期文字显示
-(void)setActivityOverdueText:(NSString *)string
{
//    self.overdueLabel.text = string;
    [self.overdueLabel setText:string afterInheritingLabelAttributesAndConfiguringWithBlock:^NSMutableAttributedString *(NSMutableAttributedString *mutableAttributedString) {
        NSRange resultRange = [[mutableAttributedString string] rangeOfString:string options:NSRegularExpressionSearch];
        
        UIFont *boldSystemFont = [UIFont boldSystemFontOfSize:16];
        CTFontRef font = CTFontCreateWithName((__bridge CFStringRef)boldSystemFont.fontName, boldSystemFont.pointSize, NULL);
        if (font) {
            [mutableAttributedString addAttribute:(NSString *)kCTFontAttributeName value:(__bridge id)font range:resultRange];
            [mutableAttributedString addAttribute:(NSString *)kCTForegroundColorAttributeName value:(__bridge id)[[UIColor grayColor] CGColor] range:resultRange];
            CFRelease(font);
        }
        return mutableAttributedString;
    }];
    
}

-(void)subscribeAction:(UIButton *)sender
{
    [MobClick event:@"h_dy"];
    if (sender.selected) {
        [self postActionWithHUD:RssCancelAction params:@"id",detailModel.aid,nil];
    }else{
        [self postActionWithHUD:RssAddAction params:@"id",detailModel.aid,nil];
    }
}
#pragma mark 切换标签segment
-(HMSegmentedControl *)segmentControl
{
    if (!_segmentControl) {
        _segmentControl = [[HMSegmentedControl alloc] initWithSectionTitles:@[@"详情",@"领队",@"问答",@"声明"]];
        _segmentControl.font = [UIFont systemFontOfSize:15.0];
        _segmentControl.showBorderLine = YES;
        _segmentControl.borderLineColor = APP_DIVIDELINE_COLOR;
        _segmentControl.frame = CGRectMake(0, 0, SCREEN_WIDTH, 45);
        _segmentControl.backgroundColor = [UIColor whiteColor];
        _segmentControl.textColor = [UIColor darkGrayColor];
        _segmentControl.selectionIndicatorColor = [UIColor colorWithRed:46/255.0 green:181/255.0 blue:220/255.0 alpha:1];
        _segmentControl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
        _segmentControl.selectedTextColor = [UIColor colorWithRed:46/255.0 green:181/255.0 blue:220/255.0 alpha:1];
        _segmentControl.selectionStyle = HMSegmentedControlSelectionStyleFullWidthStripe;
        WEAKSELF;
        [_segmentControl setIndexChangeBlock:^(NSInteger index) {
            DLog(@"selected index is:%d",(int)index);
            if (index == 2) {
                weakSelf.faqBtn.hidden = NO;
            }else{
                weakSelf.faqBtn.hidden = YES;
            }
            [weakSelf.tableView reloadData];
        }];
    }
    return _segmentControl;
}

#pragma mark - tableview method
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
    
    if(faqModel.data.count>0 && _segmentControl.selectedSegmentIndex == 2){
        return faqModel.data.count;
    }else if (_segmentControl.selectedSegmentIndex != 2 && detailModel) {
        return 1;
    }
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_segmentControl.selectedSegmentIndex == 2 && faqModel.data.count>0) {
        return [FAQCell heightForCellWithText:faqModel.data[indexPath.row] availableWidth:0];
    }else if(_segmentControl.selectedSegmentIndex == 1){
        return SCREEN_HEIGHT - 64 - 45 - 50;
    }else if (_segmentControl.selectedSegmentIndex == 3){
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"disclaimer" ofType:@"txt"];
        NSError *error;
        NSString *content = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:&error];
        return [content stringRectSizeWithfontSize:14 andWidth:SCREEN_WIDTH - 5*2 withLineSpacing:2].height;
    }else{
        CGFloat screenCellheight = SCREEN_HEIGHT - 64 - 45 - 50;
        if (webCellHeight>screenCellheight) {
            return webCellHeight;
        }else{
            return screenCellheight;
        }
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    NSInteger section = [indexPath section];
    if (_segmentControl.selectedSegmentIndex == 0) {
        /*
        ActivityDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"activitydetailcell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell configureCellWithItem:detailModel.detail atIndexPath:indexPath];
         */
        static NSString *identifier1 = @"webdetailcell";
        ActivityDetailWebCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier1];
        if (!cell) {
            cell = [[ActivityDetailWebCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier1];
        }
        cell.WebView.delegate = self;
        [cell configureCellWithItem:detailModel.aid atIndexPath:indexPath];
        return cell;
    }else if (_segmentControl.selectedSegmentIndex == 1) {
        LeaderDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"leaderdetailcell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        subscribeBtn = cell.subscribeActivityBtn;
        [subscribeBtn addTarget:self action:@selector(subscribeAction:) forControlEvents:UIControlEventTouchUpInside];
        if (detailModel.isRss) {
//            [subscribeBtn setTitle:@"取消订阅" forState:UIControlStateNormal];
            [subscribeBtn setSelected:YES];
        }
        [cell configureCellWithItem:detailModel.leader atIndexPath:indexPath];
        return cell;
    }else if(_segmentControl.selectedSegmentIndex == 2){
        static NSString *identity = @"faqlistCell";
        FAQCell *cell = [tableView dequeueReusableCellWithIdentifier:identity];
        if (!cell) {
            cell = [[FAQCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identity];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        [cell configureCellWithItem:faqModel.data[indexPath.row] atIndexPath:indexPath];
        return cell;
    }else if (_segmentControl.selectedSegmentIndex == 3){
        static NSString *identity = @"declareCell";
        DisclaimerCell *cell = [tableView dequeueReusableCellWithIdentifier:identity];
        if (!cell) {
            cell = [[DisclaimerCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identity];
        }
        return cell;
    }
    return nil;
}

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    CGFloat height = [[webView stringByEvaluatingJavaScriptFromString:@"document.body.scrollHeight"] floatValue];
    webCellHeight = height;
    webView.height = height;
    [self.tableView beginUpdates];
    [self.tableView endUpdates];
}
@end

@interface TitleAndPriceView()
@property (nonatomic, strong) TTTAttributedLabel *titleLabel;
@property (nonatomic, strong) TTTAttributedLabel *priceLabel;
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
    verticalDividerLayer.frame = CGRectMake(SCREEN_WIDTH - 120, 10, 1, 50);
    verticalDividerLayer.backgroundColor = APP_DIVIDELINE_COLOR.CGColor;
    [self.layer addSublayer:verticalDividerLayer];
    
    CALayer *topLayer = [CALayer layer];
    topLayer.frame = CGRectMake(0, 0, SCREEN_WIDTH, 0.5);
    topLayer.backgroundColor = APP_DIVIDELINE_COLOR.CGColor;
    CALayer *bottomLayer = [CALayer layer];
    bottomLayer.frame = CGRectMake(0, self.bounds.size.height, SCREEN_WIDTH, 0.5);
    bottomLayer.backgroundColor = APP_DIVIDELINE_COLOR.CGColor;
    [self.layer addSublayer:topLayer];
    [self.layer addSublayer:bottomLayer];
}

-(TTTAttributedLabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[TTTAttributedLabel alloc] initWithFrame:CGRectMake(15, 10, SCREEN_WIDTH - 120 - 15*2, 44)];
        _titleLabel.lineSpacing = 5.0;
        _titleLabel.textColor = [UIColor darkGrayColor];
        _titleLabel.font = [UIFont systemFontOfSize:14.0];
        _titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
        _titleLabel.numberOfLines = 0;
        _titleLabel.centerY = self.height/2;
    }
    return _titleLabel;
}

-(TTTAttributedLabel *)priceLabel
{
    if (!_priceLabel) {
        _priceLabel = [[TTTAttributedLabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 110 - 10, 0, 110, 30)];
        _priceLabel.centerY = self.height/2;
        _priceLabel.textColor = [UIColor darkGrayColor];
        _priceLabel.font = [UIFont systemFontOfSize:12.0];
        _priceLabel.textAlignment = NSTextAlignmentRight;
    }
    return _priceLabel;
}

-(void)setDataInViews:(ActivityDetailModel *)model
{
    self.titleLabel.text = model.title;
    NSString *text = [NSString stringWithFormat:@"%@元/人",model.price];
    [self.priceLabel setText:text afterInheritingLabelAttributesAndConfiguringWithBlock:^ NSMutableAttributedString *(NSMutableAttributedString *mutableAttributedString) {
        NSRange fontRange = [[mutableAttributedString string] rangeOfString:model.price options:NSCaseInsensitiveSearch];
        // Core Text APIs use C functions without a direct bridge to UIFont. See Apple's "Core Text Programming Guide" to learn how to configure string attributes.
        UIFont *boldSystemFont = [UIFont boldSystemFontOfSize:18];
        CTFontRef font = CTFontCreateWithName((__bridge CFStringRef)boldSystemFont.fontName, boldSystemFont.pointSize, NULL);
        if (font) {
            [mutableAttributedString addAttribute:(NSString *)kCTFontAttributeName value:(__bridge id)font range:fontRange];
            [mutableAttributedString addAttribute:(NSString *)kCTForegroundColorAttributeName value:(__bridge id)[[UIColor orangeColor] CGColor] range:fontRange];
            CFRelease(font);
        }
        
        return mutableAttributedString;
    }];
    
    [self setNeedsDisplay];
}
@end
