//
//  ExchangeRecordsModel.m
//  CashMaker
//
//  Created by 翁志方 on 16/3/12.
//  Copyright © 2016年 wzf. All rights reserved.
//

#import "ExchangeRecordsModel.h"

@implementation ExchangeRecordsModel

- (void)fillWithDic:(NSDictionary *)dic
{
    self.exchangeID = dic[@"id"];
    self.exchange_title = dic[@"exchange_title"];
    self.exchange_account = dic[@"exchange_account"];
    self.send_status = dic[@"send_status"];
    self.note = dic[@"note"];
    self.created_at = dic[@"created_at"];
    
}

@end
