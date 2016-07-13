//
//  UIView+Accessory.h
//  ResCUer
//
//  Created by LiuYang on 5/30/16.
//  Copyright © 2016 LiuYang. All rights reserved.
//

#import <UIKit/UIKit.h>

#define UIColorFromHex(hexValue) \
    [UIColor colorWithRed:((float)((hexValue & 0xFF0000) >> 16))/255.0 \
                    green:((float)((hexValue & 0x00FF00) >>  8))/255.0 \
                     blue:((float)((hexValue & 0x0000FF) >>  0))/255.0 \
                    alpha:1.0]

#define BACKGROUND_COLOR (UIColorFromHex(0x323D4D))
#define NAVIGATION_COLOR (UIColorFromHex(0xE74C3C))

@interface UIView (UIViewAccessory)

- (void)addUnderLine;

@end

//@interface UITextField (UITextFieldAccosory)
//
//- (void)addUnderLine;
//
//@end
