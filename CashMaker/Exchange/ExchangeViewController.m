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
        
        // 数据源初始化
        exchangeArr = [NSMutableArray array];
        
        
        [exchangeArr addObject:@(0)];
        [exchangeArr addObject:@(0)];
        [exchangeArr addObject:@(0)];
        [exchangeArr addObject:@(0)];
        
        [self.exchangeTableView reloadData];
    }
    
    // 用户数据请求
    {
        
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
    
}
- (void)requestIncrementExchangeData
{
    
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
    ExchangeModel *model = exchangeArr[indexPath.row];
    [cell updateCellWithModel:model];
    
//    cell.layer.masksToBounds
//    cell.layer.cornerRadius
    return cell;
}


- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
//    [cell resetDeviderLineToOnePixel];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 跳转到对应的兑换页面
    ExchangeModel *model = exchangeArr[indexPath.row];
    
}


@end
