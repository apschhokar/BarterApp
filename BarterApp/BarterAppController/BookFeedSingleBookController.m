//
//  BookFeedSingleBookController.m
//  BarterApp
//
//  Created by ajay singh on 11/24/15.
//  Copyright © 2015 UB. All rights reserved.
//

#import "BookFeedSingleBookController.h"
#import "AFNetworking.h"
#import "MyBooksViewController.h";


@interface BookFeedSingleBookController ()

@end

@implementation BookFeedSingleBookController
NSMutableDictionary *dictobject;
int selectedBookID;


- (void)viewDidLoad {
    [super viewDidLoad];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"Logout"
                                                                 style:UIBarButtonItemStyleBordered
                                                                target:nil
                                                                action:nil];

    // Do any additional setup after loading the view.
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    
    // getting an NSString
    NSString *userID = [prefs stringForKey:@"userID"];
    
    //header fields
    [manager.requestSerializer setValue:@"vTdpl8GYzaxIxbT5PF6WauKWyVLMXfv2f57WoNvV9H0" forHTTPHeaderField:@"X-CSRF-Token"];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    manager.responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"application/hal+json",@"text/json", @"text/javascript", @"text/html", nil];
    
    NSString *fullString = [NSString stringWithFormat:@"http://dev-my-barter-site.pantheon.io/myrestapi/books_backend/%d", self.selectedBookID];
    
    [manager GET:fullString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"hello");
        NSLog(@"%@", responseObject) ;
        
        
        if ([NSJSONSerialization isValidJSONObject: responseObject]){
            NSLog(@"Good JSON \n");
        }
        
        NSError* error= nil;
        NSMutableArray *jsonArray = [NSMutableArray arrayWithArray:responseObject];
        NSString *json = [NSString stringWithFormat:@"%@" ,[jsonArray objectAtIndex:0]];
        
        NSData *objectData = [json dataUsingEncoding:NSUTF8StringEncoding];
        dictobject = [NSJSONSerialization JSONObjectWithData:objectData
                                                  options:NSJSONReadingMutableContainers
                                                    error:&error];
        [self setUI:dictobject];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/




-(void) setUI :(NSDictionary *) dict{

    [self.bookTitle setText:[dict objectForKey:@"title"]];
    [self.bookDescription setText:[dict objectForKey:@"book_description"]];
    
    NSString *ImageURL = [dict objectForKey:@"book_image_url"];
    NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:ImageURL]];
    self.bookImage.image = [UIImage imageWithData:imageData];

}

- (IBAction)raiseBarterRequest:(id)sender {
    [self performSegueWithIdentifier:@"SelectForBarter" sender:sender];
    
   }


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"SelectForBarter"])
    {
        MyBooksViewController * viewcontroller = [segue destinationViewController];
        viewcontroller.AccepterBookID = self.selectedBookID;
        viewcontroller.AccepterID = [[dictobject objectForKey:@"book_owner_id"]integerValue];
    }
}



@end
