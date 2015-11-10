//
//  CustomBookCell.h
//  BarterApp
//
//  Created by ajay singh on 11/9/15.
//  Copyright © 2015 UB. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomBookCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *BookTitle;
@property (weak, nonatomic) IBOutlet UILabel *BookAuthor;
@property (weak, nonatomic) IBOutlet UILabel *yearOfPurchase;

@end
