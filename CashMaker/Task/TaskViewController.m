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


#import <ShareSDK/ShareSDK.h>
#import <ShareSDKExtension/SSEShareHelper.h>
#import <ShareSDKUI/ShareSDK+SSUI.h>
#import <ShareSDKUI/SSUIShareActionSheetStyle.h>
#import <ShareSDKUI/SSUIShareActionSheetCustomItem.h>
#import <ShareSDK/ShareSDK+Base.h>
#import <ShareSDKExtension/ShareSDK+Extension.h>

#import "JOYConnect.h"          // 万普
#import "QumiOperationApp.h"    // 趣米
#import "TBDirectorCommand.h"   // 指盟
#import "hxwGMWViewController.h"    // 果盟

#import "MiidiObfuscation.h"        // 米迪
#import "MyOfferAPI.h"

#import "CoolAdOnlineConfig.h"      // 酷告
#import "CoolAdWall.h"

@interface TaskViewController()<JOYConnectDelegate, QMRecommendAppDelegate, hxwGMWDelegate, MyOfferAPIDelegate
,CoolAdOnlineConfigDelegate,CoolAdWallDelegate>
{
    NSMutableArray *taskArr;            // 兑换内容数组
    
    hxwGMWViewController *guoguoTree_vc;    // 果盟
    
    CoolAdWall * coolAdWall;        // 酷告
    
    BOOL today_signinFlag;
}

@property(nonatomic,strong)QumiOperationApp *qumiViewController;        // 趣米

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
    
            
            today_signinFlag = [dic[@"today_signin"] boolValue];
            
            NSArray *arr = dic[@"list"];
            taskArr = [NSMutableArray array];
    
            for (NSDictionary *tmpDic in arr) {
                TaskModel *model = [[TaskModel alloc] initWithDic:tmpDic];
                
                [taskArr addObject:model];
            }

            
            [self.taskTableView reloadData];
        }];
    }
    
    [self initAD];
    
//    //创建积分墙广告 pointUserId可选，根据需要 开发者自己设置，设置PointUserId可以
//    //    实现在不同设备上同步该用户的积分。
//    _qumiViewController = [[QumiOperationApp alloc] initwithPointUserID:nil] ;
//    //设置代理
//    _qumiViewController.delegate = self;
//    
//    //是否隐藏状态栏，如果为YES就隐藏  NO是显示
//    _qumiViewController.isHiddenStatusBar = NO;
//    
//    //自动领取积分 开启自动领取积分功能填写YES 关闭填写NO
//    [_qumiViewController autoGetPoints:NO];
//    
//    
//    [_qumiViewController presentQmRecommendApp:self];

}
-  (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    //
    {
//        self.navigationController.navigationBar.translucent = NO;
        self.navigationController.navigationBar.barTintColor = RGB(24, 150, 252);
        self.navigationController.navigationBarHidden = NO;
        self.navigationController.navigationBar.translucent = NO;
    }
    
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    

}

- (void)viewWillDisappear:(BOOL)animated
{
//    self.navigationController.navigationBar.translucent = YES;
//    self.navigationController.navigationBar.barTintColor = [UIColor clearColor];
//    self.navigationController.navigationBar.shadowImage = [[UIImage alloc] init];
    
    
    UIImage *img = [UIImage imageNamed:@"nav_bg"];
    img = [img stretchableImageWithLeftCapWidth:2 topCapHeight:2];
    [self.navigationController.navigationBar setBackgroundImage:img forBarMetrics:UIBarMetricsDefault];
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
    
    
    NSArray *titleImgArr = @[@"icon_channel_a", @"icon_channel_b", @"icon_channel_c", @"icon_channel_d", @"icon_channel_e", @"icon_channel_f", @"icon_channel_g"];
    cell.titleImageView.image = [UIImage imageNamed:titleImgArr[(indexPath.row + 2)%7 ]];
    
    // cell配置
    TaskModel *model = taskArr[indexPath.row];
    [cell updateCellWithModel:model];
    
    if ([model.taskNameStr isEqualToString:@"signin"] && today_signinFlag) {
        
        cell.titleImageView.image = [UIImage imageNamed:@"icon_checkin_gray"];
        cell.titleLabel.text = @"已签到";
    }
    

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
        
        if (!today_signinFlag) {
            [self.view showLoading];
            [FSNetworkManagerDefaultInstance signinWithUserID:Global.userID successBlock:^(long status, NSDictionary *dic) {
                [self.view hideLoading];
                //            [self.view showLoadingWithMessage:@"成功签到，获得10个金币" hideAfter:2.0];
                
                today_signinFlag = YES;
                
                UIAlertView *alv = [[UIAlertView alloc] initWithTitle:@"签到" message:@"成功签到，获得10个金币" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
                [alv show];
                
                // 对应签到条变成灰色
                model.isSignIn = @"1";
                [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            }];
        }else{
            [self.view showLoadingWithMessage:@"今日已签到" hideAfter:2];
        }
        
    }else if ([model.taskNameStr isEqualToString:@"share"]) {
        // 弹出分享菜单
        // 分享内容
        [self showShareActionSheet:self.view];

        

        
    }else if ([model.taskNameStr isEqualToString:@"qumi"]){
        
        //创建积分墙广告 pointUserId可选，根据需要 开发者自己设置，设置PointUserId可以
        //    实现在不同设备上同步该用户的积分。
        _qumiViewController = [[QumiOperationApp alloc] initwithPointUserID:Global.userID] ;
        
        //设置代理
        _qumiViewController.delegate = self;
        
        //是否隐藏状态栏，如果为YES就隐藏  NO是显示
        _qumiViewController.isHiddenStatusBar = NO;
        
        //自动领取积分 开启自动领取积分功能填写YES 关闭填写NO
        [_qumiViewController autoGetPoints:NO];
        
        [_qumiViewController presentQmRecommendApp:self];
    }else{
        [self showADWithControlStr:model.taskNameStr];
    }
    
}

- (void)showADWithControlStr:(NSString *)controlStr
{
    if ([controlStr isEqualToString:@"share"]) {
        
        
    }else if ([controlStr isEqualToString:@"signin"]) {
        
        
    }else if ([controlStr isEqualToString:@"wanpu"]) {
        
//        TaskWallViewController *vc = [TaskWallViewController new];
//        vc.controlStr = controlStr;
//        [self.navigationController pushViewController:vc animated:YES];
//        
        
        [JOYConnect showList:self.navigationController];

        
    }else if ([controlStr isEqualToString:@"zhimeng"]) {
        
        [TBDirectorCommand driversrepeated:self correctViewPosition:YES];
    }else if ([controlStr isEqualToString:@"guomeng"]) {
        
        [guoguoTree_vc pushhxwGMW:YES Hscreen:NO];
    }else if ([controlStr isEqualToString:@"midi"]) {
        
        [MyOfferAPI showMiidiAppOffers:self withMiidiDelegate:self];
    }else if ([controlStr isEqualToString:@"kugao"]) {
        
        [coolAdWall showCoolAdWallWithController:self];
    }
    
}

#pragma mark - 广告初始化
- (void)initAD
{
    
    
    [self kugao];
    
    [self wanpu];
  
    [self guomeng];
    
    [self midi];

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
- (void)guomeng
{
    //用果果家密钥初始化果果树
    guoguoTree_vc=[[hxwGMWViewController alloc] initWithId:@"6wris13xnue8736"];
    //设置代理
    guoguoTree_vc.delegate=self;
    //设置自动刷新果果的时间间隔
    //******注:不设置该参数的话,SDK默认为20秒,自动刷新时间最小值为15******
    //******设置为0为不自动刷新,开发者自己去控制刷新******
    guoguoTree_vc.updatetime=0;
    
    //设置果果树是否显示状态栏 默认隐藏
    guoguoTree_vc.isStatusBarHidden=NO;
    
    //如果果果服务器回调, 需要用户标识的话, 可以设置UserID参数 如:
    guoguoTree_vc.OtherID = Global.userID;
}
- (void)midi
{
    // Override point for customization after application launch.
    // !!!: Miidi SDK 初始化
    // 设置发布应用的应用id, 应用密码信息,必须在应用启动的时候呼叫
    // 参数 appID		:开发者应用ID ;     开发者到 www.miidi.net 上提交应用时候,获取id和密码
    // 参数 appPassword	:开发者的安全密钥 ;  开发者到 www.miidi.net 上提交应用时候,获取id和密码
    [MyOfferAPI setMiidiAppPublisher:@"5"  withMiidiAppSecret:@"5555555555555555"];
    // 开发者自定义参数， 可以传开发者的User_id
    //[MyOfferAPI setUserParam:<#开发者参数_可以是UserID#>];
}
- (void)kugao
{
#define CoolAdWall_SDKKEY @"RTB20141927070222qwej3y24ogr3zka"
#define CoolAdWall_SECRETKEY @"z9p7dqzodcf3nj1"
    
    //广告墙主体
//    coolAdWall = [[CoolAdWall alloc] initWithAppID:@"RTB20161325010329qv8ox092fwh1a4s" secretKey:@"9rucq8q180kmwr1u" andDelegate:self];
    @try {
        //广告墙主体
        coolAdWall = [[CoolAdWall alloc] initWithAppID:CoolAdWall_SDKKEY secretKey:CoolAdWall_SECRETKEY andDelegate:self];
        [coolAdWall setCoolAdWallColor:CoolAdWallThemeColor_White];
        
        //在线参数
        [CoolAdOnlineConfig shareCoolAdOnlineConfigWithAppID:CoolAdWall_SDKKEY andSecretKey:CoolAdWall_SECRETKEY delegate:self];
    } @catch (NSException *exception) {
        
    } @finally {
        
    }
    
//    

    
    
}

#pragma mark - 万普 delegate
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

#pragma mark - 趣米 delegate
-(void)QMSuccessToLoaded:(QumiOperationApp *)qumiAdApp
{
    NSLog(@"积分墙加载成功回调");
}
-(void)QMFailToLoaded:(QumiOperationApp *)qumiAdApp withError:(NSError *)error
{
    NSLog(@"加载数据失败回调%@",error);
}
-(void)QMDismiss:(QumiOperationApp *)qumiAdApp
{
    NSLog(@"积分墙关闭");
}

#pragma mark - 果盟 delegate
//加载回调 返回参数YES表示加载成功 NO表示失败
- (void)loadGMAdSuccess:(BOOL)success
{
    NSLog(@"loadGMAdSuccess = %d",success);
}


#pragma mark - Miidi SDK Delegate
// !!!: Miidi SDK 打开、关闭 回调
- (void)didMiidiShowWallView
{
    NSLog(@"米迪积分墙打开!");
}

- (void)didMiidiDismissWallView
{
    NSLog(@"米迪积分墙关闭!");
}

// !!!: Miidi SDK 积分墙、推荐墙 展示相关回调  UI定制
- (void)myMiidiOfferViewWillAppear:(UIViewController *)viewController {
    
    // 0 换成 1 看sdk原始效果
    // 可更换返回按钮图片修改返回按钮样式,保证命名一致即可
#if 0
    
    //NavigationBar bj
    if ([viewController.navigationController.navigationBar respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)]) {
        // iOS5 and Later
        [viewController.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navbj.png"] forBarMetrics:UIBarMetricsDefault];
        
    }
    
    // Navigationbar Title Color
    if ([viewController.navigationController.navigationBar respondsToSelector:@selector(setTitleTextAttributes:)]) {
        
        // iOS5 and Later
        UIColor * diyColor = [UIColor blueColor];
        [viewController.navigationController.navigationBar
         setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                 diyColor, UITextAttributeTextColor,
                                 diyColor, UITextAttributeTextShadowColor,
                                 nil]];
        
        // itme color
        if ([self.navigationController.navigationBar respondsToSelector:@selector(setBarTintColor:)])
        {
            // iOS7 and Later
            viewController.navigationController.navigationBar.barTintColor = diyColor;
        }
        
        viewController.navigationController.navigationBar.tintColor = diyColor;
        
    }
    
    
    
#endif
    
}

- (void)myMiidiOfferViewDidAppear:(UIViewController *)viewController {
    
}

// !!!: Miidi SDK 积分墙数据展示成功、失败相关回调
- (void)didMiidiReceiveOffers
{
    NSLog(@"米迪积分墙数据获取成功!");
}


- (void)didMiidiFailToReceiveOffers:(NSError *)error
{
    NSLog(@"米迪积分墙数据获取失败!");
}



#pragma mark - CoolAdWall deleage

- (BOOL)testMode
{
    return NO;
}

- (BOOL)logMode
{
    return YES;
}

// 查询积分回调 参数1.adArray存储的数据位获得积分的广告信息，该数组元素内容为NSDictionary类型，包括广告名字和积分数，key值分别为name和point；参数2.pointData转换为为用户的剩余总积分数，--使用CoolAdWallGetPoint（void *pointData）方法将参数转换为int类型积分数据
- (void)didReceiveResultGetScore:(void *)pointData withAdInfo:(NSArray*)adArray
{
    int point = CoolAdWallGetPoint(pointData);
    NSLog(@"get point--------->%d", point);
    NSString *infoStr = @"";
    if (adArray && [adArray count] > 0)
    {
        // orderId lotNo lotName betCode batchCode prizeState orderPrize orderTime winCode betCode
        for (NSDictionary *dict in adArray)
        {
            NSString *name = [dict objectForKey:@"name"];
            int point = [[dict objectForKey:@"point"] intValue];
            infoStr = [infoStr stringByAppendingString:[NSString stringWithFormat:@"完成【%@】任务获得%d积分\n",name,point]];
        }
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"通知" message:infoStr delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }
    else
    {
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"积分查询"
                                                         message:@"未获得积分"
                                                        delegate:nil
                                               cancelButtonTitle:@"OK"
                                               otherButtonTitles:nil];
        [alert show];
        
    }
}

// 消费积分回调 --使用CoolAdWallGetPoint（void *pointData）方法将参数转换为int类型积分数据，remainPointData参数转换为消费后剩余的总积分数，spendPointData阐述转换为消费的积分数。
- (void)didSpendScoreSuccessAndResidualScore:(void*)remainPointData andSpendScore:(void*)spendPointData
{
    int point = CoolAdWallGetPoint(remainPointData);
    int spendScore = CoolAdWallGetPoint(spendPointData);
    
    NSString * str = [NSString stringWithFormat:@"消费积分:%d,消费后剩余总积分:%d。",point,spendScore];
    
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"积分消费"
                                                     message:str
                                                    delegate:nil
                                           cancelButtonTitle:@"OK"
                                           otherButtonTitles:nil];
    [alert show];

}

// 消费积分失败
- (void)didFailedSpendScoreWithError:(NSError*)error
{
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"积分消费"
                                                     message:error.domain
                                                    delegate:nil
                                           cancelButtonTitle:@"OK"
                                           otherButtonTitles:nil];
    [alert show];
    
}

#pragma mark - CoolAdOnlineConfig delegate

//异步获取在线参数成功回调
- (void)didFinishGetParameters:(NSDictionary*)parameters
{
    NSMutableString *str = [[NSMutableString alloc] init];
    for (NSString *key in [parameters allKeys])
    {
        [str appendString:[NSString stringWithFormat:@"%@:%@\n",key,[parameters objectForKey:key]]];
    }
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"在线参数" message:str delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];

}
//异步获取在线参数失败回调
- (void)didFailGetParameters:(NSError*)error
{
    NSLog(@"%@",error.domain);
}

#pragma mark - 图片处理为灰色

-(UIImage*)getGrayImage:(UIImage*)sourceImage
{
    int width = sourceImage.size.width;
    int height = sourceImage.size.height;
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceGray();
    CGContextRef context = CGBitmapContextCreate (nil,width,height,8,0,colorSpace,kCGImageAlphaNone);
    CGColorSpaceRelease(colorSpace);
    
    if (context == NULL) {
        return nil;
    }
    
    CGContextDrawImage(context,CGRectMake(0, 0, width, height), sourceImage.CGImage);
    UIImage *grayImage = [UIImage imageWithCGImage:CGBitmapContextCreateImage(context)];
    CGContextRelease(context);
    
    return grayImage;
}

- (UIImage*) imageBlackToTransparent:(UIImage*) image
{
    // 分配内存
    const int imageWidth = image.size.width;
    const int imageHeight = image.size.height;
    size_t      bytesPerRow = imageWidth * 4;
    uint32_t* rgbImageBuf = (uint32_t*)malloc(bytesPerRow * imageHeight);
    
    // 创建context
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(rgbImageBuf, imageWidth, imageHeight, 8, bytesPerRow, colorSpace,
                                                 kCGBitmapByteOrder32Little | kCGImageAlphaNoneSkipLast);
    CGContextDrawImage(context, CGRectMake(0, 0, imageWidth, imageHeight), image.CGImage);
    
    // 遍历像素
    int pixelNum = imageWidth * imageHeight;
    uint32_t* pCurPtr = rgbImageBuf;
    for (int i = 0; i < pixelNum; i++, pCurPtr++)
    {
        if ((*pCurPtr & 0xFFFFFF00) == 0)    // 将黑色变成透明
        {
            uint8_t* ptr = (uint8_t*)pCurPtr;
            ptr[0] = 0;
        }
        
        // 改成下面的代码，会将图片转成灰度
        /*uint8_t* ptr = (uint8_t*)pCurPtr;
         // gray = red * 0.11 + green * 0.59 + blue * 0.30
         uint8_t gray = ptr[3] * 0.11 + ptr[2] * 0.59 + ptr[1] * 0.30;
         ptr[3] = gray;
         ptr[2] = gray;
         ptr[1] = gray;*/
    }
    
    // 将内存转成image
    CGDataProviderRef dataProvider = CGDataProviderCreateWithData(NULL, rgbImageBuf, bytesPerRow * imageHeight, NULL);
    CGImageRef imageRef = CGImageCreate(imageWidth, imageHeight, 8, 32, bytesPerRow, colorSpace,
                                        kCGImageAlphaLast | kCGBitmapByteOrder32Little, dataProvider,
                                        NULL, true, kCGRenderingIntentDefault);
    CGDataProviderRelease(dataProvider);
    
    UIImage* resultUIImage = [UIImage imageWithCGImage:imageRef];
    
    // 释放
    CGImageRelease(imageRef);
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    // free(rgbImageBuf) 创建dataProvider时已提供释放函数，这里不用free
    
    return resultUIImage;
}

#pragma mark 显示分享菜单


/**
 *  显示分享菜单
 *
 *  @param view 容器视图
 */
- (void)showShareActionSheet:(UIView *)view
{
    /**
     * 在简单分享中，只要设置共有分享参数即可分享到任意的社交平台
     **/
    
    //1、创建分享参数（必要）
    NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
    
    NSArray* imageArray = @[[UIImage imageNamed:@"icon_40"]];
    [shareParams SSDKSetupShareParamsByText:@"天天赚钱"
                                     images:imageArray
                                        url:[NSURL URLWithString:@"http://www.shoujizhuan.com.cn"]
                                      title:@"手机赚"
                                       type:SSDKContentTypeAuto];
    
    //1.2、自定义分享平台（非必要）
    NSMutableArray *activePlatforms = [NSMutableArray arrayWithArray:[ShareSDK activePlatforms]];
    //添加一个自定义的平台（非必要）
    SSUIShareActionSheetCustomItem *item = [SSUIShareActionSheetCustomItem itemWithIcon:[UIImage imageNamed:@"Icon.png"]
                                                                                  label:@"自定义"
                                                                                onClick:^{
                                                                                    
                                                                                    //自定义item被点击的处理逻辑
                                                                                    NSLog(@"=== 自定义item被点击 ===");
                                                                                    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"自定义item被点击"
                                                                                                                                        message:nil
                                                                                                                                       delegate:nil
                                                                                                                              cancelButtonTitle:@"确定"
                                                                                                                              otherButtonTitles:nil];
                                                                                    [alertView show];
                                                                                }];
    [activePlatforms addObject:item];
    //2、分享
    [ShareSDK showShareActionSheet:view
                             items:nil
                       shareParams:shareParams
               onShareStateChanged:^(SSDKResponseState state, SSDKPlatformType platformType, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error, BOOL end) {
                   
                   switch (state) {
                           
                       case SSDKResponseStateBegin:
                       {
//                           [theController showLoadingView:YES];
                           break;
                       }
                       case SSDKResponseStateSuccess:
                       {
                           //Facebook Messenger、WhatsApp等平台捕获不到分享成功或失败的状态，最合适的方式就是对这些平台区别对待
                           if (platformType == SSDKPlatformTypeFacebookMessenger)
                           {
                               break;
                           }
                           
                           UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享成功"
                                                                               message:nil
                                                                              delegate:nil
                                                                     cancelButtonTitle:@"确定"
                                                                     otherButtonTitles:nil];
                           [alertView show];
                           
                           
                           NSString *platformStr = @"1";
                           switch (platformType) {
                               case SSDKPlatformTypeSinaWeibo:
                                   platformStr = @"1";
                                   break;
                               case SSDKPlatformTypeWechat:
                                   platformStr = @"2";
                                   break;
                               case SSDKPlatformTypeQQ:
                                   platformStr = @"3";
                                   break;
                                   
                               default:
                                   break;
                           }
                           
                           [FSNetworkManagerDefaultInstance shareWithUserID:Global.userID platform:platformStr successBlock:^(long status, NSDictionary *dic) {
                               
                           }];
                           break;
                       }
                       case SSDKResponseStateFail:
                       {
                           if (platformType == SSDKPlatformTypeSMS && [error code] == 201)
                           {
                               UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享失败"
                                                                               message:@"失败原因可能是：1、短信应用没有设置帐号；2、设备不支持短信应用；3、短信应用在iOS 7以上才能发送带附件的短信。"
                                                                              delegate:nil
                                                                     cancelButtonTitle:@"OK"
                                                                     otherButtonTitles:nil, nil];
                               [alert show];
                               break;
                           }
                           else if(platformType == SSDKPlatformTypeMail && [error code] == 201)
                           {
                               UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享失败"
                                                                               message:@"失败原因可能是：1、邮件应用没有设置帐号；2、设备不支持邮件应用；"
                                                                              delegate:nil
                                                                     cancelButtonTitle:@"OK"
                                                                     otherButtonTitles:nil, nil];
                               [alert show];
                               break;
                           }
                           else
                           {
                               UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享失败"
                                                                               message:[NSString stringWithFormat:@"%@",error]
                                                                              delegate:nil
                                                                     cancelButtonTitle:@"OK"
                                                                     otherButtonTitles:nil, nil];
                               [alert show];
                               break;
                           }
                           break;
                       }
                       case SSDKResponseStateCancel:
                       {
//                           UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享已取消"
//                                                                               message:nil
//                                                                              delegate:nil
//                                                                     cancelButtonTitle:@"确定"
//                                                                     otherButtonTitles:nil];
//                           [alertView show];
                           break;
                       }
                       default:
                           break;
                   }
               }];
    
    //另附：设置跳过分享编辑页面，直接分享的平台。
    //        SSUIShareActionSheetController *sheet = [ShareSDK showShareActionSheet:view
    //                                                                         items:nil
    //                                                                   shareParams:shareParams
    //                                                           onShareStateChanged:^(SSDKResponseState state, SSDKPlatformType platformType, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error, BOOL end) {
    //                                                           }];
    //
    //        //删除和添加平台示例
    //        [sheet.directSharePlatforms removeObject:@(SSDKPlatformTypeWechat)];
    //        [sheet.directSharePlatforms addObject:@(SSDKPlatformTypeSinaWeibo)];
    
}




@end











