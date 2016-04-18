//
//  SettingViewController.m
//  CashMaker
//
//  Created by 翁志方 on 16/2/17.
//  Copyright © 2016年 wzf. All rights reserved.
//

#import "SettingViewController.h"

#import "ViewController.h"


@implementation SettingViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
}
-  (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // 导航栏
    {
        self.navigationController.navigationBar.translucent = NO;
        self.navigationController.navigationBar.tintColor = [UIColor blueColor];
        self.navigationController.navigationBar.shadowImage = [[UIImage alloc] init];
    }
    
    // 页面初始化
    {
        self.userIDLabel.text = Global.userID;
        self.phoneLabel.text = Global.phone;
    }
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
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
    
    return 10;
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
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
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
        case 4:{        // 发送邮件
            
            if ([MFMailComposeViewController canSendMail])
            {
                MFMailComposeViewController* controller = [[MFMailComposeViewController alloc] init];
                controller.mailComposeDelegate = self;
                [controller setSubject:@"改进手机赚"];
                [controller setToRecipients:@[@"shoujizhuan8888@163.com"]];
                [self presentViewController:controller animated:YES completion:NULL];
            }else{
                [self.view showLoadingWithMessage:@"您尚未配置系统邮件账号" hideAfter:2.0];
            }

            
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
            
            [Global clearUserInfo];
            [self dismissViewControllerAnimated:NO completion:NULL];
            [HomeVC showLogin];
            
        
//            [self.view showLoading];
//            [FSNetworkManagerDefaultInstance logoutWithPhoneStr:Global.phone successBlock:^(long status, NSDictionary *dic) {
//                [self.view hideLoading];
//                
//                if (status == 911) {
//                    [self.view showLoadingWithMessage:@"退出失败" hideAfter:2.0];
//                    
//                }else{
//                    [Global clearUserInfo];
//                    
//                    [HomeVC showLogin];
//                }
//            }];
        } break;
        case 10:{   // 删除账户
            
        } break;
    }
    
    
    
}


- (IBAction)switchValueChanged:(id)sender {
}

#pragma mark - mail delegate
- (void)mailComposeController:(MFMailComposeViewController*)controller
          didFinishWithResult:(MFMailComposeResult)result
                        error:(NSError*)error;
{
    if (result == MFMailComposeResultSent) {
        NSLog(@"It's away!");
    }
    [self dismissViewControllerAnimated:YES completion:NULL];
}
@end
