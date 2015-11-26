//
//  ViewController.h
//  BarterApp
//
//  Created by ajay singh on 11/8/15.
//  Copyright © 2015 UB. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITextFieldDelegate>

- (IBAction)onLoginButtonPressed:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *emailID;
@property (weak, nonatomic) IBOutlet UITextField *password;
- (IBAction)onRegisterBtnPressed:(id)sender;
-(void) saveUserID : (NSDictionary *) retreivedDictionary;
@end

