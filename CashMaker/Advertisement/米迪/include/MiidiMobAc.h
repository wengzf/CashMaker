//
//  MiidiMobAc.h
//  MiidiMobAc
//
//  Created by MacBookPro on 15/5/15.
//  Copyright (c) 2015年 org.iOS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "MiidiMobAcPubHeader.h"

@class MiidiMobAcSlabSourceItem;

@interface MiidiMobAc : NSObject

#pragma mark - 1_0.* 配置SDK接口<开发者必调接口>
/**
 *  @brief  初始化SDK接口,必须配置
 *
 *  @param publisher 开发者应用ID ;     开发者到 www.miidi.net 上提交应用时候,获取id和密码
 *  @param secret    开发者的安全密钥 ;  开发者到 www.miidi.net 上提交应用时候,获取id和密码
 */
+ (void)setMiidiSlabPublisher:(NSString *)publisher withMiidiSlabSecret:(NSString *)secret;


#pragma mark 1_1.. 设置用户ID接口<开发者可选接口>
// 用于服务器积分对接,设置自定义参数,参数可以传递给对接服务器
// 参数 paramText				: 需要传递给对接服务器的自定义参数
+ (void)setMiidiSlabUserParam:(NSString *)paramText;


#pragma mark - 2_1 资源展示接口
// 显示积分墙
+ (BOOL)showMiidiSlabView:(UIViewController *)hostViewController withMiidiDelegate:(id<MiidiMobAcSlabDelegate>) delegate;

// 显示无积分推荐墙
// 参数 hostViewController		: 通过api [hostViewController presentModalViewController:nav animated:YES];
+ (BOOL)showMiidiSlabViewNoScore:(UIViewController*)hostViewController withMiidiDelegate:(id<MiidiMobAcSlabDelegate>) delegate;

#pragma mark  2_2 数据源接口
+ (void)requestMiidiSlabSourcesWithBlock:(void (^)(NSArray*, NSError *))receivedBlock;
+ (BOOL)requestMiidiSlabSourcesItemClickAd:(MiidiMobAcSlabSourceItem *)item;
#pragma mark  2_3 数据源接口<扩展>
+ (BOOL)requestMiidiSlabSourcesExtenClickAdByProtocol:(NSString *)item;

#pragma mark - 3 API对接接口
//积分查询, 增加用户积分, 扣除用户积分接口
+ (void)requestMiidiSlabGetPoints:(id<MiidiMobAcSlabDelegate>)delegate;
+ (void)requestMiidiSlabCutPoints:(NSInteger)points withMiidiDelegate:(id<MiidiMobAcSlabDelegate>)delegate;
+ (void)requestMiidiSlabAddPoints:(NSInteger)points withMiidiDelegate:(id<MiidiMobAcSlabDelegate>)delegate;

#pragma mark - 4 其他功能接口
// 获取Miidi广告IOS 版本号
+ (NSString*)getMiidiSlabSdkVersion;


@end
