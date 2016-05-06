//
//  ExchangeRecordsModel.m
//  CashMaker
//
//  Created by 翁志方 on 16/3/12.
//  Copyright © 2016年 wzf. All rights reserved.
//

#import "ExchangeRecordsModel.h"

@implementation ExchangeRecordsModel


//{
//    "data": [
//             {
//                 "id": "5",
//                 "exchange_title": "支付宝",
//                 "exchange_type": 1,
//                 "exchange_amount": 1,
//                 "exchange_account": "1135",
//                 "send_status": "0",
//                 "note": "花费180个金币, 兑换支付宝现金x1, 兑换账号",
//                 "created_at": "1小时前"
//             }
//             ],
//    "code": 1000,
//    "message": "successful"
//}
- (void)fillWithDic:(NSDictionary *)dic
{
    self.exchangeID = dic[@"id"];
    self.exchange_title = dic[@"exchange_title"];
    self.exchange_type = [dic[@"exchange_type"] stringValue];
    self.exchange_amount = [dic[@"exchange_amount"] stringValue];
    self.exchange_account = dic[@"exchange_account"];
    self.send_status = dic[@"send_status"];
    self.note = dic[@"note"];
    self.created_at = dic[@"created_at"];
    
}

@end
