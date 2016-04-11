//
//  TaskModel.h
//  CashMaker
//
//  Created by 翁志方 on 16/3/14.
//  Copyright © 2016年 wzf. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TaskModel : BaseModel


@property (nonatomic, strong) NSString *taskNameStr;
@property (nonatomic, strong) NSString *titleStr;              
@property (nonatomic, strong) NSString *hintStr;

@end
