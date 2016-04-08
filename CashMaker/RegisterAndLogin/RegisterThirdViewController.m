//
//  RegisterThirdViewController.m
//  CashMaker
//
//  Created by 翁志方 on 16/3/31.
//  Copyright © 2016年 wzf. All rights reserved.
//

#import "RegisterThirdViewController.h"

@implementation RegisterThirdViewController


- (void)viewDidLoad
{
    // 添加退出键盘手势
    {
        UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hidenKeyboard)];
        gesture.numberOfTapsRequired = 1;
        [self.view addGestureRecognizer:gesture];
    }
}
- (void)viewWillAppear:(BOOL)animated
{
}
- (void)viewDidAppear:(BOOL)animated
{
    
}

- (void)hidenKeyboard
{
    [self.invitorIDTextField resignFirstResponder];
    [self.pwdTextField resignFirstResponder];
}



- (IBAction) observePwdBtnClick:(id)sender
{
    self.observePwdBtn.selected = !self.observePwdBtn.selected;
    self.pwdTextField.secureTextEntry = !self.pwdTextField.secureTextEntry;
}

- (IBAction)finishBtnClked:(id)sender {
    
    // 调用注册接口
    [self.view showLoading];
    [FSNetworkManagerDefaultInstance registerWithPhoneStr:self.telNumber password:self.pwdTextField.text nation:@"86" inviter_userid:self.invitorIDTextField.text app_name:@"手机赚" app_version:@"1.0.0" platform:@"iOS" successBlock:^(long status, NSDictionary *dic) {
        
        [self.view hideLoading];
        
        if (status == 1000){
            // 成功注册
            
            Global.isLogin = YES;
            Global.userID = [dic[@"userid"] stringValue];
            Global.token = dic[@"token"];
            
            [Global saveUserInfo];
            
            // 登录成功，跳到首页
            [self.navigationController popToRootViewControllerAnimated:YES];
        }
        
    }];
    
}

@end
