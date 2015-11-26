//
//  MyBookSingleBookController.m
//  BarterApp
//
//  Created by ajay singh on 11/24/15.
//  Copyright © 2015 UB. All rights reserved.
//

#import "MyBookSingleBookController.h"

@interface MyBookSingleBookController ()

@end

@implementation MyBookSingleBookController
NSMutableDictionary *mybooks;


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSLog(@"%d",self.bookID);
    mybooks = [[NSMutableDictionary alloc]init];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    
    // getting an NSString
    NSString *userID = [prefs stringForKey:@"userID"];
    
    //header fields
    [manager.requestSerializer setValue:@"vTdpl8GYzaxIxbT5PF6WauKWyVLMXfv2f57WoNvV9H0" forHTTPHeaderField:@"X-CSRF-Token"];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    manager.responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    NSDictionary *originalParameters = @{@"":@""};

    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"application/hal+json",@"text/json", @"text/javascript", @"text/html", nil];
    
    NSString *fullString = [NSString stringWithFormat:@"http://dev-my-barter-site.pantheon.io/myrestapi/books_backend/%d", self.bookID];
    
    
    [manager GET:fullString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"hello");
        NSLog(@"%@", responseObject) ;
        
        if ([NSJSONSerialization isValidJSONObject: responseObject]){
            NSLog(@"Good JSON \n");
        }
        
        NSError* error= nil;
       // NSMutableArray *jsonArray = [NSMutableArray arrayWithArray:responseObject];
        NSString *json = [NSString stringWithFormat:@"%@" ,responseObject];
        
        NSData *objectData = [json dataUsingEncoding:NSUTF8StringEncoding];
        mybooks = [NSJSONSerialization JSONObjectWithData:objectData
                                                  options:NSJSONReadingMutableContainers
                                                    error:&error];
        
        [self setUIValues];

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) setUIValues{
    [self.bookTitle setText:[mybooks objectForKey:@"book_description"]];
    [self.bookDescription setText:[mybooks objectForKey:@"book_description"]];
}

@end
