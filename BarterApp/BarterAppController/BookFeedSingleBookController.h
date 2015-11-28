//
//  BookFeedSingleBookController.h
//  BarterApp
//
//  Created by ajay singh on 11/24/15.
//  Copyright © 2015 UB. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BookFeedSingleBookController : UIViewController

@property (nonatomic) NSInteger selectedBookID;
@property (weak, nonatomic) IBOutlet UILabel *bookDescription;
@property (weak, nonatomic) IBOutlet UILabel *bookTitle;
@property (weak, nonatomic) IBOutlet UIImageView *bookImage;
- (IBAction)raiseBarterRequest:(id)sender;

@end
