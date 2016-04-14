//
//  DGWallListViewController.h
//  DGTempate
//
//  Created by diangao on 15/6/9.
//  Copyright (c) 2015年 diangao. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol QMRecommendAppDelegate;


@interface QumiOperationApp : UIViewController

@property(nonatomic,strong)NSString *userPointId;

@property(nonatomic,assign)id<QMRecommendAppDelegate> delegate;
/**
 *  是否隐藏状态栏，如果为YES就隐藏  NO是显示
 */
@property (nonatomic,assign)  BOOL    isHiddenStatusBar;
/**
 *  初始化方法
 *
 *  @param pointUserId 如果你希望在几部不同的设备中同步积分，比如你的app是游戏类的，用户注册了一个游戏账号，当这个用户换另一部手机，用该账号登陆，期望同步该账户的积分。这种情况可以设置用户pointUserId，pointUserId的优先级高于设备序列号，所以要请谨慎设置，有问题可以咨询我们商务或者技术
 *
 *  @return self
 */
- (id)initwithPointUserID:(NSString *)pointUserId;
/**
 *  跳转到积分墙界面
 *  @param ofType        积分墙类型
 *  @param parController 跳转的viewcontroller
 */
-(void)presentQmRecommendApp:(UIViewController *)parController;


#pragma mark 积分相关操作
/**
 *  自动检查领取积分，如果您要使用自动领取积分功能 就选择调用该方法
 *
 *  @param isAutoCheck  YES，就会自动检查是否有积分可以领取， NO，就不会检查是否有积分领取，那么就需要您调用手动领取
 */
- (void)autoGetPoints:(BOOL)isAutoCheck;
/**
 *  手动检查领取积分 开发者可以选择手动调用检查领取积分的方法
 */
- (void)getPointsQueue;
/**
 *  查询剩余积分
 */
- (void)queryRemainPoints;

/**
 *  消费积分
 *
 *  @param points 消费的积分数
 */
- (void)consumePoints:(NSInteger)points;

/**
 *  追加积分
 *
 *  @param points 追加的积分数
 */
- (void)appendPoints:(NSInteger)points;


@end

@protocol QMRecommendAppDelegate <NSObject>
//
@optional
#pragma mark QMRecommendApp Methods
/**********************************
 *   加载，展示，关闭的回调方法   *
 **********************************/
/**
 *  加载成功，回调该方法
 *
 *  @param qumiAdApp self
 */
- (void)QMSuccessToLoaded:(QumiOperationApp *)qumiAdApp;
/**
 *  加载广告失败后，回调该方法
 *
 *  @param qumiAdApp self
 *  @param error     失败返回信息
 */
- (void)QMFailToLoaded:(QumiOperationApp *)qumiAdApp withError:(NSError *)error;
/**
 *  开始展示，回调该方法
 *
 *  @param qumiAdApp self
 */
- (void)QMPresent:(QumiOperationApp *)qumiAdApp;
/**
 *  关闭，回调该方法
 *
 *  @param qumiAdApp self
 */
- (void)QMDismiss:(QumiOperationApp *)qumiAdApp;

/**
 *  点击列表，copy，打开应用跳转统计失败的回调
 *
 *  @param qumiAdApp self
 *  @param error     错误信息
 */
//- (void)QMFailToRecord:(QumiWallListViewController *)qumiAdApp withError:(NSError *)error;


#pragma mark - QMRecommendApp CheckPoints Methods
/************************************************
 *   检查积分，获取积分，消费积分，追加积分的回调方法   *
 ************************************************/
@required
/*
 *注意：该方法必选，否则无法正常获取积分
 */
//请求领取积分成功方法的回调
- (void)QMGetPointSuccess:(NSString *)getPointState getPoints:(NSInteger)points;
//- (void)QMGetPointSuccess:(BOOL)hasPointState getPoints:(NSDictionary *)points;

//请求领取积分失败方法的回调
- (void)QMGetPointFailed:(NSError *)error;

//请求检查剩余积分成功后，回调该方法，获得总积分数和返回的积分数。
- (void)QMCheckPointsSuccess:(NSInteger)remainPoints;

//请求检查剩余积分失败后，回调该方法，返回检查积分失败信息
-(void)QMCheckPointsFailWithError:(NSError *)error;

#pragma mark QMRecommendApp ConsumePoints Mehtods
//消费请求成功之后，回调该方法，返回消费情况(消费成功，或者当前的积分不足)，以及当前的总积分数
- (void)QMConsumePointsSuccess:(NSString *)ConsumeState remainPoints:(NSInteger)points;

//消费请求失败之后，回调该方法，返回失败信息。
- (void)QMConsumePointsFailWithError:(NSError *)error;

#pragma mark QMRecommendApp AppendPoints Mehtods
//追加积分成功后，回调该方法，返回追加积分的情况(追加积分成功)，以及当前的总积分数
- (void)QMAppendPointsSuccess:(NSString *)appendState remainPoints:(NSInteger)points;

//追加积分失败后，回调该方法，返回失败信息
- (void)QMAppendPointsFailWithError:(NSError *)error;









@end




