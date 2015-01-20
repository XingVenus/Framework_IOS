//
//  UIButton+ButtonTitlePosition.m
//  HuWai
//
//  Created by WmVenusMac on 15-1-20.
//  Copyright (c) 2015年 xici. All rights reserved.
//

#import "UIButton+ButtonTitlePosition.h"

@implementation UIButton (ButtonTitlePosition)

- (void)setTitlePositionWithType:(ButtonTitlePostionType)type withSpacing:(CGFloat)space{
    // the space between the image and text
    CGFloat spacing = space ? space : 1.0;
    switch (type) {
        case ButtonTitlePostionTypeBottom: {
            
            // lower the text and push it left so it appears centered
            //  below the image
            CGSize imageSize = self.imageView.frame.size;
            self.titleEdgeInsets = UIEdgeInsetsMake(0.0, - imageSize.width, - (imageSize.height + spacing), 0.0);
            
            // raise the image and push it right so it appears centered
            //  above the text
            CGSize titleSize = self.titleLabel.frame.size;
            self.imageEdgeInsets = UIEdgeInsetsMake(-(titleSize.height + spacing), 0.0, 0.0, - titleSize.width);
            break;
        }
        case ButtonTitlePostionTypeLeft:
        {
            CGSize imageSize = self.imageView.frame.size;
            CGSize titleSize = self.titleLabel.frame.size;
            
            self.imageEdgeInsets = UIEdgeInsetsMake(0.0, 0.0, 0.0, -(titleSize.width +spacing + imageSize.width));
            self.titleEdgeInsets = UIEdgeInsetsMake(0.0, - (imageSize.width + spacing + titleSize.width), 0.0, 0.0);
            break;
        }
        case ButtonTitlePostionTypeTop:
        {
            CGSize imageSize = self.imageView.frame.size;
            self.titleEdgeInsets = UIEdgeInsetsMake(-(imageSize.height + spacing), - imageSize.width, 0.0, 0.0);
            
            CGSize titleSize = self.titleLabel.frame.size;
            self.imageEdgeInsets = UIEdgeInsetsMake(0.0, 0.0, -(titleSize.height + spacing), - titleSize.width);
            break;
        }
        case ButtonTitlePostionTypeRight:
        {
            //            CGSize imageSize = self.imageView.frame.size;
            self.titleEdgeInsets = UIEdgeInsetsMake(0.0, 0.0, 0.0, -spacing);
            
            //            CGSize titleSize = self.titleLabel.frame.size;
            self.imageEdgeInsets = UIEdgeInsetsMake(0.0, -spacing, 0.0, 0.0);
            break;
        }
        default:
            break;
    }
}

@end
