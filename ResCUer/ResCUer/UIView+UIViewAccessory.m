//
//  UIView+Accessory.m
//  ResCUer
//
//  Created by LiuYang on 5/30/16.
//  Copyright © 2016 LiuYang. All rights reserved.
//

#import "UIView+UIViewAccessory.h"

#define VIEW_WIDTH (self.frame.size.width)
#define VIEW_HEIGHT (self.frame.size.height)

@implementation UIView (UIViewAccessory)

- (void)addUnderLine {
    UILabel *underLine = [[UILabel alloc] init];
//    CGRect lineFrame = CGRectMake(0, VIEW_HEIGHT/2.0, VIEW_WIDTH, 10);
//    NSLog(@"%.2f, %.2f", VIEW_WIDTH, VIEW_HEIGHT);
//    UILabel *underLine = [[UILabel alloc] initWithFrame:lineFrame];
    underLine.translatesAutoresizingMaskIntoConstraints = NO;
    underLine.backgroundColor = [UIColor grayColor];
//    self.backgroundColor = [UIColor redColor];
    [self addSubview:underLine];
    NSDictionary *viewsDictionary = @{@"line":underLine,
                                      @"self":self};
    NSDictionary *lineMetrics = @{/*@"lineWidth":@VIEW_WIDTH,*/
                                  @"lineHeight":@1};
    NSMutableArray *lineConstraints = [[NSMutableArray alloc] init];
//    [lineConstraints addObject:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[line(==self)]"
//                                                                       options:0
//                                                                       metrics:lineMetrics
//                                                                         views:viewsDictionary][0]];
    [lineConstraints addObject:[NSLayoutConstraint constraintWithItem:underLine
                                                            attribute:NSLayoutAttributeWidth
                                                            relatedBy:NSLayoutRelationEqual
                                                               toItem:self
                                                            attribute:NSLayoutAttributeWidth
                                                           multiplier:1.0f
                                                             constant:0.0f]];
    [lineConstraints addObject:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[line(lineHeight)]"
                                                                       options:0
                                                                       metrics:lineMetrics
                                                                         views:viewsDictionary][0]];
    [lineConstraints addObject:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[line]|"
                                                                       options:0
                                                                       metrics:lineMetrics
                                                                         views:viewsDictionary][0]];
    [NSLayoutConstraint activateConstraints:lineConstraints];
}

@end

//@implementation UITextField (UITextFieldAccosory)
//
//- (void)addUnderLine {
//    UILabel *underLine = [[UILabel alloc] initWithFrame:CGRectMake(0, self.frame.size.height/2.0, self.frame.size.width, 2)];
//    //    underLine.translatesAutoresizingMaskIntoConstraints = NO;
//    underLine.backgroundColor = [UIColor grayColor];
//    //    self.backgroundColor = [UIColor redColor];
////    [self addSubview:underLine];
//}
//
//@end
