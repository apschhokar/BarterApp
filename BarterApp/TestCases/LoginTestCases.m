//
//  LoginTestCases.m
//  BarterApp
//
//  Created by ajay singh on 11/25/15.
//  Copyright © 2015 UB. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ViewController.h"

@interface LoginTestCases : XCTestCase

@property (nonatomic) ViewController *vcToTest;

@end

@implementation LoginTestCases


- (void)setUp {
    [super setUp];
    self.vcToTest = [[ViewController alloc] init];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}


- (void) testLoginMethod {
    NSDictionary *dict = [[NSDictionary alloc] initWithObjectsAndKeys:@"108", @"uid", nil];
    [self.vcToTest saveUserID:dict];
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSString *userID = [prefs stringForKey:@"userID"];
    XCTAssertTrue([userID isEqualToString: @"108"]);
}


-(void) testForValidEmail{
    NSString *validEmail = @"apschhokar@gmail.com";
    XCTAssertTrue( [self.vcToTest validateEmail:validEmail]);
    NSString *invalidEmail = @"apschhokar@gmail";
    XCTAssertFalse( [self.vcToTest validateEmail:invalidEmail]);
}


-(void) loginButtonPressed{
    
}



//check if the app does not crash on runing the function
-(void) testLoginWebservice{
    [self.vcToTest onLoginButtonPressed:nil];
    XCTAssertNotNil(self.vcToTest);
  

    
}

//check if the app does not crash on runing the function
-(void) testAlertview{
    [self.vcToTest showAlertView:@"hello" and:@"Unit test"];
    XCTAssertNotNil(self.vcToTest);
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
