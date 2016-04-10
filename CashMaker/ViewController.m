//
//  ViewController.m
//  CashMaker
//
//  Created by 翁志方 on 16/2/17.
//  Copyright © 2016年 wzf. All rights reserved.
//

#import "ViewController.h"

@implementation ViewController

- (void)viewDidLoad
{
    
}

- (void)viewWillAppear:(BOOL)animated
{
    // 分割线一个像素设置
    [self.view resetDeviderLineToOnePixel];
    
    // 更新数据
    {
        if (Global.isLogin)
        {
            [FSNetworkManagerDefaultInstance userInfoDetailWithUserID:Global.userID successBlock:^(long status, NSDictionary *dic) {

                Global.userID = dic[@"userid"];
                
                Global.name     = dic[@"name"];
                Global.mail     = dic[@"email"];
                Global.phone    = dic[@"phone"];
                Global.conis    = dic[@"coins"];
                Global.status   = [dic[@"status"] intValue];
                
                Global.nation    = dic[@"nation"];
                Global.app_name    = dic[@"app_name"];
                Global.app_version   = dic[@"app_version"];
                
                Global.platform = dic[@"platform"];
                
                [Global saveUserInfo];
                
            }];
        }
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    if (!Global.isLogin)
    {
        // 弹出登录注册页面
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"RegisterLogin" bundle:nil];
        UIViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"RegisterLogin"];
        [self presentViewController:vc animated:YES completion:NULL];
        
    }
}

- (IBAction)viewAccountBtnClked:(id)sender {
}

- (IBAction)taskBtnClked:(id)sender {
}

- (IBAction)exchangeBtnClked:(id)sender {
}

- (IBAction)guaguaBtnClked:(id)sender {
}
- (IBAction)settingBtnClked:(id)sender {
}


#pragma mark - Navigation

- (void)performSegueWithIdentifier:(NSString *)identifier sender:(id)sender
{
    
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    UIViewController *vc = segue.destinationViewController;
    vc.navigationController.navigationBar.hidden = NO;
}

- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender
{
    return YES;
}


@end
