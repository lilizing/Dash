//
//  UIView+Positioning.h
//  PDFCreator
//
//  Created by lili on 13-5-23.
//  Copyright (c) 2013年 kdanmobile. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UIView (Positioning)


- (void)centerInRect:(CGRect)rect;
- (void)centerVerticallyInRect:(CGRect)rect;
- (void)centerHorizontallyInRect:(CGRect)rect;


- (void)centerInSuperView;
- (void)centerVerticallyInSuperView;
- (void)centerHorizontallyInSuperView;


- (void)centerHorizontallyBelow:(UIView *)view padding:(CGFloat)padding;
- (void)centerHorizontallyBelow:(UIView *)view;


@end
