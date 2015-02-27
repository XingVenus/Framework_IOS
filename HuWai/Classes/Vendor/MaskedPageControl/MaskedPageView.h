//
//  ViewController.h
//  MaskedExample
//
//  Created by Kevin Donnelly on 4/1/14.
//
//

#import <UIKit/UIKit.h>
#import "KVNMaskedPageControl.h"

@protocol MaskedPageViewDelegate <NSObject>

@optional
-(void)handleMaskPageViewTapGesture:(UITapGestureRecognizer*)gesture;

-(void)backDidChangeDataSource:(id)data;
@end

@interface MaskedPageView : UIView <UIScrollViewDelegate, KVNMaskedPageControlDataSource>
@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) KVNMaskedPageControl *pageControl;

//@property (nonatomic)   NSArray *dataArray;
@property (nonatomic, weak) id<MaskedPageViewDelegate> delegateMaskPageView;

//-(void)fillDataArrayFromDictionary:(NSArray *)array Imagekey:(NSString *)key;
//-(void)fillDataArrayImages:(NSArray *)array;
-(void)fillDataWithImagesArray:(NSArray *)imgArray;
@end
