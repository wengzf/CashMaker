//
//  SettingViewController.m
//  CashMaker
//
//  Created by 翁志方 on 16/2/17.
//  Copyright © 2016年 wzf. All rights reserved.
//

#import "SettingViewController.h"

@implementation SettingViewController

- (void)viewDidLoad
{

}
-  (void)viewWillAppear:(BOOL)animated
{
    // 导航栏
    {
        self.navigationController.navigationBar.translucent = NO;
        self.navigationController.navigationBar.tintColor = [UIColor blueColor];
        self.navigationController.navigationBar.shadowImage = [[UIImage alloc] init];
    }
}
- (void)viewDidAppear:(BOOL)animated
{
    // 导航栏
    {
        self.navigationController.navigationBar.translucent = NO;
        self.navigationController.navigationBar.tintColor = [UIColor blueColor];
        self.navigationController.navigationBar.shadowImage = [[UIImage alloc] init];
    }
}





- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    static NSInteger count = 0;
    NSLog(@"%ld",count++);
    
    return 11;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSInteger count = 0;
    NSLog(@"%ld,%ld",indexPath.row, count++);
    
    NSInteger row = indexPath.row;
    if (row==3) return 10;
    if (row==8) return 30;
    return 50;
}


- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [cell resetDeviderLineToOnePixel];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"hello");
    
    switch (indexPath.row){
        case 0:{
            
        } break;
        case 1:{
            
        } break;
        case 2:{
            
        } break;
        case 3:{
            
        } break;
        case 4:{
            
        } break;
        case 5:{
            
        } break;
        case 6:{
            
        } break;
        case 7:{
            
        } break;
        case 8:{
            
        } break;
        case 9:{    // 退出登录
            [self.view showLoading];
            [FSNetworkManagerDefaultInstance logoutWithPhoneStr:Global.phone successBlock:^(long status, NSDictionary *dic) {
                [self.view hideLoading];
                
                [Global clearUserInfo];
                
                // 跳到登录注册页面
                UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"RegisterLogin" bundle:nil];
                UIViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"RegisterLogin"];
                [self.navigationController pushViewController:vc animated:NO];
            }];
        } break;
        case 10:{   // 删除账户
            
        } break;
    }
    
    
    
}


@end
