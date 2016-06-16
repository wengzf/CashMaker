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

@interface ViewController()<UIScrollViewDelegate>
{
    NSMutableArray *exchangeArr;
}

@end


@implementation ViewController


static ViewController *sObj;

+ (id)shareInstance
{
    return sObj;
}

- (void)showLogin
{
    // 弹出登录注册页面
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"RegisterLogin" bundle:nil];
    UIViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"RegisterLoginViewControllerNav"];
    [self presentViewController:vc animated:YES completion:NULL];
    
}

- (void)viewDidLoad
{
    self.title = @"手机赚";
    
    [self.exchangeTableView registerNib:[UINib nibWithNibName:@"ExchangeRecordsTableViewCell" bundle:nil] forCellReuseIdentifier:@"ExchangeRecordsTableViewCell"];
    

    if (ScreenWidth <= 320) {
        self.vieweAccountBtn.hidden = YES;
    }
    
    sObj = self;
}

- (void)viewWillAppear:(BOOL)animated
{
    // 分割线一个像素设置
    [self.view resetDeviderLineToOnePixel];
    
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
        
            [self initRandomData];
            
//            for (NSDictionary *tmpDic in dic[@"exchanges"]) {
//                ExchangeRecordsModel *model = [[ExchangeRecordsModel alloc] initWithDic:tmpDic];
//                [exchangeArr addObject:model];
//            }
//            [self.exchangeTableView reloadData];

            
            // 设置对应UI
            self.todayCoinsLabel.text = [dic[@"today_coins"] stringValue];
            self.restCoinsLabel.text = dic[@"coins"];
            self.totalCoinsLabel.text = dic[@"total_coins"];
            
        }];
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
            [self presentViewController:vc animated:NO completion:NULL];
        }
    });
    
}
- (void)viewWillDisappear:(BOOL)animated
{
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
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

#pragma mark - 随机数据生成
- (void)initRandomData
{
    exchangeArr = [NSMutableArray array];
    
    NSTimeInterval cur = [[NSDate date] timeIntervalSince1970];
    for (int i=0; i<8; ++i) {
        
        ExchangeRecordsModel *model = [self subGenerateRandomData];
        // 时间伪造
        model.createTimeInterval = cur - (8-i)*12 + arc4random()%8;
        [exchangeArr insertObject:model atIndex:0];
    }
    [self.exchangeTableView reloadData];
    
    [self performSelector:@selector(generateRandomData) withObject:nil afterDelay:arc4random()%6+2];
    
}
- (void)generateRandomData
{
    // 首先生成8条假数据，然后在以8秒为均值的随机时间后插入加入一条假数据
    // 兑换内容   支付宝 1元 2元 5元 10元   Q币5个 10个 话费10元 20元   随机生成这些项目权重上有没有要求
    // 用户ID 随机，有没其它要求
//    [self.exchangeTableView reloadData];
    
    [exchangeArr insertObject:[self subGenerateRandomData]
                      atIndex:0];
    
    [self.exchangeTableView beginUpdates];
    [self.exchangeTableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]]
                                  withRowAnimation:UITableViewRowAnimationTop];
    
    [self.exchangeTableView endUpdates];
    
    int afterTime = arc4random()%8 + 4;
    double popTime = dispatch_time(DISPATCH_TIME_NOW, afterTime * NSEC_PER_SEC );
    dispatch_after(popTime-0.5, dispatch_get_main_queue(), ^{
        [self.exchangeTableView reloadData];
    });
    dispatch_after(popTime, dispatch_get_main_queue(), ^{
        [self generateRandomData];
    });
}
- (ExchangeRecordsModel *)subGenerateRandomData
{
    
    ExchangeRecordsModel *model = [ExchangeRecordsModel new];
    // 用户ID
    model.exchangeID = [NSString stringWithFormat:@"%d",arc4random()%10000];
    
    int kind = arc4random()%8;
    switch (kind) {
        case 0:
            model.exchange_type = @"1";
            model.exchange_title = @"支付宝";
            model.exchange_amount = @"1";
            break;
        case 1:
            model.exchange_type = @"1";
            model.exchange_title = @"支付宝";
            model.exchange_amount = @"2";
            break;
        case 2:
            model.exchange_type = @"1";
            model.exchange_title = @"支付宝";
            model.exchange_amount = @"5";
            break;
        case 3:
            model.exchange_type = @"1";
            model.exchange_title = @"支付宝";
            model.exchange_amount = @"10";
            break;
        case 4:
            model.exchange_type = @"2";
            model.exchange_title = @"Q币";
            model.exchange_amount = @"5";
            break;
        case 5:
            model.exchange_type = @"2";
            model.exchange_title = @"Q币";
            model.exchange_amount = @"5";
            break;
        case 6:
            model.exchange_type = @"3";
            model.exchange_title = @"话费";
            model.exchange_amount = @"10";
            break;
        case 7:
            model.exchange_type = @"3";
            model.exchange_title = @"话费";
            model.exchange_amount = @"20";
            break;
        default:
            break;
    }
    // 时间
    model.createTimeInterval = [[NSDate date] timeIntervalSince1970]-arc4random()%3-1;

    return model;
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
    [cell homePageUpdateCellWithModel:model];
    
    return cell;
}


- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [cell resetDeviderLineToOnePixel];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}


- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    [self.exchangeTableView reloadData];
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self.exchangeTableView reloadData];
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
