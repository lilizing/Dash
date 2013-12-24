//
//  UIView+Screenshot.h
//  TextKitDemo
//
//  Created by lili on 13-9-30.
//  Copyright (c) 2013年 kdanmobile. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Screenshot)

- (UIImage*)screenshot;
- (UIImage*)screenshotWithOptimization:(BOOL)optimized;

@end
