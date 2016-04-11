//
//  ExchangeRecordsModel.h
//  CashMaker
//
//  Created by 翁志方 on 16/3/12.
//  Copyright © 2016年 wzf. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ExchangeRecordsModel : BaseModel

//        *      exchanges: 前5条兑换记录 [
//                                   *          id: 活动兑换记录ID | integer,
//                                   *          exchange_title: 兑换标题 | string,
//                                   *          exchange_account: 兑换账号 | string,
//                                   *          send_status: 兑换奖励发放状态  0 已生成  1 已发放  2 拒绝发放 | integer,
//                                   *          note: 派发兑换奖励备注 如帐号错误等 | string,
//                                   *          created_at: 申请兑换时间 | string
//                                   *      ] | array


@property (strong, nonatomic) NSString *exchangeID;

@property (strong, nonatomic) NSString *exchange_title;

@property (strong, nonatomic) NSString *exchange_account;

@property (strong, nonatomic) NSString *send_status;

@property (strong, nonatomic) NSString *note;

@property (strong, nonatomic) NSString *created_at;




@end
