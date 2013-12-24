//
//  UIDevice+Platform.m
//  TextKitDemo
//
//  Created by lili on 13-9-28.
//  Copyright (c) 2013年 kdanmobile. All rights reserved.
//

#import "UIDevice+Platform.h"
#include <sys/sysctl.h>

@implementation UIDevice (Platform)

- (NSString *)getCurrentPlatform{
    return [UIDevice platform];
}

+ (NSString*)platform {
    size_t size;
    sysctlbyname("hw.machine", NULL, &size, NULL, 0);
    char *machine = malloc(size);
    sysctlbyname("hw.machine", machine, &size, NULL, 0);
    NSString* platform = [NSString stringWithCString:machine encoding:NSUTF8StringEncoding];
    free(machine);
    return platform;
}

+ (DeviceType)deviceType {
    NSString *platform = [self platform];
    if ([platform isEqualToString:@"iPhone1,1"])    return DeviceTypeiPhone1G;
    if ([platform isEqualToString:@"iPhone1,2"])    return DeviceTypeiPhone3G;
    if ([platform isEqualToString:@"iPhone2,1"])    return DeviceTypeiPhone3GS;
    if ([platform isEqualToString:@"iPhone3,1"])    return DeviceTypeiPhone4;
    if ([platform isEqualToString:@"iPhone3,2"])    return DeviceTypeVerizoniPhone4;
    if ([platform isEqualToString:@"iPhone4,1"])    return DeviceTypeiPhone4S;
    if ([platform isEqualToString:@"iPhone5,1"] ||
        [platform isEqualToString:@"iPhone5,2"] ||
        [platform isEqualToString:@"iPhone5,3"])    return DeviceTypeiPhone5;
    
    
    if ([platform isEqualToString:@"iPod1,1"])      return DeviceTypeiPod1G;
    if ([platform isEqualToString:@"iPod2,1"])      return DeviceTypeiPod2G;
    if ([platform isEqualToString:@"iPod3,1"])      return DeviceTypeiPod3G;
    if ([platform isEqualToString:@"iPod4,1"])      return DeviceTypeiPod4G;
    if ([platform isEqualToString:@"iPod5,1"] ||
        [platform isEqualToString:@"iPod5,2"] ||
        [platform isEqualToString:@"iPod5,3"])      return DeviceTypeiPod5G;
    
    if ([platform isEqualToString:@"iPad1,1"])      return DeviceTypeiPad;
    if ([platform isEqualToString:@"iPad2,1"])      return DeviceTypeiPad2WiFi;
    if ([platform isEqualToString:@"iPad2,2"])      return DeviceTypeiPad2GSM;
    if ([platform isEqualToString:@"iPad2,3"])      return DeviceTypeiPad2CDMA;
    if ([platform isEqualToString:@"iPad3,1"])      return DeviceTypeiPad3WiFi;
    if ([platform isEqualToString:@"iPad3,2"])      return DeviceTypeiPad3GSM;
    if ([platform isEqualToString:@"iPad3,3"])      return DeviceTypeiPad3CDMA;
    
    if ([platform isEqualToString:@"i386"] ||
        [platform isEqualToString:@"x86_64"])       return DeviceTypeSimulator;
    
    return DeviceTypeUnknown;
}


+ (BOOL)isiPhone5Platform {
    static DeviceType type = DeviceTypeUnknown;
    if (DeviceTypeUnknown == type)
        type = [self deviceType];
    return (DeviceTypeiPhone5 == type || DeviceTypeiPod5G == type);
}


+ (BOOL)isiPadPlatform {
    static DeviceType type2 = DeviceTypeUnknown;
    if (DeviceTypeUnknown == type2)
        type2 = [self deviceType];
    
    return (DeviceTypeiPad      == type2 ||
            DeviceTypeiPad2CDMA == type2 ||
            DeviceTypeiPad2GSM  == type2 ||
            DeviceTypeiPad2WiFi == type2 ||
            DeviceTypeiPad3CDMA == type2 ||
            DeviceTypeiPad3GSM  == type2 ||
            DeviceTypeiPad3WiFi == type2);
}

@end
