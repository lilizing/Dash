//
//  NSObject+Util.h
//  Snippet
//
//  Created by lili on 13-12-30.
//  Copyright (c) 2013年 lili. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSFileManager (Util)

+ (void) setObject:(NSData *) data forKey:(NSString *) key withExpires:(int) expires;
+ (NSData *) get:(NSString *) key;
+ (void) clear;
+ (NSString *) getTempPath:(NSString*) key;
+ (BOOL) fileExists:(NSString *) filepath;
+ (BOOL) isExpired:(NSString *) key;

@end
