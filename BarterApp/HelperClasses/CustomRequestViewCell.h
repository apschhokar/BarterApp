//
//  CustomRequestViewCell.h
//  BarterApp
//
//  Created by ajay singh on 11/10/15.
//  Copyright © 2015 UB. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomRequestViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIButton *onDeclineButtonPressed;

@property (weak, nonatomic) IBOutlet UILabel *requesterBook;
@property (weak, nonatomic) IBOutlet UILabel *yourBook;

@end
