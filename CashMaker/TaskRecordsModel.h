//
//  TaskRecordsModel.h
//  CashMaker
//
//  Created by 翁志方 on 16/4/21.
//  Copyright © 2016年 wzf. All rights reserved.
//

#import "BaseModel.h"

@interface TaskRecordsModel : BaseModel


//id: 金币记录ID | integer,
//*      source_type: 金币来源类型 101 签到  102 分享 103 刮刮卡 201 兑换 202 抽奖 203 刮刮卡 | integer,
//*      change_coins: 变动金币数 | integer,
//*      created_at: 创建时间 | string
//      "created_at": {
//              "date": "2016-04-15 07:17:19.000000",
//              "timezone_type": 3,
//              "timezone": "UTC"
//         }

@property (strong, nonatomic) NSString *taskRecordsID;

@property (strong, nonatomic) NSString *source_type;
@property (strong, nonatomic) NSString *source_name;

@property (strong, nonatomic) NSString *change_coins;

@property (strong, nonatomic) NSString *created_at;




@end
