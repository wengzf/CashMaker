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
        [self.contentTableView registerNib:[UINib nibWithNibName:@"ExchangeRecordsTableViewCell" bundle:nil] forCellReuseIdentifier:@"ExchangeRecordsTableViewCell"];
        [self.contentTableView registerNib:[UINib nibWithNibName:@"TaskRecordTableViewCell" bundle:nil] forCellReuseIdentifier:@"TaskRecordTableViewCell"];
        
        // 注册上下拉刷新
        self.contentTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(requestData)];
        self.contentTableView.mj_footer = [MJRefreshAutoFooter footerWithRefreshingTarget:self refreshingAction:@selector(requestIncrementData)];
        
        // 数据源初始化
        taskRecordsArr = [NSMutableArray array];
        exchangeRecordsArr = [NSMutableArray array];
        
        selectedIndex = 0;
        
        // 开始刷新数据
        [self.contentTableView.mj_header beginRefreshing];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)requestData
{
    //
    if (selectedIndex == 1) {
        // 兑换记录
        
        [FSNetworkManagerDefaultInstance myrecordsWithUserID:Global.userID exchange_record_id:@"0" successBlock:^(long status, NSDictionary *dic) {
            // 数据源初始化
            exchangeRecordsArr = [NSMutableArray array];
            NSArray *arr = (NSArray *)dic;
            for (NSDictionary *tmpDic in arr) {
                ExchangeRecordsModel *model = [[ExchangeRecordsModel alloc] initWithDic:tmpDic];
                [exchangeRecordsArr addObject:model];
            }
            [self.contentTableView reloadData];
            
            [self.contentTableView.mj_header endRefreshing];
            [self.contentTableView.mj_footer endRefreshing];
        }];
    }else{
        // 收益记录

        [FSNetworkManagerDefaultInstance myrecordsWithUserID:Global.userID last_coins_record_id:@"0" successBlock:^(long status, NSDictionary *dic) {
            
            // 数据源初始化
            taskRecordsArr = [NSMutableArray array];
            NSArray *arr = (NSArray *)dic;
            for (NSDictionary *tmpDic in arr) {
                TaskRecordsModel *model = [[TaskRecordsModel alloc] initWithDic:tmpDic];
                [taskRecordsArr addObject:model];
            }
            [self.contentTableView reloadData];
            
            [self.contentTableView.mj_header endRefreshing];
            [self.contentTableView.mj_footer endRefreshing];
        }];
    }
}
- (void)requestIncrementData
{
    if (selectedIndex == 1) {
        // 兑换记录
        ExchangeRecordsModel *model = [exchangeRecordsArr lastObject];
        [FSNetworkManagerDefaultInstance myrecordsWithUserID:Global.userID exchange_record_id:model.exchangeID successBlock:^(long status, NSDictionary *dic) {
            
            NSArray *arr = (NSArray *)dic;
            for (NSDictionary *tmpDic in arr) {
                ExchangeRecordsModel *model = [[ExchangeRecordsModel alloc] initWithDic:tmpDic];
                [exchangeRecordsArr addObject:model];
            }
            [self.contentTableView reloadData];
            
            [self.contentTableView.mj_header endRefreshing];
            [self.contentTableView.mj_footer endRefreshing];
        }];
    }else{
        // 我的任务获取金币记录
        TaskRecordsModel *model = [taskRecordsArr lastObject];
        
        [FSNetworkManagerDefaultInstance myrecordsWithUserID:Global.userID last_coins_record_id:model.taskRecordsID successBlock:^(long status, NSDictionary *dic) {
            
            NSArray *arr = (NSArray *)dic;
            for (NSDictionary *tmpDic in arr) {
                TaskRecordsModel *model = [[TaskRecordsModel alloc] initWithDic:tmpDic];
                [taskRecordsArr addObject:model];
            }
            [self.contentTableView reloadData];
            
            [self.contentTableView.mj_header endRefreshing];
            [self.contentTableView.mj_footer endRefreshing];
        }];
    }

}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    NSInteger res = exchangeRecordsArr.count;
    if (selectedIndex == 0) {
        res = taskRecordsArr.count;
    }
    return res;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (selectedIndex == 0) {
        return 65;
    }
    return 88;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *resCell;
    if (selectedIndex == 1) {
        
        ExchangeRecordsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ExchangeRecordsTableViewCell" forIndexPath:indexPath];
        
        [cell updateCellWithModel:exchangeRecordsArr[indexPath.row]];
        
        resCell = cell;
        
    }else{
        
        TaskRecordTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TaskRecordTableViewCell" forIndexPath:indexPath];
        
        [cell updateCellWithModel:taskRecordsArr[indexPath.row]];
        
        resCell = cell;
    }
    return resCell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [cell resetDeviderLineToOnePixel];
}

#pragma mark - Event

- (IBAction)segmentControlValueChanged:(UISegmentedControl *)sender {
    selectedIndex = sender.selectedSegmentIndex;
    
    [self.contentTableView reloadData];
    
    if (selectedIndex == 1) {
        if ([exchangeRecordsArr count] == 0) {
            // 开始刷新数据
            [self.contentTableView.mj_header beginRefreshing];
        }else{
            [self.contentTableView reloadData];
        }
    }else{
        if ([taskRecordsArr count] == 0) {
            // 开始刷新数据
            [self.contentTableView.mj_header beginRefreshing];
        }else{
            [self.contentTableView reloadData];
        }
    }

}
@end
