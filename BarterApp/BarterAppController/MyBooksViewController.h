//
//  MyBooksViewController.h
//  BarterApp
//
//  Created by ajay singh on 11/9/15.
//  Copyright © 2015 UB. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomBookCell.h"


@interface MyBooksViewController : UIViewController <UITableViewDelegate , UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *myBooksTableView;
- (IBAction)onuploadBtnPressed:(id)sender;

@end
