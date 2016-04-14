//
//  AppDelegate.m
//  CashMaker
//
//  Created by 翁志方 on 16/2/17.
//  Copyright © 2016年 wzf. All rights reserved.
//

#import "AppDelegate.h"
#import <SMS_SDK/SMSSDK.h>


#import "QumiConfigTool.h"      // 趣米


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    
    // 导航栏全局属性设置
    {   
        [self navigationStyleInit];
    }
    
    // 短信初始化
    {
        NSString *appKey = @"11251bfa2495c";                        // CashMaker
        NSString *appSecret = @"2ec864e58957d6f61bcc705b80324168";
        [SMSSDK registerApp:appKey withSecret:appSecret];
    }

    // 对应广告平台初始化
    {
        [self initAD];
        
    }
    return YES;
}

- (void)initAD
{
    // 趣米
    {
        [QumiConfigTool startWithAPPID:@"62cc05162c766a49" secretKey:@"69cdc500296f4963" appChannel:100055];
        
        //初始化连接成功的回调方法
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(qumiConnectSuccess) name:QUMI_CONNECT_SUCCESS object:nil];
        //初始化连接失败的回调方法
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(qumiConnectFailed:) name:QUMI_CONNECT_FAILED object:nil];
    }
}
//趣米广告初始化连接成功
- (void)qumiConnectSuccess
{
    NSLog(@"初始化连接成功");
}
- (void)qumiConnectFailed:(NSNotification*)notification
{
    //通知传过来的值
    NSDictionary *dic = [notification userInfo];
    //用户获取积分的状态，是否获取成功
    NSString *isConnectFailed = [dic objectForKey:@"QUMI_CONNECT_FAILED"];
    NSLog(@"初始化连接失败的信息：%@",isConnectFailed);
}

#pragma -导航栏风格初始化
- (void)navigationStyleInit {
    
    //    [[UINavigationBar appearance] setBarStyle:UIBarStyleBlack];
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
    
    [[UINavigationBar appearance]setTitleTextAttributes:@{
                                                          NSFontAttributeName:HelveticaNeueFont(18),
                                                          NSForegroundColorAttributeName:[UIColor whiteColor]
                                                          }];
    
    [[UIBarButtonItem appearance]setTitleTextAttributes:@{
                                                          NSFontAttributeName:HelveticaNeueFont(14),
                                                          NSForegroundColorAttributeName:[UIColor colorWithWhite:1.0 alpha:0.8]
                                                          }
                                               forState:UIControlStateNormal];
    
    
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60)
                                                         forBarMetrics:UIBarMetricsDefault];
    
    
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - 广告平台集成



@end
