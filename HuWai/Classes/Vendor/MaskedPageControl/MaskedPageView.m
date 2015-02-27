//
//  ViewController.m
//  MaskedExample
//
//  Created by Kevin Donnelly on 4/1/14.
//
//

#import "MaskedPageView.h"
#import "UIView+SimplifyExtend.h"
#import <objc/runtime.h>

const NSString *DELETE_STRING = @"deleteimagestring";

@implementation MaskedPageView
{
    NSMutableArray *_imageArray;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _imageArray = [NSMutableArray array];
        self.scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        self.scrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        self.scrollView.pagingEnabled = YES;
        self.scrollView.delegate = self;
        
        [self addSubview:self.scrollView];
        KVNMaskedPageControl *pageControl = [[KVNMaskedPageControl alloc] init];
        [pageControl setCenter:CGPointMake(CGRectGetMidX(self.bounds), CGRectGetHeight(self.bounds) - CGRectGetMidY(pageControl.bounds) - 10)];
        [pageControl setDataSource:self];
        [pageControl setHidesForSinglePage:YES];
        
        [self addSubview:pageControl];
        self.pageControl = pageControl;
        
        [self.pageControl addTarget:self action:@selector(changePage:) forControlEvents:UIControlEventValueChanged];
    }
    return self;
}

-(void)fillDataWithImagesArray:(NSArray *)imgArray
{
//- (void)createPages:(NSInteger)pages {

    NSInteger pages = imgArray.count;
    [self.pageControl setNumberOfPages:pages];
    for (int i = 0; i < pages; i++) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.scrollView.bounds) * i, 0, CGRectGetWidth(self.scrollView.bounds), CGRectGetHeight(self.scrollView.bounds))];
        view.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.8];
        
        UIImageView *bgImgView = [[UIImageView alloc] initWithFrame:self.scrollView.bounds];
        bgImgView.contentMode = UIViewContentModeScaleAspectFit;
        bgImgView.tag = i;
        bgImgView.userInteractionEnabled = YES;
        //对UIImageView添加点击响应
        UITapGestureRecognizer *sigleTapRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleTapGesture:)];
        sigleTapRecognizer.numberOfTapsRequired = 1;
        [bgImgView addGestureRecognizer:sigleTapRecognizer];
        
        NSURL *url = [NSURL URLWithString:imgArray[i]];
        [bgImgView sd_setImageWithURL:url];
        [view addSubview:bgImgView];
        [view sendSubviewToBack:bgImgView];
        
        [self.scrollView addSubview:view];
    }
    
    [self.scrollView setContentSize:CGSizeMake(CGRectGetWidth(self.scrollView.bounds) * pages, CGRectGetHeight(self.scrollView.bounds))];
    [self.scrollView setNeedsDisplay];
    [self setNeedsDisplay];
}

#pragma mark 浏览本地图片
-(void)fillDataArrayImages:(NSArray *)array
{
    //- (void)createPages:(NSInteger)pages {
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(20, 30, 50, 35);
    backButton.backgroundColor = [UIColor colorWithWhite:0.2 alpha:1];
    [backButton setTitle:@"返回" forState:UIControlStateNormal];
    [backButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(dismissFromSuperView) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:backButton];
    
    _imageArray = [array mutableCopy];
    NSInteger pages = array.count;
    [self.pageControl setNumberOfPages:pages];
    for (int i = 0; i < pages; i++) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.scrollView.bounds) * i, 0, CGRectGetWidth(self.scrollView.bounds), CGRectGetHeight(self.scrollView.bounds))];
        view.backgroundColor = [UIColor colorWithWhite:0.2 alpha:1];
        
        UIImageView *bgImgView = [[UIImageView alloc] initWithFrame:self.scrollView.bounds];
        bgImgView.contentMode = UIViewContentModeScaleAspectFit;
//        bgImgView.tag = i;
        
        bgImgView.image = [UIImage imageWithContentsOfFile:array[i]];
        
        view.tag = i;
        [view addSubview:bgImgView];
        [view sendSubviewToBack:bgImgView];
        
        //删除按钮
        UIButton *deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
        deleteButton.frame = CGRectMake(SCREEN_WIDTH - 70, 30, 50, 35);
        deleteButton.backgroundColor = [UIColor colorWithWhite:0.2 alpha:1];
        [deleteButton setTitle:@"删除" forState:UIControlStateNormal];
        [deleteButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        deleteButton.tag = i;
        objc_setAssociatedObject(deleteButton, &DELETE_STRING, array[i], OBJC_ASSOCIATION_COPY_NONATOMIC);
        [deleteButton addTarget:self action:@selector(deleteImage:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:deleteButton];
        [self.scrollView addSubview:view];
    }
    
    
    [self.scrollView setContentSize:CGSizeMake(CGRectGetWidth(self.scrollView.bounds) * pages, CGRectGetHeight(self.scrollView.bounds))];
    [self.scrollView setNeedsDisplay];
    [self setNeedsDisplay];
}

#pragma mark 页面返回时候的数据
-(void)dismissFromSuperView
{
    if (_delegateMaskPageView && [_delegateMaskPageView respondsToSelector:@selector(backDidChangeDataSource:)]) {
        [_delegateMaskPageView backDidChangeDataSource:_imageArray];
    }
    [self removeFromSuperview];
}
-(void)deleteImage:(UIButton *)btn
{
    NSInteger currentindex = btn.tag;
    NSString *imagestring = objc_getAssociatedObject(btn, &DELETE_STRING);
    BOOL initOffest = NO;
    for (UIView *view in self.scrollView.subviews) {
        if (view.tag == currentindex) {
            [_imageArray removeObject:imagestring];
            [view removeFromSuperview];
            initOffest = YES;
        }
        if (initOffest) {
            view.left = view.left - CGRectGetWidth(self.scrollView.bounds);
        }
        
        if (_imageArray.count== 0) {
            [self dismissFromSuperView];
        }
    }
    [self refreshScrollView];
}
#pragma mark 刷新页面数量
-(void)refreshScrollView
{
    [self.pageControl setNumberOfPages:_imageArray.count];
    [self.scrollView setContentSize:CGSizeMake(CGRectGetWidth(self.scrollView.bounds) * _imageArray.count, CGRectGetHeight(self.scrollView.bounds))];
    [self.scrollView setNeedsDisplay];
    [self setNeedsDisplay];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self.pageControl maskEventWithOffset:scrollView.contentOffset.x frame:scrollView.frame];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    CGFloat pageWidth = self.scrollView.frame.size.width;
	NSInteger page =  floor((self.scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    
    [self.pageControl setCurrentPage:page];
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    CGFloat pageWidth = self.scrollView.frame.size.width;
	NSInteger page =  floor((self.scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    
    [self.pageControl setCurrentPage:page];
}

#pragma mark - IBActions
- (void)changePage:(KVNMaskedPageControl *)sender {
	self.pageControl.currentPage = sender.currentPage;
	
    CGRect frame = self.scrollView.frame;
    frame.origin.x = frame.size.width * self.pageControl.currentPage;
    frame.origin.y = 0;
    [self.scrollView scrollRectToVisible:frame animated:YES];
}

#pragma mark - KVNMaskedPageControlDataSource
- (UIColor *)pageControl:(KVNMaskedPageControl *)control pageIndicatorTintColorForIndex:(NSInteger)index {
    return [UIColor colorWithWhite:.7 alpha:.6];
}

- (UIColor *)pageControl:(KVNMaskedPageControl *)control currentPageIndicatorTintColorForIndex:(NSInteger)index {
    return [UIColor colorWithWhite:1 alpha:.8];
}

#pragma mark delegate
-(void)handleTapGesture:(UITapGestureRecognizer*)gesture
{
    if (_delegateMaskPageView && [_delegateMaskPageView respondsToSelector:@selector(handleMaskPageViewTapGesture:)]) {
        [_delegateMaskPageView handleMaskPageViewTapGesture:gesture];
    }
}
@end
