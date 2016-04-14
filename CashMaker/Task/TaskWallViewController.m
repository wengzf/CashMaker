//
//  TaskWallViewController.m
//  CashMaker
//
//  Created by 翁志方 on 16/4/14.
//  Copyright © 2016年 wzf. All rights reserved.
//

#import "TaskWallViewController.h"

@interface TaskWallViewController ()

@end

@implementation TaskWallViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    self.title = @"免费获取积分";
}
- (void)viewWillAppear:(BOOL)animated
{
    
}
- (void)viewDidAppear:(BOOL)animated
{
    [self showTaskWallWithStr:self.controlStr];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)showTaskWallWithStr:(NSString *)controlStr
{
    if ([controlStr isEqualToString:@"wanpu"]) {
        
        [JOYConnect showList:self];

    }
}


@end
