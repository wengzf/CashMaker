//
//  ExchangeRecordsTableViewController.m
//  CashMaker
//
//  Created by 翁志方 on 16/3/12.
//  Copyright © 2016年 wzf. All rights reserved.
//

#import "ExchangeRecordsTableViewController.h"
#import "ExchangeRecordsTableViewCell.h"

@interface ExchangeRecordsTableViewController ()
{
    NSMutableArray *recordsArr;
}
@end

@implementation ExchangeRecordsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 3;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 88;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ExchangeRecordsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ExchangeRecordsTableViewCell" forIndexPath:indexPath];
    
    [cell updateCellWithModel:recordsArr[indexPath.row]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [cell resetDeviderLineToOnePixel];
}



@end
