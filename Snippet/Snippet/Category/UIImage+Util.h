//
//  UIImage+Util.h
//  Snippet
//
//  Created by lili on 13-12-30.
//  Copyright (c) 2013年 lili. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Util)

+ (UIImage *)imageWithView:(UIView *)view;
- (UIImage *)thumbImageWithSize:(CGSize)size;
- (BOOL)savePngImage:(NSString *)path;
- (BOOL)saveJpegImage:(NSString *)path;
+ (UIImage *)imageNamed:(NSString *)name bundle:(NSBundle *)boundle;

+(UIImage *) loadImageByTheme:(NSString *) name;
+(UIImage *) loadImage:(NSString *) name;


@end
