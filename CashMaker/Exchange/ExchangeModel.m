//
//  ExchangeModel.m
//  CashMaker
//
//  Created by 翁志方 on 16/3/12.
//  Copyright © 2016年 wzf. All rights reserved.
//

#import "ExchangeModel.h"

@implementation ExchangeModel



// override
- (void)fillWithDic:(NSDictionary *)dic
{
    self.exchangeID = dic[@"id"];
    self.title = dic[@"title"];
    self.img = dic[@"img"];
    self.cost_coins = dic[@"cost_coins"];
    self.reward_type = dic[@"reward_type"];
    self.reward_amount = dic[@"reward_amount"];
    
}

@end
