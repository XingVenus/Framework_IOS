//
//  NSString+JSONCategories.h
//  Sanbao
//
//  Created by WmVenusMac on 14-7-8.
//  Copyright (c) 2014年 venus. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (JSON)
-(id)JSONValue;
@end

@interface NSObject (JSON)
-(NSData *)JSONString;
@end
