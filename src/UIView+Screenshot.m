//
//  UIView+Screenshot.m
//  TextKitDemo
//
//  Created by lili on 13-9-30.
//  Copyright (c) 2013年 kdanmobile. All rights reserved.
//

#import "UIView+Screenshot.h"
#import <QuartzCore/QuartzCore.h>

@implementation UIView (Screenshot)

- (UIImage*)screenshotWithOptimization:(BOOL)optimized
{
    if (optimized)
    {
        // take screenshot of the view
        if ([self isKindOfClass:NSClassFromString(@"MKMapView")])
        {
            if ([[[UIDevice currentDevice] systemVersion] floatValue]>=6.0)
            {
                // in iOS6, there is no problem using a non-retina screenshot in a retina display screen
                UIGraphicsBeginImageContextWithOptions(self.frame.size, NO, 1.0);
            }
            else
            {
                // if the view is a mapview in iOS5.0 and below, screenshot has to take the screen scale into consideration
                // else, the screen shot in retina display devices will be of a less detail map (note, it is not the size of the screenshot, but it is the level of detail of the screenshot
                UIGraphicsBeginImageContextWithOptions(self.frame.size, NO, 0.0);
            }
        }
        else
        {
            // for performance consideration, everything else other than mapview will use a lower quality screenshot
            UIGraphicsBeginImageContext(self.frame.size);
        }
    }
    else
    {
        UIGraphicsBeginImageContextWithOptions(self.frame.size, NO, 0.0);
    }
    
    
    
    if (UIGraphicsGetCurrentContext()==nil)
    {
        NSLog(@"UIGraphicsGetCurrentContext() is nil. You may have a UIView with CGRectZero");
        return nil;
    }
    else
    {
        [self.layer renderInContext:UIGraphicsGetCurrentContext()];
        
        UIImage *screenshot = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return screenshot;
    }
}

- (UIImage*)screenshot
{
    return [self screenshotWithOptimization:NO];
}

@end