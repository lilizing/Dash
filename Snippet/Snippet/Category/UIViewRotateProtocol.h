//
//  UIViewRotateProtocal.h
//  DP_Test
//
//  Created by lili on 14-1-4.
//  Copyright (c) 2014年 lili. All rights reserved.
//

/*
if(UIInterfaceOrientationIsPortrait(orientation)){
    if([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad){
        NSAssert(NO,@"请做iPad竖屏适配");
    }else{
        NSAssert(NO,@"请做iphone竖屏适配");
    }
}else{
    if([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad){
        NSAssert(NO,@"请做iPad横屏适配");
    }else{
        if(SCREEN_HEIGHT == IPHONE5_HEIGHT){
            NSAssert(NO,@"请做iphone5横屏适配");
        }else{
            NSAssert(NO,@"请做iphone横屏适配");
        }
    }
}
*/

#define SCREEN_WIDTH     [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT    [UIScreen mainScreen].bounds.size.height
#define CURRENT_ORIENTATION [UIApplication sharedApplication].statusBarOrientation

#import <Foundation/Foundation.h>

@protocol UIViewRotateProtocal <NSObject>
@required
-(void)layoutSubviewsByOrientation:(UIInterfaceOrientation)orientation;
@end
