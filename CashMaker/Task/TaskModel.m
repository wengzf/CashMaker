//
//  TaskModel.m
//  CashMaker
//
//  Created by 翁志方 on 16/3/14.
//  Copyright © 2016年 wzf. All rights reserved.
//

#import "TaskModel.h"

@implementation TaskModel


- (void)fillWithDic:(NSDictionary *)dic
{
    self.taskNameStr = dic[@"name"];
    self.titleStr = dic[@"title"];;
    self.hintStr = dic[@"desc"];;
    if ([self.taskNameStr isEqualToString:@"singin"]) {
        self.isSignIn = dic[@"issignin"];
    }
}

@end
