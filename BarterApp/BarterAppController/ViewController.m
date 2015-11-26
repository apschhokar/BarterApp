//
//  ViewController.m
//  BarterApp
//
//  Created by ajay singh on 11/8/15.
//  Copyright © 2015 UB. All rights reserved.
//

#import "ViewController.h"
#import "DashboardTabViewController.h"

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
    
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    //header fields
    [manager.requestSerializer setValue:@"vTdpl8GYzaxIxbT5PF6WauKWyVLMXfv2f57WoNvV9H0" forHTTPHeaderField:@"X-CSRF-Token"];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    manager.responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    NSDictionary *originalParameters = @{@"email":[self.emailID text] ,@"pass":[self.password text]};
    
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"application/hal+json",@"text/json", @"text/javascript", @"text/html", nil];
    
    NSString *fullString = [NSString stringWithFormat:@"http://dev-my-barter-site.pantheon.io/myrestapi/barter_user_service/login"];
    
    
    [manager POST:fullString parameters:originalParameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"hello");
        NSLog(@"%@", responseObject) ;
        
        
        if ([NSJSONSerialization isValidJSONObject: responseObject]){
            NSLog(@"Good JSON \n");
        }

        
        NSError* error= nil;
        
        NSMutableArray *jsonArray = [NSMutableArray arrayWithArray:responseObject];
        NSString *json = [NSString stringWithFormat:@"%@" ,[jsonArray objectAtIndex:0]];
        
        NSData *objectData = [json dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *jsonD = [NSJSONSerialization JSONObjectWithData:objectData
                                                             options:NSJSONReadingMutableContainers
                                                               error:&error];
        
        
        [self saveUserID:jsonD];

        if ([[jsonD objectForKey:@"result"]integerValue] == 1) {
            [self performSegueWithIdentifier:@"LoginSegue" sender:sender];
        }
        else{
            [self showAlertView:@"Invalid Username or Password" and:@"OK"];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
    
    
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"LoginSegue"])
    {
        NSLog(@"ok fine");
    }
    if ([[segue identifier] isEqualToString:@"RegisterSegue"])
    {
        NSLog(@"ok fine");
    }
}


- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender {
    if ([identifier isEqualToString:@"LoginSegue"]) {
        NSLog(@"Segue ");
        //Put your validation code here and return YES or NO as needed
        return YES;
    }
    
    return NO;
}


-(void)dismissKeyboard {
    [self.password resignFirstResponder];
    [self.emailID resignFirstResponder];
}



-(void) showAlertView: (NSString *) Title and:(NSString *) information{
    
    
    UIAlertController * alert=   [UIAlertController
                                  alertControllerWithTitle:Title
                                  message:@""
                                  preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* yesButton = [UIAlertAction
                                actionWithTitle:information
                                style:UIAlertActionStyleDefault
                                handler:^(UIAlertAction * action)
                                {
                                    
                                    
                                    //Handel your yes please button action here
                                    [alert dismissViewControllerAnimated:YES completion:nil];
                                    
                                }];
    
    
    [alert addAction:yesButton];
    
    [self presentViewController:alert animated:YES completion:nil];
    
}


- (IBAction)onRegisterBtnPressed:(id)sender {
    [self performSegueWithIdentifier:@"RegisterSegue" sender:sender];
}


-(void) saveUserID : (NSDictionary *) retreivedDictionary{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];  // saving an NSString
    [prefs setObject:[retreivedDictionary objectForKey:@"uid"] forKey:@"userID"];
    [prefs synchronize];
}

@end
