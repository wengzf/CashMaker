//
//  SettingViewController.m
//  CashMaker
//
//  Created by 翁志方 on 16/2/17.
//  Copyright © 2016年 wzf. All rights reserved.
//

#import "SettingViewController.h"

@implementation SettingViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
}
-  (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // 导航栏
    {
        self.navigationController.navigationBar.translucent = NO;
        self.navigationController.navigationBar.tintColor = [UIColor blueColor];
        self.navigationController.navigationBar.shadowImage = [[UIImage alloc] init];
    }
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    // 导航栏
    {
        self.navigationController.navigationBar.translucent = NO;
        self.navigationController.navigationBar.tintColor = [UIColor blueColor];
        self.navigationController.navigationBar.shadowImage = [[UIImage alloc] init];
    }
}





- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    static NSInteger count = 0;
    NSLog(@"%ld",count++);
    
    return 11;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSInteger count = 0;
    NSLog(@"%ld,%ld",indexPath.row, count++);
    
    NSInteger row = indexPath.row;
    if (row==3) return 10;
    if (row==8) return 30;
    return 50;
}


- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [cell resetDeviderLineToOnePixel];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"hello");
    
    switch (indexPath.row){
        case 0:{
            
        } break;
        case 1:{
            
        } break;
        case 2:{
            
        } break;
        case 3:{
            
        } break;
        case 4:{
            
        } break;
        case 5:{
            
        } break;
        case 6:{
            
        } break;
        case 7:{
            
        } break;
        case 8:{
            
        } break;
            
    }
    
    
    
}


@end
