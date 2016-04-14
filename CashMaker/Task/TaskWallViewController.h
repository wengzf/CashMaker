//
//  TaskWallViewController.h
//  CashMaker
//
//  Created by 翁志方 on 16/4/14.
//  Copyright © 2016年 wzf. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "JOYConnect.h"          // 万普

@interface TaskWallViewController : UIBaseViewController

@property (strong, nonatomic) NSString *controlStr;

- (void)showTaskWallWithStr:(NSString *)controlStr;

@end
