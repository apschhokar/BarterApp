//
//  TakeBookPhotoViewController.m
//  BarterApp
//
//  Created by ajay singh on 11/9/15.
//  Copyright © 2015 UB. All rights reserved.
//

#import "TakeBookPhotoViewController.h"
#import "AFNetworking.h"


@interface TakeBookPhotoViewController () <UITextFieldDelegate>

@end

@implementation TakeBookPhotoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //Add gesture to hide keyboard whenever we tap on the screen
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    
    
    [self.view addGestureRecognizer:tap];
    
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
    self.bookImage.image = chosenImage;
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

// go back to my Books if user cancelled the camera option
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [[self navigationController] popViewControllerAnimated:YES];  // goes back to previous view
}


- (IBAction)onUploadButtonPressed:(id)sender {
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    
    // getting an NSString
    NSString *userID = [prefs stringForKey:@"userID"];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    //header fields
    [manager.requestSerializer setValue:@"vZu-YUFWLzIdFIn7VDoA6hV9IhrYe-BimkC1ncRdojU" forHTTPHeaderField:@"X-CSRF-Token"];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    manager.responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
   // manager.responseSerializer = [AFHTTPResponseSerializer serializer];

    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    NSString * image = [ self getImageBase64];
    
    NSDictionary *originalParameters = @{@"title":[self.bookTitle text] ,@"book_owner_id":userID , @"book_author": [self.bookAuthor text] ,@"book_description": [self.bookDescription text], @"image_encode": image ,@"book_year_of_purchase" :[self.yearOfPurchase text] , @"book_original_price": [self.originalPrice text] ,@"amazon_link" : [NSString stringWithFormat:@"nothing"]};
    
    
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
                                        [self performSegueWithIdentifier:@"UploadComplete" sender:sender];
                                        [[self navigationController] popViewControllerAnimated:YES];
                                        //Handel your yes please button action here
                                        [alert dismissViewControllerAnimated:YES completion:nil];
                                        
                                    }];
        
        [alert addAction:yesButton];
        
        [self presentViewController:alert animated:YES completion:nil];
        
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
    
}


-(NSString*) getImageBase64 {
    UIImage *picture =  [self.bookImage image];
    NSData* imageData = UIImageJPEGRepresentation(picture, 0.5);
    NSString *strBase64 = [imageData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    return strBase64;
}

-(void)dismissKeyboard {
    [self.bookTitle resignFirstResponder];
    [self.bookAuthor resignFirstResponder];
    [self.bookDescription resignFirstResponder];
    [self.originalPrice resignFirstResponder];
    [self.yearOfPurchase resignFirstResponder];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{

}


@end
