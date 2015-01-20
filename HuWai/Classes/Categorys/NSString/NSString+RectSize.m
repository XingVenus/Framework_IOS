//
//  NSString+RectSize.m
//  pshot
//
//  Created by WmVenusMac on 14-11-3.
//  Copyright (c) 2014年 venus. All rights reserved.
//

#import "NSString+RectSize.h"

@implementation NSString (RectSize)

/**
 @method 获取指定宽度情况ixa，字符串value的高度
 @param value 待计算的字符串
 @param fontSize 字体的大小
 @param andWidth 限制字符串显示区域的宽度
 @result float 返回的高度
 */
-(CGSize)stringRectSizeWithfontSize:(CGFloat)fontSize andWidth:(CGFloat)width withLineSpacing:(CGFloat)lineSpacing
{
    CGSize size;
    if ([self respondsToSelector:
         @selector(boundingRectWithSize:options:attributes:context:)])
    {
        NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
//        paragraphStyle.alignment = NSTextAlignmentLeft;
        paragraphStyle.lineSpacing = lineSpacing;

        NSDictionary * attributes = @{NSFontAttributeName : [UIFont systemFontOfSize:fontSize], NSParagraphStyleAttributeName : paragraphStyle};
        
        size = [self boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX)
                                          options:NSStringDrawingUsesFontLeading
                |NSStringDrawingUsesLineFragmentOrigin
                                       attributes:attributes
                                          context:nil].size;
    } else {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        size = [self sizeWithFont:[UIFont systemFontOfSize:fontSize]
                        constrainedToSize:CGSizeMake(width, CGFLOAT_MAX)
                            lineBreakMode:NSLineBreakByWordWrapping];
        //此处的换行类型（lineBreakMode）可根据自己的实际情况进行设置
#pragma clang diagnostic pop
    }
    return size;
}

@end
