//
//  RegisterViewController.h
//  BarterApp
//
//  Created by ajay singh on 11/19/15.
//  Copyright © 2015 UB. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegisterViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *firstName;
@property (weak, nonatomic) IBOutlet UITextField *lastName;
@property (weak, nonatomic) IBOutlet UITextField *emailID;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UITextField *confirmPassword;
- (IBAction)onRegisterButtonPressed:(id)sender;
-(BOOL) validateEmail: (NSString *) candidate;
-(BOOL) checkAllTheParameters;
-(void) showAlertView: (NSString *) Title and:(NSString *) information;

@end
