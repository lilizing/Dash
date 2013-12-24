//
//  UIView+Positioning.m
//  PDFCreator
//
//  Created by lili on 13-5-23.
//  Copyright (c) 2013年 kdanmobile. All rights reserved.
//
#import "UIView+Positioning.h"
#import "UIView+Size.h"


@implementation UIView (Positioning)


//针对给定的坐标系居中
- (void)centerInRect:(CGRect)rect;
{
    //如果参数是小数，则求最大的整数但不大于本身.
    //CGRectGetMidX获取中心点的X轴坐标
    [self setCenter:CGPointMake(floorf(CGRectGetMidX(rect)) + ((int)floorf([self width]) % 2 ? .5 : 0) , floorf(CGRectGetMidY(rect)) + ((int)floorf([self height]) % 2 ? .5 : 0))];
}


//针对给定的坐标系纵向居中
- (void)centerVerticallyInRect:(CGRect)rect;
{
    [self setCenter:CGPointMake([self center].x, floorf(CGRectGetMidY(rect)) + ((int)floorf([self height]) % 2 ? .5 : 0))];
}


//针对给定的坐标系横向居中
- (void)centerHorizontallyInRect:(CGRect)rect;
{
    [self setCenter:CGPointMake(floorf(CGRectGetMidX(rect)) + ((int)floorf([self width]) % 2 ? .5 : 0), [self center].y)];
}


//相对父视图居中
- (void)centerInSuperView;
{
    [self centerInRect:[[self superview] bounds]];
}
- (void)centerVerticallyInSuperView;
{
    [self centerVerticallyInRect:[[self superview] bounds]];
}
- (void)centerHorizontallyInSuperView;
{
    [self centerHorizontallyInRect:[[self superview] bounds]];
}


//同一父视图的兄弟视图水平居中
- (void)centerHorizontallyBelow:(UIView *)view padding:(CGFloat)padding;
{
    // for now, could use screen relative positions.
    NSAssert([self superview] == [view superview], @"views must have the same parent");
    
    [self setCenter:CGPointMake([view center].x,
                                floorf(padding + CGRectGetMaxY([view frame]) + ([self height] / 2)))];
}


- (void)centerHorizontallyBelow:(UIView *)view;
{
    [self centerHorizontallyBelow:view padding:0];
}


@end