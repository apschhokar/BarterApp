//
//  BooksFeedTestCases.m
//  BarterApp
//
//  Created by ajay singh on 11/28/15.
//  Copyright © 2015 UB. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "BooksFeedViewController.h"

@interface BooksFeedTestCases : XCTestCase
@property (nonatomic) BooksFeedViewController *vcToTest;


@end

@implementation BooksFeedTestCases

- (void)setUp {
    [super setUp];
    self.vcToTest = [[BooksFeedViewController alloc] init];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
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
