//
//  NSString+Util.h
//  TextKitDemo
//
//  Created by lili on 13-9-18.
//  Copyright (c) 2013年 kdanmobile. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Util)
- (NSString *)md5;
+ (NSString *)md5:(NSString *)str;
+ (NSString *)fileMd5:(NSString *)path;
+(NSString *)random;
@end
