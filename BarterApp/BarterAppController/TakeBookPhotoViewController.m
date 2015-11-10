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
    
    
}
@end
