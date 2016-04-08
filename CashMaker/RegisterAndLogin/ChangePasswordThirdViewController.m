//
//  ChangePasswordThirdViewController.m
//  CashMaker
//
//  Created by 翁志方 on 16/3/31.
//  Copyright © 2016年 wzf. All rights reserved.
//

#import "ChangePasswordThirdViewController.h"

@implementation ChangePasswordThirdViewController

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
    [self.pwdTextField resignFirstResponder];
}




#pragma mark - Event

- (IBAction)backBtnClked:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction) observePwdBtnClick:(id)sender
{
    self.observePwdBtn.selected = !self.observePwdBtn.selected;
    self.pwdTextField.secureTextEntry = !self.pwdTextField.secureTextEntry;
}

- (IBAction)finishBtnClked:(id)sender {
    
    // 调用更改密码接口
    [self.view showLoading];
//    [FSNetworkManagerDefaultInstance changepasswdWithUserid:<#(NSString *)#> old_password:<#(NSString *)#> new_password:<#(NSString *)#> successBlock:^(long status, NSDictionary *dic) {
//        
//        [self.view hideLoading];
//        
//        if (status == 1000){
//            // 成功更改密码
//            // 跳到登录页面
//            [self.navigationController popToRootViewControllerAnimated:YES];
//        }
//        
//    }];
    
}
@end
