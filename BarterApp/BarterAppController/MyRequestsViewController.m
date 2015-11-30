//
//  MyRequestsViewController.m
//  BarterApp
//
//  Created by ajay singh on 11/9/15.
//  Copyright © 2015 UB. All rights reserved.
//

#import "MyRequestsViewController.h"
#import "CustomRequestViewCell.h"
#import "AFNetworking.h"
#import <MessageUI/MFMailComposeViewController.h>



@interface MyRequestsViewController () <UITableViewDataSource , UITableViewDelegate,MFMailComposeViewControllerDelegate>

@end

@implementation MyRequestsViewController
NSMutableArray *RequestDict;
int selectedID;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:NO];
    
    [self.navigationController setNavigationBarHidden:NO];
    self.navigationController.navigationBar.translucent = NO;
    
    NSString *myIdentifier = @"RequestCell";
    [self.myRequestTableView registerNib:[UINib nibWithNibName:@"CustomRequestCell" bundle:nil] forCellReuseIdentifier:myIdentifier];

    // Do any additional setup after loading the view.
}



-(void)viewWillAppear:(BOOL)animated{

    self.myRequestTableView.delegate = self;
    self.myRequestTableView.dataSource = self;
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    
    // getting an NSString
    NSString *userID = [prefs stringForKey:@"userID"];
    
    //header fields
    [manager.requestSerializer setValue:@"vTdpl8GYzaxIxbT5PF6WauKWyVLMXfv2f57WoNvV9H0" forHTTPHeaderField:@"X-CSRF-Token"];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    manager.responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    NSDictionary *originalParameters = @{@"user_id":userID};
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"application/hal+json",@"text/json", @"text/javascript", @"text/html", nil];
    
    NSString *fullString = [NSString stringWithFormat:@"http://dev-my-barter-site.pantheon.io/myrestapi/requests_backend/retrieve_user_requests"];
    
    
    [manager POST:fullString parameters:originalParameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@", responseObject) ;
        
        if ([NSJSONSerialization isValidJSONObject: responseObject]){
            NSLog(@"Good JSON \n");
        }
        
        NSError* error= nil;
        
        NSMutableArray *jsonArray = [NSMutableArray arrayWithArray:responseObject];
        NSString *json = [NSString stringWithFormat:@"%@" ,[jsonArray objectAtIndex:0]];
        
        NSData *objectData = [json dataUsingEncoding:NSUTF8StringEncoding];
        RequestDict = [NSJSONSerialization JSONObjectWithData:objectData
                                                  options:NSJSONReadingMutableContainers
                                                    error:&error];
        
        if (RequestDict.count == 0) {
            [self checkIFnorequest];

        }
        
        
        [self.myRequestTableView reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];

    
}

-(void) checkIFnorequest {
    
    UIAlertController *alert= [UIAlertController
                               alertControllerWithTitle:@"No Requests as of now"
                               message:@""
                               preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                               handler:^(UIAlertAction * action){
                                                   //Do Some action here
                                                   
                                                   
                                               }];
  
    
    [alert addAction:ok];
    
    
    [self presentViewController:alert animated:YES completion:nil];
    


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


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section

{
    
    return [RequestDict count];
    
}


//use custom book cell for books
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"RequestCell";
    CustomRequestViewCell *cell = (CustomRequestViewCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[CustomRequestViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    if (RequestDict.count == 0) {
        return nil;
    }
    
    
    cell.requesterBook.text = [[RequestDict objectAtIndex:indexPath.row] objectForKey:@"req_book_name"];
    cell.yourBook.text = [[RequestDict objectAtIndex:indexPath.row]objectForKey:@"acceptor_book_name"];
    return cell;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    selectedID = indexPath.row;
    
    UIAlertController *alert= [UIAlertController
                               alertControllerWithTitle:@"Accept Request"
                               message:@""
                               preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* ok = [UIAlertAction actionWithTitle:@"Yes" style:UIAlertActionStyleDefault
                                               handler:^(UIAlertAction * action){
                                                   //Do Some action here
                                                   
                                                   NSString *emailTitle = @"Barter Request Accept";
                                                   // Email Content
                                                   NSString *messageBody = @"Hi Just saw your request! I am interested in the barter! If interested please share your location and contact information!";
                                                   // To address
                                                   NSArray *toRecipents = [NSArray arrayWithObject:[[RequestDict objectAtIndex:selectedID]objectForKey:@"requestor_mail" ]];
                                                   
                                                   MFMailComposeViewController *mc = [[MFMailComposeViewController alloc] init];
                                                   mc.mailComposeDelegate = self;
                                                   [mc setSubject:emailTitle];
                                                   [mc setMessageBody:messageBody isHTML:NO];
                                                   [mc setToRecipients:toRecipents];
                                                   
                                                   // Present mail view controller on screen
                                                   [self presentViewController:mc animated:YES completion:NULL];
                                                   
                                                                                                }];
    UIAlertAction* cancel = [UIAlertAction actionWithTitle:@"NO" style:UIAlertActionStyleDefault
                                                   handler:^(UIAlertAction * action) {
                                                       
                                                       
                                                       [alert dismissViewControllerAnimated:YES completion:nil];
                                                       
                                                   }];
    
    [alert addAction:ok];
    [alert addAction:cancel];
    
  
    [self presentViewController:alert animated:YES completion:nil];
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}
- (void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    switch (result)
    {
        case MFMailComposeResultCancelled:
            NSLog(@"Mail cancelled");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"Mail saved");
            break;
        case MFMailComposeResultSent:
            NSLog(@"Mail sent");
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Mail sent failure: %@", [error localizedDescription]);
            break;
        default:
            break;
    }
    
    // Close the Mail Interface
    [self dismissViewControllerAnimated:YES completion:NULL];
}


@end
