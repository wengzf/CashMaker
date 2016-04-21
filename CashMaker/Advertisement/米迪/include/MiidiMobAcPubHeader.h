//
//  MiidiMobAcPubHeader.h
//  MiidiMobAc
//
//  Created by MacBookPro on 15/5/15.
//  Copyright (c) 2015年 org.iOS. All rights reserved.
//

#ifndef MiidiMobAc_MiidiMobAcPubHeader_h
#define MiidiMobAc_MiidiMobAcPubHeader_h

@protocol MiidiMobAcSlabDelegate <NSObject>

@optional

#pragma mark - 积分墙, 推荐墙 展示接口调用后的回掉方法

// 这6个Delegate执行顺序
// --> myMiidiOfferViewWillAppear:
// --> myMiidiOfferViewDidAppear:
// --> didMiidiShowWallView
// --> didMiidiReceiveOffers/didMiidiFailToReceiveOffers:
// --> didMiidiDismissWallView

// 积分墙/推荐墙 视图展示 展开&关闭 Delegate
- (void)didMiidiShowWallView;
- (void)didMiidiDismissWallView;
// 积分墙/推荐墙 数据拉取 成功&失败 Delegate
- (void)didMiidiReceiveOffers;
- (void)didMiidiFailToReceiveOffers:(NSError *)error;
#pragma mark UI DIY
- (void)myMiidiOfferViewWillAppear:(UIViewController *)viewController;
- (void)myMiidiOfferViewDidAppear:(UIViewController *)viewController;

#pragma mark - API对接接口 调用 相关的回掉方法

// 补充：totalPoints: 返回用户的总积分
//      pointName  : 返回的积分名称

// GetValue Delegate
- (void)didMiidiReceiveGetPoints:(NSInteger)totalPoints forMiidiPointName:(NSString*)pointName;
- (void)didMiidiFailReceiveGetPoints:(NSError *)error;
// AddValue Delegate
- (void)didMiidiReceiveAddPoints:(NSInteger)totalPoints;
- (void)didMiidiFailReceiveAddPoints:(NSError *)error;
// CutValue Delegate
- (void)didMiidiReceiveCutPoints:(NSInteger)totalPoints;
- (void)didMiidiFailReceiveCutPoints:(NSError *)error;




@end



#pragma mark - #######################################
#pragma mark - 数据源模式接口

// !!!: NSError 规范
/*/
 * Domain : MiidiWallSDK     - (NSString *)domain;
 * Code : ...                - (NSInteger)code;
 * Desc :                    - (NSDictionary *)userInfo; NSLocalizedDescriptionKey
 *
 /*/


/*/
 *  code   :   desc                         Note
 *  0           well servered
 *  20001       bad request!
 *  20002       don't have enought score    // cut points
 *  20003       bad sequence!
 *  20004       device not init             // seq error
 *  20005       interface close             // 接口不允许
 */


// 数据源模式 的 数据模型
@interface MiidiMobAcSlabSourceItem : NSObject

/*
 * 1.弃用部分属性值*
 * 2.预留miidiAppStoreId 属性值, 服务器可能后期传值 1.5.2开始
 * 3.miidiAppImageUrls类型有NSArray 改为NSString 1.5.3开始
 */
//显示相关
@property(nonatomic, retain, readonly) NSString * miidiAdTitle;       //广告标题
@property(nonatomic, retain, readonly) NSString * miidiAdSubtitle;    //广告子标题
@property(nonatomic, retain, readonly) NSString * miidiAdIconUrl;     //广告小图
@property(nonatomic, retain, readonly) NSString * miidiAdEarnStep;    //获取积分步骤提示（例如：首次下载，注册一个新帐号）
@property(nonatomic, assign, readonly) NSInteger  miidiAdScore;       //广告收益
@property(nonatomic, retain, readonly) NSString * miidiAdClick;       //广告点击

// 用于搜索类的广告
@property(nonatomic, retain, readonly) NSString * miidiAdSearchKey;     //广告搜索关键字
@property(nonatomic, retain, readonly) NSString * miidiAdDetailStep;    //任务详细步骤
@property(nonatomic, assign, readonly) BOOL       miidiAdIsASO;         //是否是搜索类的广告
// 广告app基本信息
@property(nonatomic, retain, readonly) NSString * miidiAppVersion;      // AdApp版本
@property(nonatomic, retain, readonly) NSString * miidiAppPackage;      // AdApp包名
@property(nonatomic, retain, readonly) NSString * miidiAppStoreId;      // AdAppAppid 服务器暂无值
@property(nonatomic, assign, readonly) NSInteger  miidiAppSize;         // AdApp安装包大小
@property(nonatomic, retain, readonly) NSString * miidiAppImageUrls;    // AdApp截图  //!!!: √数据类型变化
@property(nonatomic, retain, readonly) NSString * miidiAppDescription;  // AdApp包名




// !!!: √ [重要]被废弃掉的属性, 值<不可用>
@property(nonatomic, retain, readonly) NSString * miidiAdId;          //广告标识
@property(nonatomic, retain, readonly) NSString * miidiAdAction;      //用于存储“安装”或“注册”的字段
@property(nonatomic, assign, readonly) NSInteger  miidiAdCacheType;
@property(nonatomic, retain, readonly) NSString * miidiAppName;         // AdApp名称
@property(nonatomic, retain, readonly) NSString * miidiAppProvider;     // AdApp提供商

- (id)initMiidiSlabSourceItemWithDictionary:(NSDictionary *)dictionary;

@end


#endif
