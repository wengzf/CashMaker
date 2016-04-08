//
//  ChangePasswordSecondViewController.h
//  CashMaker
//
//  Created by 翁志方 on 16/3/31.
//  Copyright © 2016年 wzf. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChangePasswordSecondViewController : UIViewController

@property (nonatomic, strong) NSString *telNumber;


@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;

@property (weak, nonatomic) IBOutlet UITextField *certificateTextField;

@property (weak, nonatomic) IBOutlet UIButton *countDownBtn;

- (IBAction)countDownBtnClked:(id)sender;


@end
