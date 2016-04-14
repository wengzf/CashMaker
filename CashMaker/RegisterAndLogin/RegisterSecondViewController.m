//
//  RegisterSecondViewController.m
//  CashMaker
//
//  Created by 翁志方 on 16/3/30.
//  Copyright © 2016年 wzf. All rights reserved.
//

#import "RegisterSecondViewController.h"
#import <SMS_SDK/SMSSDK.h>
#import "RegisterThirdViewController.h"

@interface RegisterSecondViewController()
{
    NSTimer *timer;
    int countdownNumber;
}

@end

@implementation RegisterSecondViewController


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

    // 电话号码 初始化
    {
        self.phoneLabel.text = self.telNumber;
    }

    // 重新获取验证码倒计时
    {
        [self timerInit];
    }
    
}
- (void)viewDidAppear:(BOOL)animated
{
    
}

- (void)hidenKeyboard
{
    [self.certificateTextField resignFirstResponder];
}

#pragma mark - 定时器

- (void)timerInit
{
    if (timer == nil){
        countdownNumber = 60;
        timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
        [timer fire];
    }
}
- (void)timerAction
{
    self.countDownBtn.userInteractionEnabled = NO;
    countdownNumber = countdownNumber-1;
    [self.countDownBtn setTitle:[NSString stringWithFormat:@"%d秒",countdownNumber] forState:UIControlStateNormal];
    if (countdownNumber == 0) {
        [self.countDownBtn setTitle:@"点击获取" forState:UIControlStateNormal];
        [self.countDownBtn setUserInteractionEnabled:YES];
        
        self.countDownBtn.userInteractionEnabled = YES;
        
        [timer invalidate];
        timer = nil;
        
        return;
    }
}

#pragma mark - Event

- (IBAction)backBtnClked:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)countDownBtnClked:(id)sender
{
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
    [SMSSDK getVerificationCodeByMethod:SMSGetCodeMethodSMS phoneNumber:self.telNumber zone:@"86" customIdentifier:nil result:^(NSError *error) {
        
        [self.view hideLoading];
        if (!error) {
            NSLog(@"获取验证码成功");
            
            [self timerInit];       // 启动定时器
            
        }else{
            NSLog(@"错误信息：%@",error);
        }
        
    }];
}

- (IBAction)nextBtnClked:(id)sender {
    
    [SMSSDK commitVerificationCode:self.certificateTextField.text phoneNumber:self.telNumber zone:@"86" result:^(NSError *error) {
        
        if (!error) {
            NSLog(@"验证成功");
            // 跳到登录注册第三步
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"RegisterLogin" bundle:nil];
            RegisterThirdViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"RegisterThirdViewController"];
            vc.telNumber = self.telNumber;
            [self.navigationController pushViewController:vc animated:YES];
        }
        else
        {
            NSLog(@"错误信息:%@",error);
        }
    }];

}




@end
