//
//  TakeBookPhotoViewController.h
//  BarterApp
//
//  Created by ajay singh on 11/9/15.
//  Copyright © 2015 UB. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TakeBookPhotoViewController : UIViewController <UIImagePickerControllerDelegate , UINavigationControllerDelegate>

- (IBAction)onUploadButtonPressed:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *bookTitle;
@property (weak, nonatomic) IBOutlet UITextField *bookAuthor;
@property (weak, nonatomic) IBOutlet UITextField *bookDescription;
@property (weak, nonatomic) IBOutlet UITextField *yearOfPurchase;
@property (weak, nonatomic) IBOutlet UITextField *originalPrice;
@property (weak, nonatomic) IBOutlet UIImageView *bookImage;

@end
