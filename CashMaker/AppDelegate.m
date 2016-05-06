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

//＝＝＝＝＝＝＝＝＝＝ShareSDK头文件＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKConnector/ShareSDKConnector.h>
//以下是ShareSDK必须添加的依赖库：
//1、libicucore.dylib
//2、libz.dylib
//3、libstdc++.dylib
//4、JavaScriptCore.framework

//＝＝＝＝＝＝＝＝＝＝以下是各个平台SDK的头文件，根据需要继承的平台添加＝＝＝
//腾讯开放平台（对应QQ和QQ空间）SDK头文件
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/QQApiInterface.h>
//以下是腾讯SDK的依赖库：
//libsqlite3.dylib

//微信SDK头文件
#import "WXApi.h"
//以下是微信SDK的依赖库：
//libsqlite3.dylib

//新浪微博SDK头文件
#import "WeiboSDK.h"
//新浪微博SDK需要在项目Build Settings中的Other Linker Flags添加"-ObjC"
//以下是新浪微博SDK的依赖库：
//ImageIO.framework
//libsqlite3.dylib
//AdSupport.framework

#import "JPUSHService.h"

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

    // 极光推送初始化
    {
//        4f799571372f6159811e14ed      AppKey
//        6c00573908916d017b399d52      MasterSecret
        
        NSString *advertisingId = nil;
        
        if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
            //可以添加自定义categories
            [JPUSHService registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge |
                                                              UIUserNotificationTypeSound |
                                                              UIUserNotificationTypeAlert)
                                                  categories:nil];
        } else {
            //categories 必须为nil
            [JPUSHService registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
                                                              UIRemoteNotificationTypeSound |
                                                              UIRemoteNotificationTypeAlert)
                                                  categories:nil];
        }
        
        //如不需要使用IDFA，advertisingIdentifier 可为nil
        [JPUSHService setupWithOption:launchOptions appKey:appKey
                              channel:channel
                     apsForProduction:isProduction
                advertisingIdentifier:advertisingId];
        
        
        
    }
    
    // 对应广告平台初始化
    {
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            [self initAD];
        });

    }
    // 分享初始化
    {
        /**
         *  设置ShareSDK的appKey，如果尚未在ShareSDK官网注册过App，请移步到http://mob.com/login 登录后台进行应用注册，
         *  在将生成的AppKey传入到此方法中。我们Demo提供的appKey为内部测试使用，可能会修改配置信息，请不要使用。
         *  方法中的第二个参数用于指定要使用哪些社交平台，以数组形式传入。第三个参数为需要连接社交平台SDK时触发，
         *  在此事件中写入连接代码。第四个参数则为配置本地社交平台时触发，根据返回的平台类型来配置平台信息。
         *  如果您使用的时服务端托管平台信息时，第二、四项参数可以传入nil，第三项参数则根据服务端托管平台来决定要连接的社交SDK。
         */
        [ShareSDK registerApp:@"88ff9736d7c0"
              activePlatforms:@[
                                @(SSDKPlatformTypeSinaWeibo),
                                @(SSDKPlatformTypeWechat),
                                @(SSDKPlatformTypeQQ)
                                ]
                     onImport:^(SSDKPlatformType platformType) {
                         
                         switch (platformType)
                         {
                             case SSDKPlatformTypeWechat:
                                 //                             [ShareSDKConnector connectWeChat:[WXApi class]];
                                 [ShareSDKConnector connectWeChat:[WXApi class] delegate:self];
                                 break;
                             case SSDKPlatformTypeQQ:
                                 [ShareSDKConnector connectQQ:[QQApiInterface class]
                                            tencentOAuthClass:[TencentOAuth class]];
                                 break;
                             case SSDKPlatformTypeSinaWeibo:
                                 [ShareSDKConnector connectWeibo:[WeiboSDK class]];
                                 break;
                                 
                             default:
                                 break;
                         }
                     }
              onConfiguration:^(SSDKPlatformType platformType, NSMutableDictionary *appInfo) {
                  
                  switch (platformType)
                  {
                      case SSDKPlatformTypeSinaWeibo:
                          //设置新浪微博应用信息,其中authType设置为使用SSO＋Web形式授权
                          [appInfo SSDKSetupSinaWeiboByAppKey:@"568898243"
                                                    appSecret:@"38a4f8204cc784f81f9f0daaf31e02e3"
                                                  redirectUri:@"http://www.sharesdk.cn"
                                                     authType:SSDKAuthTypeBoth];
                          break;
                          
                      case SSDKPlatformTypeWechat:
                          [appInfo SSDKSetupWeChatByAppId:@"wx4868b35061f87885"
                                                appSecret:@"64020361b8ec4c99936c0e3999a9f249"];
                          break;
                      case SSDKPlatformTypeQQ:
                          [appInfo SSDKSetupQQByAppId:@"100371282"
                                               appKey:@"aed9b0303e3ed1e27bae87c33761161d"
                                             authType:SSDKAuthTypeBoth];
                          break;
                      default:
                          break;
                  }
              }];
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
    
    [application setApplicationIconBadgeNumber:0];
    [application cancelAllLocalNotifications];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


- (void)application:(UIApplication *)application
        didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {

    NSLog(@"%@", [NSString stringWithFormat:@"Device Token: %@", deviceToken]);
    [JPUSHService registerDeviceToken:deviceToken];
}
- (void)application:(UIApplication *)application
        didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    NSLog(@"did Fail To Register For Remote Notifications With Error: %@", error);
}
- (void)application:(UIApplication *)application
didReceiveRemoteNotification:(NSDictionary *)userInfo {
    [JPUSHService handleRemoteNotification:userInfo];
    NSLog(@"收到通知:%@", userInfo);
}

- (void)application:(UIApplication *)application
didReceiveRemoteNotification:(NSDictionary *)userInfo
fetchCompletionHandler:
(void (^)(UIBackgroundFetchResult))completionHandler {
    [JPUSHService handleRemoteNotification:userInfo];
    NSLog(@"收到通知:%@", userInfo);
    
    completionHandler(UIBackgroundFetchResultNewData);
}

- (void)application:(UIApplication *)application
didReceiveLocalNotification:(UILocalNotification *)notification {
    [JPUSHService showLocalNotificationAtFront:notification identifierKey:nil];
}
#pragma mark - 广告平台集成


#pragma mark - 分享代理



@end
