//
//  MyBooksTestCases.m
//  BarterApp
//
//  Created by ajay singh on 11/28/15.
//  Copyright © 2015 UB. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "MyBooksViewController.h"

@interface MyBooksTestCases : XCTestCase
@property (nonatomic) MyBooksViewController *vcToTest;

@end

@implementation MyBooksTestCases

- (void)setUp {
    [super setUp];
    self.vcToTest = [[MyBooksViewController alloc] init];
}

- (void)tearDown {
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
