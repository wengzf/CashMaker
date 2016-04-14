//
//  TaskViewController.m
//  CashMaker
//
//  Created by 翁志方 on 16/2/17.
//  Copyright © 2016年 wzf. All rights reserved.
//

#import "TaskViewController.h"
#import "TaskTableViewCell.h"

#import "TaskWallViewController.h"

#import "JOYConnect.h"          // 万普



@interface TaskViewController()<JOYConnectDelegate>
{
    NSMutableArray *taskArr;            // 兑换内容数组
}

@end

@implementation TaskViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.taskTableView registerNib:[UINib nibWithNibName:@"TaskTableViewCell" bundle:nil] forCellReuseIdentifier:@"TaskTableViewCell"];
    
    // 获取任务列表
    {
        [self.view showLoading];
        [FSNetworkManagerDefaultInstance taskListWithUserID:Global.userID successBlock:^(long status, NSDictionary *dic) {
            [self.view hideLoading];
            
            NSArray *arr = (NSArray *)dic;
            taskArr = [NSMutableArray array];
//            taskArr = [NSMutableArray arrayWithArray:arr];
            
            for (NSString *str in arr) {
                TaskModel *model = [TaskModel new];
                model.taskNameStr = str;
                model.titleStr = str;
                model.hintStr = @"免费获取积分";
                [taskArr addObject:model];
            }
            
            TaskModel *model = [TaskModel new];
            model.taskNameStr = @"wanpu";
            model.titleStr = @"万普";
            model.hintStr = @"免费获取积分";
            [taskArr addObject:model];
            
            [self.taskTableView reloadData];
        }];
    }
    
    [self initAD];
    
}
-  (void)viewWillAppear:(BOOL)animated                                        
{
    [super viewWillAppear:animated];
    
    
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    
}

#pragma mark - <UITableViewDataSource, UITableViewDelegate>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return taskArr.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat res = 82;
    
    if (indexPath.row == (taskArr.count-1)) {
        res += 5;
    }
    return res;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TaskTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TaskTableViewCell"];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    NSArray *titleImgArr = @[@"icon_channel_a", @"icon_channel_b", @"icon_channel_c", @"icon_channel_d", @"icon_channel_e"];
    cell.titleImageView.image = [UIImage imageNamed:titleImgArr[(indexPath.row + 3)%5 ]];
    
    // cell配置
    TaskModel *model = taskArr[indexPath.row];
    [cell updateCellWithModel:model];
    
    return cell;
}


- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [cell resetDeviderLineToOnePixel];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 跳转到对应的兑换页面
    TaskModel *model = taskArr[indexPath.row];
    
    if ([model.taskNameStr isEqualToString:@"signin"]) {
        [FSNetworkManagerDefaultInstance signinWithUserID:Global.userID successBlock:^(long status, NSDictionary *dic) {
            UIAlertView *alv = [[UIAlertView alloc] initWithTitle:@"签到" message:@"成功签到，获得10个金币" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [alv show];
        }];
        
    }else if ([model.taskNameStr isEqualToString:@"share"]) {
        // 弹出分享菜单
        
        
    }else{
        [self showADWithControlStr:model.taskNameStr];
    }
    
}

- (void)showADWithControlStr:(NSString *)controlStr
{
    if ([controlStr isEqualToString:@"share"]) {
        
        
    }else if ([controlStr isEqualToString:@"signin"]) {
        
        
    }else if ([controlStr isEqualToString:@"wanpu"]) {
        
//        [JOYConnect showList:nil];
//        [JOYConnect showList:self];
        TaskWallViewController *vc = [TaskWallViewController new];
        vc.controlStr = controlStr;
        [self.navigationController pushViewController:vc animated:YES];
    }
}


- (void)initAD
{
    [self wanpu];
}

// 万普平台
- (void)wanpu
{
    NSString * appID=[NSString stringWithFormat:@"%@",@"4ad1a43c27b83f89301d02974eb4cf90"];
    NSDictionary * dic=@{@"pid":@"enterprise",@"userID":Global.userID};
    NSString *pid=dic[@"pid"];
    NSString * userID=dic[@"userID"];
    
    NSLog(@"appID=%@",appID);
    [JOYConnect getConnect:appID pid:pid userID:userID];
    [JOYConnect sharedJOYConnect].delegate=self;
}
- (void)onConnectSuccess{
    NSLog(@"连接成功");
}
- (void)onConnectFailed:(NSString *)error
{
    NSLog(@"连接失败:%@",error);
}

- (void)onListOpen;{
    NSLog(@"列表展示");
}

-(void)onListShowFailed:(NSString *)error;{
    NSLog(@"列表展示失败:%@",error);
}

- (void)onListClose;{
    NSLog(@"列表关闭");
}
@end











