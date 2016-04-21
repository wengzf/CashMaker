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
    
    {
        [self.contentTableView registerNib:[UINib nibWithNibName:@"ExchangeTableViewCell" bundle:nil] forCellReuseIdentifier:@"ExchangeTableViewCell"];
        
        // 注册上下拉刷新
        self.contentTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(requestExchangeData)];
        self.contentTableView.mj_footer = [MJRefreshAutoFooter footerWithRefreshingTarget:self refreshingAction:@selector(requestIncrementExchangeData)];
    }
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
- (void)requestData
{
    [FSNetworkManagerDefaultInstance elistWithUserID:Global.userID last_exchange_id:@"0" successBlock:^(long status, NSDictionary *dic) {
        
        // 数据源初始化
        exchangeRecordsArr = [NSMutableArray array];
        NSArray *arr = (NSArray *)dic;
        for (NSDictionary *tmpDic in arr) {
            ExchangeRecordsModel *model = [[ExchangeRecordsModel alloc] initWithDic:tmpDic];
            [exchangeRecordsArr addObject:model];
        }
        [self.contentTableView reloadData];
        
        [self.contentTableView.mj_header endRefreshing];
    }];
}
- (void)requestIncrementData
{
    ExchangeRecordsModel *model = [exchangeRecordsArr lastObject];
    [FSNetworkManagerDefaultInstance elistWithUserID:Global.userID last_exchange_id:model.exchangeID successBlock:^(long status, NSDictionary *dic) {
        
        NSArray *arr = (NSArray *)dic;
        for (NSDictionary *tmpDic in arr) {
            ExchangeRecordsModel *model = [[ExchangeRecordsModel alloc] initWithDic:tmpDic];
            [exchangeRecordsArr addObject:model];
        }
        [self.contentTableView reloadData];
    }];
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

#pragma mark - Event

- (IBAction)segmentControlValueChanged:(id)sender {
}
@end
