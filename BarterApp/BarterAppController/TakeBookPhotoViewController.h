//
//  TakeBookPhotoViewController.h
//  BarterApp
//
//  Created by ajay singh on 11/9/15.
//  Copyright © 2015 UB. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TakeBookPhotoViewController : UIViewController <UIImagePickerControllerDelegate , UINavigationControllerDelegate>

@property (strong, nonatomic) IBOutlet UIImageView *imageView;
- (IBAction)onUploadButtonPressed:(id)sender;

@end
