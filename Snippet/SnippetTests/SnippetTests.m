//
//  SnippetTests.m
//  SnippetTests
//
//  Created by lili on 13-12-27.
//  Copyright (c) 2013年 lili. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface SnippetTests : XCTestCase

@end

@implementation SnippetTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample
{
//    XCTFail(@"No implementation for \"%s\"", __PRETTY_FUNCTION__);
    double a = [@"1.0001000" doubleValue];
    NSLog(@"%lf",a);
}

@end
