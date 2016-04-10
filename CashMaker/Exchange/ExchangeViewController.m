//
//  ExchangeViewController.m
//  CashMaker
//
//  Created by 翁志方 on 16/2/17.
//  Copyright © 2016年 wzf. All rights reserved.
//

#import "ExchangeViewController.h"
#import "ExchangeTableViewCell.h"

@interface ExchangeViewController()
{
    NSMutableArray *exchangeArr;            // 兑换内容数组
}
@end



@implementation ExchangeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // tableView初始化
    {
        [self.exchangeTableView registerNib:[UINib nibWithNibName:@"ExchangeTableViewCell" bundle:nil] forCellReuseIdentifier:@"ExchangeTableViewCell"];
        
        // 注册上下拉刷新
        self.exchangeTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(requestExchangeData)];
        self.exchangeTableView.mj_footer = [MJRefreshAutoFooter footerWithRefreshingTarget:self refreshingAction:@selector(requestIncrementExchangeData)];
    }
    
    // 用户数据请求
    {
        [self.exchangeTableView.mj_header beginRefreshing];
    }
}
-  (void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden=NO;
}
- (void)viewDidAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden=NO;
}


- (void)requestExchangeData
{
    [FSNetworkManagerDefaultInstance elistWithUserID:Global.userID last_exchange_id:@"0" successBlock:^(long status, NSDictionary *dic) {
        
        // 数据源初始化
        exchangeArr = [NSMutableArray array];
        NSArray *arr = (NSArray *)dic;
        for (NSDictionary *tmpDic in arr) {
            ExchangeModel *model = [[ExchangeModel alloc] initWithDic:tmpDic];
            [exchangeArr addObject:model];
        }
        [self.exchangeTableView reloadData];
        
        [self.exchangeTableView.mj_header endRefreshing];
    }];
}
- (void)requestIncrementExchangeData
{
    ExchangeModel *model = [exchangeArr lastObject];
    [FSNetworkManagerDefaultInstance elistWithUserID:Global.userID last_exchange_id:model.exchangeID successBlock:^(long status, NSDictionary *dic) {
        
        NSArray *arr = (NSArray *)dic;
        for (NSDictionary *tmpDic in arr) {
            ExchangeModel *model = [[ExchangeModel alloc] initWithDic:tmpDic];
            [exchangeArr addObject:model];
        }
        [self.exchangeTableView reloadData];
    }];
}



#pragma mark - <UITableViewDataSource, UITableViewDelegate>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return exchangeArr.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat res = 205;
    
    // 根据屏幕适配尺寸
    res = 205;
    
    if (indexPath.row == (exchangeArr.count-1)) {
        res += 5;
    }
    return res;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ExchangeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ExchangeTableViewCell"];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    // cell配置
    cell.exchangeBlock = ^(ExchangeModel *model){
        
        // 调用兑换接口
        [self.view showLoading];
        [FSNetworkManagerDefaultInstance dopostWithUserID:Global.userID exchangeid:model.exchangeID exchange_account:@"1" successBlock:^(long status, NSDictionary *dic) {
            
            
            [self.view hideLoading];
            
            
            status = [dic[@"code"] intValue];
            if (status == 1000) {
                [self.view showLoadingWithMessage:@"兑换成功" hideAfter:2];
            }else{
                [self.view showLoadingWithMessage:dic[@"message"] hideAfter:2];
            }
        }];
    };
    
    ExchangeModel *model = exchangeArr[indexPath.row];
    [cell updateCellWithModel:model];
    
    return cell;
}


- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [cell resetDeviderLineToOnePixel];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}


@end
