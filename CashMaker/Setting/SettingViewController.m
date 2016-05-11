//
//  SettingViewController.m
//  CashMaker
//
//  Created by 翁志方 on 16/2/17.
//  Copyright © 2016年 wzf. All rights reserved.
//



#import "SettingViewController.h"

#import "ViewController.h"

#include "sys/utsname.h"
///Users/wzf/Desktop/CashMaker/CashMaker/Setting/SettingViewController.m:194:20: Definition of 'utsname' must be imported from module 'Darwin.POSIX.sys.utsname' before it is required
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
        self.userIDLabel.text = [NSString stringWithFormat:@"%06d", [Global.userID intValue]];
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
    
    return 9;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSInteger count = 0;
    NSLog(@"%ld,%ld",indexPath.row, count++);
    
    NSInteger row = indexPath.row;
    if (row==3) return 10;
    if (row==7) return 30;
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
                NSMutableString *msgContent = [NSMutableString new];
                
//                UserID:
//                User Name:
//                Nation: CN
//                App Version:
//                Build Version:
//                OS Name:
//                OS Version: 
//                Device Model:
//                Device Resolution:  750 * 1334

                [msgContent appendString:[NSString stringWithFormat:@"\n\n\n\nUserID: %06d\n", [Global.userID intValue]]];
                
                [msgContent appendString:[NSString stringWithFormat:@"User Name:%@\n",@"  "]];
                
                [msgContent appendString:[NSString stringWithFormat:@"Nation: CN\n"]];
                
                [msgContent appendString:[NSString stringWithFormat:@"App Version: %@\n",[[[NSBundle mainBundle]infoDictionary]valueForKey:@"CFBundleVersion"] ]];
                
                [msgContent appendString:[NSString stringWithFormat:@"Build Version: %@\n",[[[NSBundle mainBundle]infoDictionary]valueForKey:@"CFBundleShortVersionString"]]];
                
                [msgContent appendString:[NSString stringWithFormat:@"OS Name: iPhone OS\n"]];
                
                [msgContent appendString:[NSString stringWithFormat:@"OS Version: %@\n",[[UIDevice currentDevice] systemVersion]]];
                
                [msgContent appendString:[NSString stringWithFormat:@"Device Model: %@\n",[self getCurrentDeviceModel]]];
                
                [msgContent appendString:[NSString stringWithFormat:@"Device Resolution:%f*%f\n",ScreenWidth,ScreenHeight]];
                
                MFMailComposeViewController* controller = [[MFMailComposeViewController alloc] init];
                controller.mailComposeDelegate = self;
                [controller setSubject:@"手机赚1.0 意见反馈"];
                [controller setMessageBody:msgContent isHTML:NO];
                [controller setToRecipients:@[@"hi@shoujizhuan.com.cn"]];
                [self presentViewController:controller animated:YES completion:NULL];
            }else{
                [self.view showLoadingWithMessage:@"您尚未配置系统邮件账号" hideAfter:2.0];
            }

        } break;
        case 5:{
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.shoujizhuan.com.cn"]];
        } break;
        case 6:{
            
        } break;
        case 7:{

            
        } break;
        case 8:{   // 退出登录
            
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
        case 9:{
        } break;
        case 10:{   // 删除账户
            
        } break;
    }
    
    
    
}


- (IBAction)switchValueChanged:(id)sender {
}
//获得设备型号
- (NSString *)getCurrentDeviceModel
{

    
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *platform = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    
    if ([platform isEqualToString:@"iPhone1,1"]) return @"iPhone 2G (A1203)";
    if ([platform isEqualToString:@"iPhone1,2"]) return @"iPhone 3G (A1241/A1324)";
    if ([platform isEqualToString:@"iPhone2,1"]) return @"iPhone 3GS (A1303/A1325)";
    if ([platform isEqualToString:@"iPhone3,1"]) return @"iPhone 4 (A1332)";
    if ([platform isEqualToString:@"iPhone3,2"]) return @"iPhone 4 (A1332)";
    if ([platform isEqualToString:@"iPhone3,3"]) return @"iPhone 4 (A1349)";
    if ([platform isEqualToString:@"iPhone4,1"]) return @"iPhone 4S (A1387/A1431)";
    if ([platform isEqualToString:@"iPhone5,1"]) return @"iPhone 5 (A1428)";
    if ([platform isEqualToString:@"iPhone5,2"]) return @"iPhone 5 (A1429/A1442)";
    if ([platform isEqualToString:@"iPhone5,3"]) return @"iPhone 5c (A1456/A1532)";
    if ([platform isEqualToString:@"iPhone5,4"]) return @"iPhone 5c (A1507/A1516/A1526/A1529)";
    if ([platform isEqualToString:@"iPhone6,1"]) return @"iPhone 5s (A1453/A1533)";
    if ([platform isEqualToString:@"iPhone6,2"]) return @"iPhone 5s (A1457/A1518/A1528/A1530)";
    if ([platform isEqualToString:@"iPhone7,1"]) return @"iPhone 6 Plus (A1522/A1524)";
    if ([platform isEqualToString:@"iPhone7,2"]) return @"iPhone 6 (A1549/A1586)";
    
    if ([platform isEqualToString:@"iPod1,1"])   return @"iPod Touch 1G (A1213)";
    if ([platform isEqualToString:@"iPod2,1"])   return @"iPod Touch 2G (A1288)";
    if ([platform isEqualToString:@"iPod3,1"])   return @"iPod Touch 3G (A1318)";
    if ([platform isEqualToString:@"iPod4,1"])   return @"iPod Touch 4G (A1367)";
    if ([platform isEqualToString:@"iPod5,1"])   return @"iPod Touch 5G (A1421/A1509)";
    
    if ([platform isEqualToString:@"iPad1,1"])   return @"iPad 1G (A1219/A1337)";
    
    if ([platform isEqualToString:@"iPad2,1"])   return @"iPad 2 (A1395)";
    if ([platform isEqualToString:@"iPad2,2"])   return @"iPad 2 (A1396)";
    if ([platform isEqualToString:@"iPad2,3"])   return @"iPad 2 (A1397)";
    if ([platform isEqualToString:@"iPad2,4"])   return @"iPad 2 (A1395+New Chip)";
    if ([platform isEqualToString:@"iPad2,5"])   return @"iPad Mini 1G (A1432)";
    if ([platform isEqualToString:@"iPad2,6"])   return @"iPad Mini 1G (A1454)";
    if ([platform isEqualToString:@"iPad2,7"])   return @"iPad Mini 1G (A1455)";
    
    if ([platform isEqualToString:@"iPad3,1"])   return @"iPad 3 (A1416)";
    if ([platform isEqualToString:@"iPad3,2"])   return @"iPad 3 (A1403)";
    if ([platform isEqualToString:@"iPad3,3"])   return @"iPad 3 (A1430)";
    if ([platform isEqualToString:@"iPad3,4"])   return @"iPad 4 (A1458)";
    if ([platform isEqualToString:@"iPad3,5"])   return @"iPad 4 (A1459)";
    if ([platform isEqualToString:@"iPad3,6"])   return @"iPad 4 (A1460)";
    
    if ([platform isEqualToString:@"iPad4,1"])   return @"iPad Air (A1474)";
    if ([platform isEqualToString:@"iPad4,2"])   return @"iPad Air (A1475)";
    if ([platform isEqualToString:@"iPad4,3"])   return @"iPad Air (A1476)";
    if ([platform isEqualToString:@"iPad4,4"])   return @"iPad Mini 2G (A1489)";
    if ([platform isEqualToString:@"iPad4,5"])   return @"iPad Mini 2G (A1490)";
    if ([platform isEqualToString:@"iPad4,6"])   return @"iPad Mini 2G (A1491)";
    
    if ([platform isEqualToString:@"i386"])      return @"iPhone Simulator";
    if ([platform isEqualToString:@"x86_64"])    return @"iPhone Simulator";
    return platform;
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
