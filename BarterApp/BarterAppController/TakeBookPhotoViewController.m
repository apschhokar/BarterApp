//
//  TakeBookPhotoViewController.m
//  BarterApp
//
//  Created by ajay singh on 11/9/15.
//  Copyright © 2015 UB. All rights reserved.
//

#import "TakeBookPhotoViewController.h"

@interface TakeBookPhotoViewController ()

@end

@implementation TakeBookPhotoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self openCamera];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)openCamera {
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    [self presentViewController:picker animated:YES completion:NULL];
}


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    self.imageView.image = chosenImage;
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

// go back to my Books if user cancelled the camera option
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [[self navigationController] popViewControllerAnimated:YES];  // goes back to previous view
}


- (IBAction)onUploadButtonPressed:(id)sender {
     [[self navigationController] popViewControllerAnimated:YES];  
    
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    //header fields
    [manager.requestSerializer setValue:@"vTdpl8GYzaxIxbT5PF6WauKWyVLMXfv2f57WoNvV9H0" forHTTPHeaderField:@"X-CSRF-Token"];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    manager.responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    NSDictionary *originalParameters = @{@"title":[self.bookTitle text] ,@"book_owner_id":[self.bookTitle text] , @"book_author": [self.bookAuthor text] ,@"book_description": [self.bookDescription text], @"image_encode": [self.bookTitle text] , @"book_original_price": [self.originalPrice text]};
    
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"application/hal+json",@"text/json", @"text/javascript", @"text/html", nil];
    
    NSString *fullString = [NSString stringWithFormat:@"http://dev-my-barter-site.pantheon.io/myrestapi/books_backend"];
    
    
    [manager POST:fullString parameters:originalParameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"hello");
        NSLog(@"%@", responseObject);
        
        
        NSError* error= nil;
        
        NSMutableArray *jsonArray = [NSMutableArray arrayWithArray:responseObject];
        NSString *json = [NSString stringWithFormat:@"%@" ,[jsonArray objectAtIndex:0]];
        
        NSData *objectData = [json dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *jsonD = [NSJSONSerialization JSONObjectWithData:objectData
                                                              options:NSJSONReadingMutableContainers
                                                                error:&error];
        
        
        
        UIAlertController * alert=   [UIAlertController
                                      alertControllerWithTitle:[NSString stringWithFormat:@"%@", responseObject]
                                      message:@""
                                      preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* yesButton = [UIAlertAction
                                    actionWithTitle:@"OK"
                                    style:UIAlertActionStyleDefault
                                    handler:^(UIAlertAction * action)
                                    {
                                        
                                        [[self navigationController] popViewControllerAnimated:YES];
                                        
                                        //Handel your yes please button action here
                                        [alert dismissViewControllerAnimated:YES completion:nil];
                                        
                                    }];
        UIAlertAction* noButton = [UIAlertAction
                                   actionWithTitle:@"cancel"
                                   style:UIAlertActionStyleDefault
                                   handler:^(UIAlertAction * action)
                                   {
                                       [[self navigationController] popViewControllerAnimated:YES];
                                       
                                       [alert dismissViewControllerAnimated:YES completion:nil];
                                       
                                   }];
        
        [alert addAction:yesButton];
        [alert addAction:noButton];
        
        [self presentViewController:alert animated:YES completion:nil];
        
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];

    
}
@end
