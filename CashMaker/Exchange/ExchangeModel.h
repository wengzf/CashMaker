//
//  ExchangeModel.h
//  CashMaker
//
//  Created by 翁志方 on 16/3/12.
//  Copyright © 2016年 wzf. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ExchangeModel : BaseModel

@property (nonatomic, strong) NSString *exchangeID;     //兑换商品ID | integer,
@property (nonatomic, strong) NSString *title;          // 标题 | string,
@property (nonatomic, strong) NSString *img;            // 图片 | string,
@property (nonatomic, strong) NSString *cost_coins;     // 兑换花费金币数 | integer,
@property (nonatomic, strong) NSString *reward_type;    // 兑换类型 1 支付宝现金 2 Q币 3 手机话费 4 亚马逊礼品卡 0 无奖励 | integer,
@property (nonatomic, strong) NSString *reward_amount;  // 兑换数量 | integer



@end
