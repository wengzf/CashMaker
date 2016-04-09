//
//  ScratchCardViewController.m
//  CashMaker
//
//  Created by 翁志方 on 16/2/17.
//  Copyright © 2016年 wzf. All rights reserved.
//

#import "ScratchCardViewController.h"

@implementation ScratchCardViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 页面初始化
    {
        self.scratchView.layer.borderColor = UIColorWithHex(0x0078b4).CGColor;
        self.scratchView.layer.borderWidth = 1.5;
    }

}
-  (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    
}


@end
