//
//  LaunchView.m
//  HuWai
//
//  Created by WmVenusMac on 15-3-10.
//  Copyright (c) 2015年 xici. All rights reserved.
//

#import "LaunchView.h"

@implementation LaunchView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        self.scrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        self.scrollView.pagingEnabled = YES;
        self.scrollView.showsHorizontalScrollIndicator = NO;
        self.scrollView.showsVerticalScrollIndicator = NO;
        self.scrollView.delegate = self;
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.scrollView];
    }
    return self;
}

-(void)fillDataWithImagesArray:(NSArray *)imgArray
{
    //- (void)createPages:(NSInteger)pages {
    NSInteger pages = imgArray.count;
    for (int i = 0; i < pages; i++) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.scrollView.bounds) * i, 0, CGRectGetWidth(self.scrollView.bounds), CGRectGetHeight(self.scrollView.bounds))];
        view.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:1];
        
        UIImageView *bgImgView = [[UIImageView alloc] initWithFrame:self.scrollView.bounds];
//        bgImgView.contentMode = UIViewContentModeScaleAspectFit;
        bgImgView.tag = i;
        bgImgView.userInteractionEnabled = YES;
        //对UIImageView添加点击响应
        /*
        UITapGestureRecognizer *sigleTapRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleTapGesture:)];
        sigleTapRecognizer.numberOfTapsRequired = 1;
        [bgImgView addGestureRecognizer:sigleTapRecognizer];
        */

//        NSString *imagePath = [[NSBundle mainBundle] pathForResource:imgArray[i] ofType:@"png"];
//        UIImage *image = [[UIImage alloc] initWithContentsOfFile:imagePath];
        bgImgView.image = [UIImage imageNamed:imgArray[i]];
        [view addSubview:bgImgView];
        [view sendSubviewToBack:bgImgView];
        if (i == (pages - 1) && self.isSkipBtn) {
            _skipBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            _skipBtn.frame = CGRectMake(0, 0, 200,100);
            
            [_skipBtn setAdjustsImageWhenHighlighted:NO];
            _skipBtn.centerX = SCREEN_WIDTH/2;
            _skipBtn.top = SCREEN_HEIGHT - 130;
            _skipBtn.backgroundColor = [UIColor clearColor];
            [_skipBtn addTarget:self action:@selector(removeView) forControlEvents:UIControlEventTouchUpInside];
            [view addSubview:_skipBtn];
        }
        [self.scrollView addSubview:view];
    }
    
    [self.scrollView setContentSize:CGSizeMake(CGRectGetWidth(self.scrollView.bounds) * pages, CGRectGetHeight(self.scrollView.bounds))];
    [self.scrollView setNeedsDisplay];
    [self setNeedsDisplay];
}

-(void)removeView
{
    [UIView animateWithDuration:.3 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.left = -self.width;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}
@end
