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
#import "TBSpiritInstrument.h"      // 指盟

#import <ShareSDK/ShareSDK.h>
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/QQApiInterface.h>
#import "WeiboSDK.h"
#import "WXApi.h"

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
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            [self initAD];
        });

    }
    // 分享初始化
    {
        // 分享
        [ShareSDK registerApp:@"88ff9736d7c0"];
        
        
        // 新浪微博
        [ShareSDK connectSinaWeiboWithAppKey:@"3524989141"
                                   appSecret:@"0868259f41b5e6531cee1a466995cd13"
                                 redirectUri:@"http://www.yonglibao.com"];
        
        
        //添加微信应用 注册网址 http://open.weixin.qq.com   (朋友圈)
        [ShareSDK connectWeChatWithAppId:@"wxddf95861f48eae84"
                               appSecret:@"bfeac33db5399b1e0097103b3db26548"
                               wechatCls:[WXApi class]];
        
        //添加QQ应用  注册网址  http://mobile.qq.com/api/
        [ShareSDK connectQQWithQZoneAppKey:@"1104757736"
                         qqApiInterfaceCls:[QQApiInterface class]
                           tencentOAuthCls:[TencentOAuth class]];
        
        //        //添加QQ空间应用  注册网址  http://connect.qq.com/intro/login/
        //        [ShareSDK connectQZoneWithAppKey:@"1104757736"
        //                               appSecret:@"Zn4rTJZMkj84bb2y"
        //                       qqApiInterfaceCls:[QQApiInterface class]
        //                         tencentOAuthCls:[TencentOAuth class]];
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
    
    [self initZhiMeng];
    
    [self initGuoMeng];
    
    [self initJuzhang];
    
    [self initKugao];
    
    [self initMidi];
    
    [self initZhijianhuyu];
    
    [self initYijifen];
    
    [self initWanpu];
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

// 指盟初始化
- (void)initZhiMeng
{
    [TBSpiritInstrument launchFactoryd:@"0947715698a627bbae17ae3f85580ac8" ukrt:@"adusing"];
}
// 果盟
- (void)initGuoMeng
{
    //    11548
    
    
}
// 巨掌
- (void)initJuzhang
{
    
}
// 酷告
- (void)initKugao
{
    
}
// 米迪
- (void)initMidi
{
    
}
// 指间互娱(微信转发)
- (void)initZhijianhuyu
{
    
}
// 易积分
- (void)initYijifen
{
    
}
// 万普
- (void)initWanpu
{
    
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


#pragma mark - 分享代理
- (BOOL)application:(UIApplication *)application
      handleOpenURL:(NSURL *)url
{
    return [ShareSDK handleOpenURL:url
                        wxDelegate:self];
}

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation
{
    return [ShareSDK handleOpenURL:url
                 sourceApplication:sourceApplication
                        annotation:annotation
                        wxDelegate:self];
}


@end
