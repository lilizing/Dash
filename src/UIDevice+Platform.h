//
//  UIDevice+Platform.h
//  TextKitDemo
//
//  Created by lili on 13-9-28.
//  Copyright (c) 2013年 kdanmobile. All rights reserved.
//

#import <UIKit/UIKit.h>

#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)

#define IPHONE4_HEIGHT 480
#define IPHONE5_HEIGHT 568

typedef enum {
    DeviceTypeUnknown = 0,
    DeviceTypeiPhone1G,
    DeviceTypeiPhone3G,
    DeviceTypeiPhone3GS,
    DeviceTypeiPhone4,
    DeviceTypeVerizoniPhone4,
    DeviceTypeiPhone4S,
    DeviceTypeiPhone5,
    
    DeviceTypeiPod1G,
    DeviceTypeiPod2G,
    DeviceTypeiPod3G,
    DeviceTypeiPod4G,
    DeviceTypeiPod5G,
    
    DeviceTypeiPad,
    DeviceTypeiPad2WiFi,
    DeviceTypeiPad2GSM,
    DeviceTypeiPad2CDMA,
    DeviceTypeiPad3WiFi,
    DeviceTypeiPad3GSM,
    DeviceTypeiPad3CDMA,
    
    DeviceTypeSimulator
}DeviceType;


@interface UIDevice (platform)

- (NSString *)getCurrentPlatform;

+ (NSString*)platform;

+ (DeviceType)deviceType;


+ (BOOL)isiPhone5Platform;


+ (BOOL)isiPadPlatform;

@end
