//
//  NSDateUtilTests.m
//  Snippet
//
//  Created by lili on 13-12-27.
//  Copyright (c) 2013年 lili. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "NSDate+Util.h"

#import "UIDevice+Util.h"

@interface NSDateUtilTests : XCTestCase

@end

@implementation NSDateUtilTests

- (void)setUp
{
    [super setUp];
    // Put setup code here; it will be run once, before the first test case.
}

- (void)tearDown
{
    // Put teardown code here; it will be run once, after the last test case.
    [super tearDown];
}

- (void)testExample
{
    XCTFail(@"No implementation for \"%s\"", __PRETTY_FUNCTION__);
}

- (void)testHour{
    int hour = [NSDate date].hour;
    NSLog(@"%d",hour);
}

-(void)testDaysAgo{
    int days = [NSDate dateWithTimeInterval:-60 * 60 * 12 sinceDate:[NSDate date]].daysAgo;
    int days2 = [NSDate dateWithTimeInterval:-60 * 60 * 12 sinceDate:[NSDate date]].daysAgoAgainstMidnight;
    NSLog(@"%d,%d",days,days2);
}

-(void)testStringDaysAgoForWeekAgainstMidnight{
    NSDate *date = [NSDate dateWithTimeInterval:-60 * 60 * 24 * 6 sinceDate:[NSDate date]];
    NSString *str = [date stringDaysAgoAgainstMidnight:YES];
    NSLog(@"%@",str);
}

-(void)testStringForDisplayFromDate{
    NSDate *date = [NSDate dateWithTimeInterval:-60 * 60 * 24 * 400 sinceDate:[NSDate date]];
    NSString *str = [NSDate stringForDisplayFromDate:date];
    NSLog(@"%@",str);
}

-(void)testTemp{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:1388383782];
    NSLog(@"%@",date);
}

-(void)testDevice{
//    [UIDevice uniqueDeviceIdentifier];
    NSString *identi = [[UIDevice currentDevice] uniqueDeviceIdentifier];
    NSLog(@"%@",identi);
}

@end
