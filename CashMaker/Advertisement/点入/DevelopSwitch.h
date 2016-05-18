//
//  YQLSDK.h
//  UITest
//
//  Created by Wen Yunlong on 14-8-8.
//  Copyright (c) 2014年 YuJie. All rights reserved.
//
#import "CallFlower.h"
#define DR_OFFERWALL    1   //积分墙
#define DR_FREEWALL     2   //免费墙


/**********************************************/
/*初始化接口，必须初始化                          */
/*key   :applicationKey                       */
/*value :是否开启定位                           */
/*userid:用户id一般游戏的角色id                  */
/**********************************************/
#define DR_INIT(key, isuse, userid) [YQLSDK dianruInitialize:key dianruLocation:isuse dianruAppuserid:userid];

/*****************************************************************/
/*显示广告                                                        */
/*type  : 广告类型  类如 DR_OFFERWALL                              */
/*root  : 传入的viewcontroller                                    */
/*dg    : 代理人 实现一些回调用的 如果用不到 传空就行                   */
/*****************************************************************/
#define DR_SHOW(type, root, dg) [YQLSDK dianruShow:type dianruOn:root dianruDelegate:dg];

/*****************************************************************/
/*创建广告，等自己需要的时候在present                                 */
/*type  : 广告类型  类如 DR_OFFERWALL                              */
/*dg    : 代理人 实现一些回调用的 如果用不到 传空就行                   */
/*****************************************************************/
#define DR_CREATE(type, dg) [YQLSDK dianruCreate:type dianruDelegate:dg];

/**********************************************/
/*获取总积分                                    */
/*result:总分数                                */
/**********************************************/
#define GETSCORE(score_block) [YQLSDK getDianruScore:score_block];

/**********************************************/
/*消费积分接口                                  */
/*point :消费多少积分                           */
/*result:如果成功返回true,否则false              */
/**********************************************/
#define SPENDSCORE(sore,score_block) [YQLSDK getDianruSpendScore:sore dianruCallback:score_block];


@protocol YQLDelegate <NSObject>
@optional

/*********************/
/*广告创建成功         */
/*********************/
- (void)dianruDidOpen:(UIViewController *)vc;

/*********************/
/*HTML墙加载失败的回调  */
/*********************/
- (void)dianruDidLoadFail:(UIViewController *)vc;

/*********************/
/*点击关闭广告         */
/*不代表广告从内存中释放 */
/*********************/
- (void)dianruDidClose:(UIViewController *)vc;

/*********************/
/*广告彻底释放         */
/*从内存中删除         */
/*********************/
- (void)dianruDidDestroy:(UIViewController *)vc;

/*********************/
/*点击广告            */
/*********************/
- (void)dianruDidClicked:(UIViewController *)vc dianruData:(id)data;

/*********************/
/*点击跳转            */
/*********************/
- (void)dianruDidJumped:(UIViewController *)vc dianruData:(id)data;

/****************************************************/
/*广告列表回调                                        */
/*view :广告view                                     */
/*code :广告条数大于0，那么code=0，代表成功 反之code = -1 */
/****************************************************/
- (void)dianruDidDataReceived:(UIViewController *)vc dianruCode:(int)code;

@end

typedef void (^dianruScoreResultCallback)(int result);
typedef void (^dianruSpendScoreResultCallback)(NSString *result);

@interface YQLSDK : NSObject<NSURLConnectionDelegate>

+(void)dianruInitialize:(NSString *)key
         dianruLocation:(BOOL)value
        dianruAppuserid:(NSString *)appuserid;

+(void)dianruShow:(NSInteger)space
         dianruOn:(UIViewController *)root
   dianruDelegate:(id<YQLDelegate>)delegate;

+(void)dianruCreate:(NSInteger)space
     dianruDelegate:(id<YQLDelegate>)delegate;

+(void)getDianruScore:(dianruScoreResultCallback)score;

+(void)getDianruSpendScore:(int)point
           dianruCallback :(dianruSpendScoreResultCallback) score;

@end


