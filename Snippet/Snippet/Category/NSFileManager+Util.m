//
//  NSObject+Util.m
//  Snippet
//
//  Created by lili on 13-12-30.
//  Copyright (c) 2013年 lili. All rights reserved.
//

#import "NSFileManager+Util.h"

#if ! __has_feature(objc_arc)
#warning This file must be compiled with ARC. Use -fobjc-arc flag (or convert project to ARC).
#endif

@implementation NSFileManager (Util)

+ (void) setObject:(NSData *) data forKey:(NSString *) key withExpires:(int) expires{
    NSDate *dt = [NSDate date];
    double now = [dt timeIntervalSince1970];
    NSMutableString *expiresString = [[NSMutableString alloc] init];
    NSData *dataExpires = [[expiresString stringByAppendingFormat:@"%f",now+expires] dataUsingEncoding:NSUTF8StringEncoding];
    //创建缓存时间控制文件
    [dataExpires writeToFile:[[self getTempPath:key] stringByAppendingFormat:@"%@",@".expires"] atomically:NO];
    //创建缓存文件，写入缓存
    [data writeToFile:[self getTempPath:key] atomically:NO];
}

+ (NSData *) get:(NSString *) key{
    if(![self fileExists:[self getTempPath:key]] || [self isExpired:[self getTempPath:key]]){
        NSLog(@"no cache");
        return nil;
    }
    NSData *data = [NSData dataWithContentsOfFile:[self getTempPath:key]];
    return data;
}


+ (void) clear{
    
    
}

//获取临时文件目录
+ (NSString *)getTempPath:(NSString*) key{
    return [NSTemporaryDirectory() stringByAppendingPathComponent:key];
}

//判断文件是否存在
+ (BOOL)fileExists:(NSString *) filepath{
    return [[NSFileManager defaultManager] fileExistsAtPath:filepath];
}


//判断是否过期
+ (BOOL)isExpired:(NSString *) filepath{
    NSData *data = [NSData dataWithContentsOfFile:[filepath stringByAppendingFormat:@"%@",@".expires"]];
    NSString *expires = [[NSString alloc] initWithData:data  encoding:NSUTF8StringEncoding];
    double exp = [expires doubleValue];
    NSDate *dt = [NSDate date];
    double value = [dt timeIntervalSince1970];
    if(exp > value){
        return NO;
    }
    return YES;
}

@end
