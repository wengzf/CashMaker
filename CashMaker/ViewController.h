//
//  ViewController.h
//  CashMaker
//
//  Created by 翁志方 on 16/2/17.
//  Copyright © 2016年 wzf. All rights reserved.
//

#import <UIKit/UIKit.h>

#define HomeVC [ViewController shareInstance]


@interface ViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>

+ (id)shareInstance;

@property (weak, nonatomic) IBOutlet UILabel *todayCoinsLabel;

@property (weak, nonatomic) IBOutlet UILabel *restCoinsLabel;

@property (weak, nonatomic) IBOutlet UILabel *totalCoinsLabel;

@property (weak, nonatomic) IBOutlet UITableView *exchangeTableView;

@property (weak, nonatomic) IBOutlet UIButton *vieweAccountBtn;

- (IBAction)viewAccountBtnClked:(id)sender;         // 查看账户


- (IBAction)taskBtnClked:(id)sender;
- (IBAction)exchangeBtnClked:(id)sender;
- (IBAction)guaguaBtnClked:(id)sender;
- (IBAction)settingBtnClked:(id)sender;

- (void)showLogin;

@end
