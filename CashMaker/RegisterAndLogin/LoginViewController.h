//
//  LoginViewController.h
//  CashMaker
//
//  Created by 翁志方 on 16/3/30.
//  Copyright © 2016年 wzf. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController


@property (strong, nonatomic) IBOutlet UITextField *accountTextField;
@property (strong, nonatomic) IBOutlet UITextField *pwdTextField;

@property (strong, nonatomic) IBOutlet UIButton *loginButton;//登录按钮
@property (weak, nonatomic) IBOutlet UIButton *observePwdBtn;//密码是否显示


@property(nonatomic,copy)NSString *telNumberStr;//从注册页面传来的电话号码 如果有的话就显示


- (IBAction) observePwdBtnClick:(id)sender;
- (IBAction) loginClick:(id)sender;

@end
