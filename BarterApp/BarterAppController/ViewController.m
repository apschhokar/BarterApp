//
//  ViewController.m
//  BarterApp
//
//  Created by ajay singh on 11/8/15.
//  Copyright © 2015 UB. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UITextFieldDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:YES];
    
    
    //Add gesture to hide keyboard whenever we tap on the screen
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    
    
    [self.view addGestureRecognizer:tap];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onLoginButtonPressed:(id)sender {
    
}



-(void)dismissKeyboard {
    [self.password resignFirstResponder];
    [self.emailID resignFirstResponder];
}

@end
