//
//  AccountViewController.m
//  CashMaker
//
//  Created by 翁志方 on 16/4/18.
//  Copyright © 2016年 wzf. All rights reserved.
//

#import "AccountViewController.h"

#import "TaskRecordTableViewCell.h"
#import "ExchangeRecordsTableViewCell.h"

@interface AccountViewController ()
{
    NSInteger selectedIndex;
    
    NSMutableArray *taskRecordsArr;
    NSMutableArray *exchangeRecordsArr;
}
@end

@implementation AccountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)requstTaskHistory
{
    
}
- (void)requstExchangeHistory
{
    
}





#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    NSInteger res = exchangeRecordsArr.count;
    if (selectedIndex == 1) {
        res = taskRecordsArr.count;
    }
    return res;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 88;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *resCell;
    if (selectedIndex == 1) {
        
        ExchangeRecordsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ExchangeRecordsTableViewCell" forIndexPath:indexPath];
        
        [cell updateCellWithModel:taskRecordsArr[indexPath.row]];
        
    }else{
        
        ExchangeRecordsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ExchangeRecordsTableViewCell" forIndexPath:indexPath];
        
        [cell updateCellWithModel:taskRecordsArr[indexPath.row]];
        
    }
    return resCell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [cell resetDeviderLineToOnePixel];
}


@end
