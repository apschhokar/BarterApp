//
//  RegisterTestCases.m
//  BarterApp
//
//  Created by ajay singh on 11/26/15.
//  Copyright © 2015 UB. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "RegisterViewController.h"

@interface RegisterTestCases : XCTestCase

@property (nonatomic) RegisterViewController *vcToTest;

@end

@implementation RegisterTestCases

- (void)setUp {
    [super setUp];
    self.vcToTest = [[RegisterViewController alloc] init];

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




-(void) testForValidEmail{
    NSString *validEmail = @"apschhokar@gmail.com";
    XCTAssertTrue( [self.vcToTest validateEmail:validEmail]);
    NSString *invalidEmail = @"r@gmail";
    XCTAssertFalse( [self.vcToTest validateEmail:invalidEmail]);
}


- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
