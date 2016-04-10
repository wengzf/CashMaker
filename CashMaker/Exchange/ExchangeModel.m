//
//  ExchangeModel.m
//  CashMaker
//
//  Created by 翁志方 on 16/3/12.
//  Copyright © 2016年 wzf. All rights reserved.
//

#import "ExchangeModel.h"

@implementation ExchangeModel

- (id)initWithDic:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        [self fillWithDic:dic];
    }
    return self;
}

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
