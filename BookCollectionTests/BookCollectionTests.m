//
//  BookCollectionTests.m
//  BookCollectionTests
//
//  Created by Kwok_Rui on 2017/5/18.
//  Copyright © 2017年 Netease. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface BookCollectionTests : XCTestCase

@end

@implementation BookCollectionTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
//    每段执行代码执行之前都会要执行的  初始化
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
    
//    每段代码执行之后会执行的  销毁
}

- (void)testExample
{
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
