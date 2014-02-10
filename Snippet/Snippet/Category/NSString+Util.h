//
//  NSString+Util.h
//  Snippet
//
//  Created by lili on 14-2-10.
//  Copyright (c) 2014年 lili. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Util)

- (NSString *)md5;
+ (NSString *)md5:(NSString *)str;
+ (NSString *)fileMd5:(NSString *)path;

+(NSString *)random;

- (NSString *)stringByUnescapingFromURLQuery;
- (NSDictionary*)queryDictionaryUsingEncoding: (NSStringEncoding)encoding;
- (NSString *)URLEncode;
- (NSString *)URLEncodedString;
- (NSString *)URLDecodedString;

/**
 * Escape the standard 5 XML entities: &, <, >, ", '
 */
- (NSString *) stringByEscapingCriticalXMLEntities;
/**
 * Unescape the standard 5 XML entities: &, <, >, ", '
 */
- (NSString *) stringByUnescapingCrititcalXMLEntities;

@end
