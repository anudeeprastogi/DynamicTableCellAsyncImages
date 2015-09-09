//
//  TWCTableViewController.m
//  TWC
//
//  Created by Anudeep Rastogi on 9/9/15.
//  Copyright (c) 2015 Anudeep Rastogi. All rights reserved.
//

#import "TWCTableViewController.h"
#import "TWCTableViewCell.h"

#import "BackendUtility.h"

#define GET_DATA_API @"https://www.googleapis.com/youtube/v3/playlistItems?part=snippet&maxResults=50&playlistId=PLWz5rJ2EKKc_XOgcRukSoKKjewFJZrKV0&key=AIzaSyBkKJRvNKAJ4cgdVY604OfkzhqHh7bvyi0"

@interface TWCTableViewController ()
@property (nonatomic,strong) NSMutableArray *dataArray;

@end

@implementation TWCTableViewController

-(void)viewWillAppear:(BOOL)animated{
 
    [super viewWillAppear:animated];

}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dataArray = [[NSMutableArray alloc]init];

    self.tableView.estimatedRowHeight = 100.0;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.allowsSelection = NO;

    [self callWebService];

}

-(void)callWebService{
    [BackendUtility requestWithURL:GET_DATA_API andCompletionBlock:^(id receivedData) {
        dispatch_async(dispatch_get_main_queue(), ^{
            for (NSDictionary *returnDict in receivedData) {
                [self.dataArray addObject:returnDict];
            }
            [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationAutomatic];
        });
    }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [self.dataArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TWCTableViewCell *cell = (TWCTableViewCell*)[tableView dequeueReusableCellWithIdentifier:@"TWCTableViewCell" forIndexPath:indexPath];
    
    NSDictionary *cellDict = [self.dataArray objectAtIndex:indexPath.row];
   
   
    cell.titleLbl.text = cellDict[@"snippet"][@"channelTitle"];
    cell.detailTxtLbl.text = cellDict[@"snippet"][@"description"];
    NSString *urlString =cellDict[@"snippet"][@"thumbnails"][@"high"][@"url"];
    
    NSURL* url = [NSURL URLWithString:urlString];
    NSURLRequest* request = [NSURLRequest requestWithURL:url];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue]completionHandler:^(NSURLResponse * response,NSData * data,NSError * error) {
        if (!error){
            cell.imgView.image = [UIImage imageWithData:data];
        }
    }];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewAutomaticDimension;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewAutomaticDimension;
}


@end
