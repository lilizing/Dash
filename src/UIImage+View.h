//
//  UIImage+View.h
//  TextKitDemo
//
//  Created by lili on 13-9-30.
//  Copyright (c) 2013年 kdanmobile. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (View)

+ (UIImage *)imageWithView:(UIView *)view;
- (UIImage *)thumbImageWithSize:(CGSize)size;
- (BOOL)savePngImage:(NSString *)path;
- (BOOL)saveJpegImage:(NSString *)path;
+ (UIImage *)imageNamed:(NSString *)name bundle:(NSBundle *)boundle;

@end
