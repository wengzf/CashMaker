//
//  TaskViewController.m
//  CashMaker
//
//  Created by 翁志方 on 16/2/17.
//  Copyright © 2016年 wzf. All rights reserved.
//

#import "TaskViewController.h"
#import "TaskTableViewCell.h"


@interface TaskViewController()
{
    UITableView *taskTableView;
    NSMutableArray *taskArr;            // 兑换内容数组
}

@end

@implementation TaskViewController


- (void)viewDidLoad
{
    taskTableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    taskTableView.delegate = self;
    taskTableView.dataSource = self;
    [self.view addSubview:taskTableView];
    
    
    // 请求后台数据
    {
//        [FSNetworkManagerDefaultInstance ];
        taskArr = [NSMutableArray array];
        
        [self addModelWithStr:@"signin"];
        
        [self addModelWithStr:@"share"];
        
        [self addModelWithStr:@"Channel A"];
        
        [self addModelWithStr:@"Channel B"];
        
        [self addModelWithStr:@"Channel C"];
        
        [self addModelWithStr:@"Channel D"];
        
        [self addModelWithStr:@"Channel E"];
        
        [self addModelWithStr:@"Channel F"];
        
        [taskTableView reloadData];
    }
}
- (void)viewDidAppear:(BOOL)animated
{
    
}

- (void)addModelWithStr:(NSString *)str
{
    TaskModel *model = [TaskModel new];
    model.taskNameStr = str;
    [taskArr addObject:model];
}

#pragma mark - <UITableViewDataSource, UITableViewDelegate>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return taskArr.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat res = 205;
    
    // 根据屏幕适配尺寸
    res = 205;
    
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
    //    [cell resetDeviderLineToOnePixel];
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
        
        
    }else if ([controlStr isEqualToString:@"signin"]) {
        
    }else if ([controlStr isEqualToString:@"signin"]) {
        
    }else if ([controlStr isEqualToString:@"signin"]) {
        
    }
}


@end











