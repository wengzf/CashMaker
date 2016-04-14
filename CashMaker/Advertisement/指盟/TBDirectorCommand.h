//
//  TBDirectorCommand.h   this class is section of AAC
//
//
//  Created by baozhou on 14-8-8.
//  Copyright (c) 2014年 baozhou. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#define  FACTORY_DONETHING     @"FACTORY_DONETHING"
#define  FACTORY_NOTTHING      @"FACTORY_NOTTHING"
#define  FACTORY_DESCRIDONE    @"FACTORY_DESCRIDONE"
#define  FACTORY_REDUEDONE      @"FACTORY_REDUEDONE"
#define JQFACTORY_CLOSE @"JQFACTORY_CLOSE"

@interface TBDirectorCommand : NSObject
+ (void)driversrepeated:(UIViewController *)basedpaveViewcontroller correctViewPosition:(BOOL)correctPositonSet;
@end

@interface PZTools : NSObject
/*
 //初始化，此接口是使用查询 消费 增加接口的必要条件，如果使用查询 消费 增加的接口，务必初始化此接口
 */
+ (PZTools *)jqsHenable;
/*
 查询 ，结果在FACTORY_DONETHING通知里回调
 */
+ (void)getZJYouWant;
/*
 消费 ，结果在ZJP_CUTSUCCESS通知里回调
 */
+ (void)cutJQSWant:(double)JQSZVWant;
/*
 增加 ，结果会在ZJP_ADDSUCCESS通知里回调
 */
+ (void)addJQSneed:(double)JQSZCneed;
@end
