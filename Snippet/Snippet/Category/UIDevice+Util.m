#import "UIDevice+Util.h"
#import "NSString+Util.h"

#include <sys/socket.h> // Per msqr
#include <sys/sysctl.h>
#include <net/if.h>
#include <net/if_dl.h>

#import <AdSupport/AdSupport.h>

#if ! __has_feature(objc_arc)
#warning This file must be compiled with ARC. Use -fobjc-arc flag (or convert project to ARC).
#endif

#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)

@interface UIDevice(Private)

- (NSString *)macaddress;

- (NSString *)deviceIdentifier;

@end

@implementation UIDevice (Util)

////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Private Methods

// Return the local MAC addy
// Courtesy of FreeBSD hackers email list
// Accidentally munged during previous update. Fixed thanks to erica sadun & mlamb.
- (NSString *)macaddress{
    
    int                 mib[6];
    size_t              len;
    char                *buf;
    unsigned char       *ptr;
    struct if_msghdr    *ifm;
    struct sockaddr_dl  *sdl;
    
    mib[0] = CTL_NET;
    mib[1] = AF_ROUTE;
    mib[2] = 0;
    mib[3] = AF_LINK;
    mib[4] = NET_RT_IFLIST;
    
    if ((mib[5] = if_nametoindex("en0")) == 0) {
        printf("Error: if_nametoindex error\n");
        return NULL;
    }
    
    if (sysctl(mib, 6, NULL, &len, NULL, 0) < 0) {
        printf("Error: sysctl, take 1\n");
        return NULL;
    }
    
    if ((buf = malloc(len)) == NULL) {
        printf("Could not allocate memory. error!\n");
        return NULL;
    }
    
    if (sysctl(mib, 6, buf, &len, NULL, 0) < 0) {
        printf("Error: sysctl, take 2");
        free(buf);
        return NULL;
    }
    
    ifm = (struct if_msghdr *)buf;
    sdl = (struct sockaddr_dl *)(ifm + 1);
    ptr = (unsigned char *)LLADDR(sdl);
    NSString *outstring = [NSString stringWithFormat:@"%02X:%02X:%02X:%02X:%02X:%02X",
                           *ptr, *(ptr+1), *(ptr+2), *(ptr+3), *(ptr+4), *(ptr+5)];
    free(buf);
    
    return outstring;
}

- (NSString *)deviceIdentifier
{
    NSString *tDevID = nil;
    
    // Key Chain
    NSString *tKeyDevID = @"kKEY_Device_Identifier";
    
    // 查找条件：1.class 2.attributes 3.search option
    NSDictionary *query = [NSDictionary dictionaryWithObjectsAndKeys:(__bridge id)(kSecClassGenericPassword), kSecClass,
                           tKeyDevID, kSecAttrAccount,
                           kCFBooleanTrue, kSecReturnAttributes,nil];
    CFTypeRef result = nil;
    // 先找到一个item
    OSStatus s = SecItemCopyMatching((__bridge CFDictionaryRef)query, &result);
    if (s == noErr) {
        // 继续查找item的secValue
        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:(__bridge NSDictionary *)(result)];
        // 存储格式
        [dic setObject:(id)kCFBooleanTrue forKey:(__bridge id<NSCopying>)(kSecReturnData)];
        // 确定class
        [dic setObject:[query objectForKey:(__bridge id)(kSecClass)] forKey:(__bridge id<NSCopying>)(kSecClass)];
        NSData *data = nil;
        CFDataRef keyData = NULL;
        // 查找secValue
        if (SecItemCopyMatching((__bridge CFDictionaryRef)dic, (CFTypeRef *)&keyData) == noErr) {
            data = (__bridge id)(keyData);
            if (data.length) {
                tDevID = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            }
        }
    }
    
    if (nil == tDevID) {
        UIDevice *tCurDevice = [UIDevice currentDevice];
        
        if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")) {
            tDevID = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
        } else {
            tDevID = [tCurDevice macaddress];
        }
        
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        // 确定所属的类class
        [dic setObject:(__bridge id)kSecClassGenericPassword forKey:(__bridge id)kSecClass];
        // 设置其他属性attributes
        [dic setObject:tKeyDevID forKey:(__bridge id)kSecAttrAccount];
        // 添加密码 secValue  注意是object 是 NSData
        [dic setObject:[tDevID dataUsingEncoding:NSUTF8StringEncoding] forKey:(__bridge id)kSecValueData];
        // SecItemAdd
        OSStatus s = SecItemAdd((__bridge CFDictionaryRef)dic, NULL);
        if (s == noErr) {
            
        }
    }
    
    return tDevID;
}

////////////////////////////////////////////////////////////////////////////////
#pragma mark - Public Methods

- (NSString *)uniqueDeviceIdentifier{
    NSString *tDevID = [self deviceIdentifier];
    NSString *bundleIdentifier = [[NSBundle mainBundle] bundleIdentifier];
    
    NSString *stringToHash = [NSString stringWithFormat:@"%@%@", tDevID, bundleIdentifier];
    NSString *uniqueIdentifier = [stringToHash md5];
    
    return uniqueIdentifier;
}

- (NSString *)uniqueGlobalDeviceIdentifier{
    NSString *tDevID = [self deviceIdentifier];
    NSString *uniqueIdentifier = [tDevID md5];
    
    return uniqueIdentifier;
}

@end