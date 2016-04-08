//
//  RegisterThirdViewController.h
//  CashMaker
//
//  Created by 翁志方 on 16/3/31.
//  Copyright © 2016年 wzf. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegisterThirdViewController : UIViewController


@property (strong, nonatomic) NSString *telNumber;

@property (strong, nonatomic) IBOutlet UITextField *pwdTextField;
@property (strong, nonatomic) IBOutlet UITextField *invitorIDTextField;


@property (weak, nonatomic) IBOutlet UIButton *observePwdBtn;//密码是否显示


- (IBAction) observePwdBtnClick:(id)sender;


- (IBAction)finishBtnClked:(id)sender;

@end
