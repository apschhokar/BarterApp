//
//  RequestPageTestCases.m
//  BarterApp
//
//  Created by ajay singh on 11/28/15.
//  Copyright © 2015 UB. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "MyRequestsViewController.h"

@interface RequestPageTestCases : XCTestCase
@property (nonatomic) MyRequestsViewController *vcToTest;

@end

@implementation RequestPageTestCases

- (void)setUp {
    [super setUp];
    self.vcToTest = [[MyRequestsViewController alloc] init];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

-(void) testcheckALertView{
    [self.vcToTest checkIFnorequest];
    XCTAssertNotNil(self.vcToTest);
    

}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
