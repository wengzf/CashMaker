//
//  LoginViewController.m
//  CashMaker
//
//  Created by 翁志方 on 16/3/30.
//  Copyright © 2016年 wzf. All rights reserved.
//

#import "LoginViewController.h"
#import "CALayer+Extension.h"


@implementation LoginViewController

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
    [self.accountTextField resignFirstResponder];
    [self.pwdTextField resignFirstResponder];
}


#pragma mark - UITextField Delegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (self.pwdTextField == textField) {
        if ([string length]>0) {
            unichar ch = [string characterAtIndex:0];
            
            if (ch=='\n' || ch=='\r') {
                if ([textField.text length]>0) {
                    [self loginClick:nil];
                }
                return NO;
            }
        }
    }
    
    return YES;
}


#pragma mark - Event

- (IBAction)observePwdBtnClick:(id)sender
{
    self.observePwdBtn.selected = !self.observePwdBtn.selected;
    self.pwdTextField.secureTextEntry = !self.pwdTextField.secureTextEntry;
}


- (IBAction) loginClick:(id)sender
{
    [self.view showLoading];
    [FSNetworkManagerDefaultInstance loginWithPhoneStr:self.accountTextField.text password:self.pwdTextField.text successBlock:^(long status, NSDictionary *dic) {
        
        [self.view hideLoading];
        Global.isLogin = YES;
        Global.userID = [dic[@"userid"] stringValue];
        Global.token = dic[@"token"];
        
        [Global saveUserInfo];
        
        // 登录成功，跳到首页
        [self dismissViewControllerAnimated:YES completion:NULL];
    }];
}


- (IBAction)backBtnClked:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}



@end
