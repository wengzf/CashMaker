//
//  RegisterSecondViewController.h
//  CashMaker
//
//  Created by 翁志方 on 16/3/30.
//  Copyright © 2016年 wzf. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegisterSecondViewController : UIViewController

@property (nonatomic, strong) NSString *telNumber;


@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;

@property (weak, nonatomic) IBOutlet UITextField *certificateTextField;

@property (weak, nonatomic) IBOutlet UIButton *countDownBtn;

- (IBAction)countDownBtnClked:(id)sender;

- (IBAction)nextBtnClked:(id)sender;

@end
