//
//  ExchangeViewController.m
//  CashMaker
//
//  Created by 翁志方 on 16/2/17.
//  Copyright © 2016年 wzf. All rights reserved.
//

#import "ExchangeViewController.h"
#import "ExchangeTableViewCell.h"

@interface ExchangeViewController()<UIAlertViewDelegate>
{
    NSMutableArray *exchangeArr;            // 兑换内容数组
    
    NSString *accountStr;
    
    ExchangeModel *curModel;
    
    UITextField *accountTextField1;
    UITextField *accountTextField2;
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
- (void)viewWillAppear:(BOOL)animated
{
}
- (void)viewDidAppear:(BOOL)animated
{
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
        
        curModel = model;
        // 弹出确认兑换信息
        NSString *msg = [NSString stringWithFormat:@"确认使用%@个coins兑换%@%@%@",model.cost_coins,model.title,model.reward_amount, [model.reward_type intValue]==2 ?@"个":@"元"];
        
        UIAlertView *alv = [[UIAlertView alloc] initWithTitle:@"兑换" message:msg delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        
        
        [alv setAlertViewStyle:UIAlertViewStyleLoginAndPasswordInput];
        
        accountTextField1 = [alv textFieldAtIndex:0];
        
        accountTextField2 = [alv textFieldAtIndex:1];
        [accountTextField2 setSecureTextEntry:NO];
        [accountTextField2 becomeFirstResponder];
        
        NSString *account;
        switch ([model.reward_type intValue]) {
            case 1:     // 支付宝
                account = Global.zhifubaoAccount;
                accountTextField1.placeholder = @"请输入您的支付宝账号";
                accountTextField2.placeholder = @"再次确认您的支付宝账号";
                break;
            case 2:     // Q币
                account = Global.qqAccount;
                accountTextField1.placeholder = @"请输入您的QQ账号";
                accountTextField2.placeholder = @"再次确认您的QQ账号";
                break;
            case 3:     // 话费
                account = Global.huafeiAccount;
                accountTextField1.placeholder = @"请输入您的手机号";
                accountTextField2.placeholder = @"再次确认您的手机号";
                break;
                
            default:
                break;
        }
        if (account) {
            accountTextField1 = [alv textFieldAtIndex:0];
            accountTextField1.text = account;
        }
        [alv show];
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

#pragma mark - UIAlertView Delegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        // 调用兑换接口
        if ([accountTextField1.text isEqualToString:accountTextField2.text]) {
            
            NSString *account = accountTextField1.text;
            switch ([curModel.reward_type intValue]) {
                case 1:     // 支付宝
                    Global.zhifubaoAccount = account;
                    break;
                case 2:     // Q币
                    Global.qqAccount = account ;
                    break;
                case 3:     // 话费
                    Global.huafeiAccount = account;
                    break;
                    
                default:
                    break;
            }
            [Global saveUserInfo];
            
            [self.view showLoading];
            [FSNetworkManagerDefaultInstance dopostWithUserID:Global.userID exchangeid:curModel.exchangeID exchange_account:accountTextField1.text successBlock:^(long status, NSDictionary *dic) {
                
                [self.view hideLoading];
                
                if (status == 911) {
                    [self.view showLoadingWithMessage:@"网络异常" hideAfter:2];
                    
                }else{
                    status = [dic[@"code"] intValue];
                    if (status == 1000) {
                        [self.view showLoadingWithMessage:@"兑换申请已提交" hideAfter:2];
                    }else{
                        [self.view showLoadingWithMessage:dic[@"message"] hideAfter:2];
                    }
                }
                
                
            }];
        }else{
            [self.view showLoadingWithMessage:@"您的账号前后输入不匹配" hideAfter:2];
        }
    }
}
@end
