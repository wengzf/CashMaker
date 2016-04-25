//
//  TaskViewController.m
//  CashMaker
//
//  Created by 翁志方 on 16/2/17.
//  Copyright © 2016年 wzf. All rights reserved.
//

#import "TaskViewController.h"
#import "TaskTableViewCell.h"

#import <ShareSDK/ShareSDK.h>          // 分享
#import "WXApi.h"
#import <TencentOpenAPI/QQApi.h>

#import "TaskWallViewController.h"

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
            
            NSArray *arr = (NSArray *)dic;
            taskArr = [NSMutableArray array];
    
            for (NSDictionary *tmpDic in arr) {
                TaskModel *model = [TaskModel new];
                model.taskNameStr = tmpDic[@"name"];
                model.titleStr = tmpDic[@"title"];;
                model.hintStr = tmpDic[@"desc"];;
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
        // 分享内容
        id<ISSContent> publishContent = [ShareSDK content:@"CashMaker Test "
                                           defaultContent:@" "
                                                    image:nil
                                                    title:@""
                                                      url:@""
                                              description:@""
                                                mediaType:SSPublishContentMediaTypeNews];
        
        
        // 分享方式
        
        [ShareSDK showShareActionSheet:nil shareList:nil content:publishContent statusBarTips:NO authOptions:nil shareOptions:nil result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
            
        }];

        
    }else if ([model.taskNameStr isEqualToString:@"qumi"]){
        
        //创建积分墙广告 pointUserId可选，根据需要 开发者自己设置，设置PointUserId可以
        //    实现在不同设备上同步该用户的积分。
        _qumiViewController = [[QumiOperationApp alloc] initwithPointUserID:nil] ;
        
        [_qumiViewController initwithPointUserID:Global.userID];
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
        
        TaskWallViewController *vc = [TaskWallViewController new];
        vc.controlStr = controlStr;
        [self.navigationController pushViewController:vc animated:YES];
        
    }else if ([controlStr isEqualToString:@"zhimeng"]) {
        
        [TBDirectorCommand driversrepeated:self correctViewPosition:YES];
    }else if ([controlStr isEqualToString:@"guomeng"]) {
        
        [guoguoTree_vc pushhxwGMW:YES Hscreen:NO];
    }else if ([controlStr isEqualToString:@"midi"]) {
        
        [MyOfferAPI showMiidiAppOffers:self withMiidiDelegate:self];
    }else if ([controlStr isEqualToString:@"kugao"]) {
        
        [coolAdWall showCoolAdWallWithController:self];
    }else if ([controlStr isEqualToString:@"midi"]) {
        
        
    }else if ([controlStr isEqualToString:@"midi"]) {
        
        
    }else if ([controlStr isEqualToString:@"midi"]) {
        
        
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


@end











