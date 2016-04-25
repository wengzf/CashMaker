//
//  TaskRecordsModel.h
//  CashMaker
//
//  Created by 翁志方 on 16/4/21.
//  Copyright © 2016年 wzf. All rights reserved.
//

#import "BaseModel.h"

@interface TaskRecordsModel : BaseModel



//*      [
//        *          id: 金币记录ID | integer,
//        *          source_title: 金币来源title | string,
//        *          source_type: 金币来源类型 101 签到  102 分享 103 刮刮卡 201 兑换 202 抽奖 203 刮刮卡 | integer,
//        *          change_coins: 变动金币数 | integer,
//        *          created_at: 记录时间 | string
//        *      ]

@property (strong, nonatomic) NSString *taskRecordsID;

@property (strong, nonatomic) NSString *source_type;
@property (strong, nonatomic) NSString *source_title;

@property (strong, nonatomic) NSString *change_coins;

@property (strong, nonatomic) NSString *created_at;




@end
