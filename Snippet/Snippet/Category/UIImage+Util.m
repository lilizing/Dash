//
//  UIImage+Util.m
//  Snippet
//
//  Created by lili on 13-12-30.
//  Copyright (c) 2013年 lili. All rights reserved.
//

#import "UIImage+Util.h"
#import <QuartzCore/QuartzCore.h>
#import <CoreGraphics/CoreGraphics.h>


#if ! __has_feature(objc_arc)
#warning This file must be compiled with ARC. Use -fobjc-arc flag (or convert project to ARC).
#endif

static inline CGRect rectDraw(CGRect contextRect, CGSize imageSize){//将size  等比放置在contextRect
    CGRect rect;
	if (contextRect.size.width/contextRect.size.height > (imageSize.width/imageSize.height)){// 最高
		rect.size.height = contextRect.size.height;
		rect.size.width = imageSize.width*(contextRect.size.height/imageSize.height);
		rect.origin.x = contextRect.origin.x+(contextRect.size.width-rect.size.width)/2;
		rect.origin.y = contextRect.origin.y;
	}else {// 最宽
		rect.size.width = contextRect.size.width;
		rect.size.height = imageSize.height*(contextRect.size.width/imageSize.width);
		rect.origin.y = contextRect.origin.y + (contextRect.size.height-rect.size.height)/2;
		rect.origin.x = contextRect.origin.x;
	}
    return rect;
}

@implementation UIImage (Util)

+ (UIImage *)imageWithView:(UIView *)view{
    UIGraphicsBeginImageContext(view.bounds.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [view.layer renderInContext:context];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (UIImage *)thumbImageWithSize:(CGSize)size{
    CGRect imageRect = rectDraw(((CGRect){CGPointZero,size}), self.size);
    UIGraphicsBeginImageContext(size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(context, 0.0, size.height);
	CGContextScaleCTM(context, 1.0, -1.0);
    CGContextDrawImage(context, imageRect, self.CGImage);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (BOOL)saveJpegImage:(NSString *)path{
    NSData *data = UIImageJPEGRepresentation(self, 0.8);
    if (data) {
        if ([data writeToFile:path atomically:YES]) {
            return YES;
        }
    }
    return NO;
}

- (BOOL)savePngImage:(NSString *)path{
    NSData *data = UIImagePNGRepresentation(self);
    if (data) {
        if ([data writeToFile:path atomically:YES]) {
            return YES;
        }
    }
    return NO;
}

+ (UIImage *)imageNamed:(NSString *)name bundle:(NSBundle *)boundle{
    if(!boundle)
        boundle = [NSBundle mainBundle];
    return [UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/%@", [boundle bundlePath], name ] ];
}

@end