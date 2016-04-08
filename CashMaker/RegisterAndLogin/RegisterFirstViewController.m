//
//  RegisterFirstViewController.m
//  CashMaker
//
//  Created by 翁志方 on 16/3/30.
//  Copyright © 2016年 wzf. All rights reserved.
//

#import "RegisterFirstViewController.h"
#import <SMS_SDK/SMSSDK.h>
#import "RegisterSecondViewController.h"


@implementation RegisterFirstViewController


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
}

#pragma mark - Event

- (IBAction)backBtnClked:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}



- (IBAction)nextBtnClked:(id)sender {
    /**
     *  @from                    v1.1.1
     *  @brief                   获取验证码(Get verification code)
     *
     *  @param method            获取验证码的方法(The method of getting verificationCode)
     *  @param phoneNumber       电话号码(The phone number)
     *  @param zone              区域号，不要加"+"号(Area code)
     *  @param customIdentifier  自定义短信模板标识 该标识需从官网http://www.mob.com上申请，审核通过后获得。(Custom model of SMS.  The identifier can get it  from http://www.mob.com  when the application had approved)
     *  @param result            请求结果回调(Results of the request)
     */
    
    [self.view showLoading];
    [SMSSDK getVerificationCodeByMethod:SMSGetCodeMethodSMS phoneNumber:self.accountTextField.text zone:@"86" customIdentifier:nil result:^(NSError *error) {
        
        [self.view hideLoading];
        if (!error) {
            NSLog(@"获取验证码成功");
            
            // 进入登录注册页面
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"RegisterLogin" bundle:nil];
            RegisterSecondViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"RegisterSecondViewController"];
            vc.telNumber = self.accountTextField.text;
            [self.navigationController pushViewController:vc animated:YES];
            
        }else{
            NSLog(@"错误信息：%@",error);
        }
        
    }];
}
@end
