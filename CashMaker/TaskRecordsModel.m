//
//  TaskRecordsModel.m
//  CashMaker
//
//  Created by 翁志方 on 16/4/21.
//  Copyright © 2016年 wzf. All rights reserved.
//

#import "TaskRecordsModel.h"

@implementation TaskRecordsModel

- (void)fillWithDic:(NSDictionary *)dic
{
    self.taskRecordsID = dic[@"id"];
    self.source_type = dic[@"source_type"];
    self.change_coins = dic[@"change_coins"];

    self.created_at = dic[@"created_at"];
    
}
@end
