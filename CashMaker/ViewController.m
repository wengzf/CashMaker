//
//  ViewController.m
//  CashMaker
//
//  Created by 翁志方 on 16/2/17.
//  Copyright © 2016年 wzf. All rights reserved.
//

#import "ViewController.h"
#import "ExchangeRecordsModel.h"
#import "ExchangeRecordsTableViewCell.h"

@interface ViewController()
{
    NSMutableArray *exchangeArr;
}

@end


@implementation ViewController

- (void)viewDidLoad
{
    [self.exchangeTableView registerNib:[UINib nibWithNibName:@"ExchangeRecordsTableViewCell" bundle:nil] forCellReuseIdentifier:@"ExchangeRecordsTableViewCell"];
    
    if (ScreenWidth <= 320) {
        self.vieweAccountBtn.hidden = YES;
    }

}

- (void)viewWillAppear:(BOOL)animated
{
    // 分割线一个像素设置
    [self.view resetDeviderLineToOnePixel];
    
    // 更新数据
    {
//        *      userid: 用户ID | integer,
//        *      name: 用户name | string,
//        *      phone: 用户手机号 | string,
//        *      email: 用户邮箱 | string,
//        *      coins: 用户金币数 | integer,
//        *      total_coins: 总共获取金币数 | integer,
//        *      today_coins: 今日赚取金币数 | integer,
//        *      status: 用户状态 1 正常 2被锁定 | integer,
//        *      nation: 用户国家码[两位] | string,
//        *      app_name: app name | string,
//        *      app_version: app version | string,
//        *      platform: platform | string,
//        *      exchanges: 前5条兑换记录 [
//                                   *          id: 活动兑换记录ID | integer,
//                                   *          exchange_title: 兑换标题 | string,
//                                   *          exchange_account: 兑换账号 | string,
//                                   *          send_status: 兑换奖励发放状态  0 已生成  1 已发放  2 拒绝发放 | integer,
//                                   *          note: 派发兑换奖励备注 如帐号错误等 | string,
//                                   *          created_at: 申请兑换时间 | string
//                                   *      ] | array
        
        if (Global.isLogin)
        {
            [FSNetworkManagerDefaultInstance userInfoDetailWithUserID:Global.userID successBlock:^(long status, NSDictionary *dic) {

//                for (NSString *key in [dic allKeys]) {
//                    NSObject *obj = dic[key];
//                    NSLog(@"%@ %@",key, [obj class]);
//                }
                
                Global.userID   = dic[@"userid"];
                
                Global.name     = dic[@"name"];
                Global.mail     = dic[@"email"];
                Global.phone    = dic[@"phone"];
                Global.conis    = dic[@"coins"];
                Global.status   = dic[@"status"];
                
                Global.nation    = dic[@"nation"];
                Global.app_name    = dic[@"app_name"];
                Global.app_version   = dic[@"app_version"];
                
                Global.platform = dic[@"platform"];
                
                [Global saveUserInfo];
                
                
                // 最上面5条兑换记录
                exchangeArr = [NSMutableArray array];
                for (NSDictionary *tmpDic in dic[@"exchanges"]) {
                    ExchangeRecordsModel *model = [[ExchangeRecordsModel alloc] initWithDic:tmpDic];
                    [exchangeArr addObject:model];
                }
                [self.exchangeTableView reloadData];
                
                
                // 设置对应UI
                self.todayCoinsLabel.text = [dic[@"today_coins"] stringValue];
                self.restCoinsLabel.text = dic[@"coins"];
                self.totalCoinsLabel.text = dic[@"total_coins"];
                
            }];
        }
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!Global.isLogin)
        {
            // 弹出登录注册页面
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"RegisterLogin" bundle:nil];
            UIViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"RegisterLoginViewControllerNav"];
            [self presentViewController:vc animated:YES completion:NULL];
            
        }
    });

}

- (IBAction)viewAccountBtnClked:(id)sender {
}

- (IBAction)taskBtnClked:(id)sender {
}

- (IBAction)exchangeBtnClked:(id)sender {
}

- (IBAction)guaguaBtnClked:(id)sender {
}
- (IBAction)settingBtnClked:(id)sender {
}

#pragma mark - <UITableViewDataSource, UITableViewDelegate>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return exchangeArr.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat res = 88;

    return res;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ExchangeRecordsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ExchangeRecordsTableViewCell"];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    ExchangeRecordsModel *model = exchangeArr[indexPath.row];
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
#pragma mark - Navigation

- (void)performSegueWithIdentifier:(NSString *)identifier sender:(id)sender
{
    
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
//    UIViewController *vc = segue.destinationViewController;
//    vc.navigationController.navigationBar.hidden = NO;
}

- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender
{
    if (!Global.isLogin)
    {
        // 弹出登录注册页面
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"RegisterLogin" bundle:nil];
        UIViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"RegisterLoginViewControllerNav"];
        [self presentViewController:vc animated:YES completion:NULL];
        
        return NO;
    }
    
    return YES;
}


@end
