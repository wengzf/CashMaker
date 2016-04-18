//
//  SettingViewController.h
//  CashMaker
//
//  Created by 翁志方 on 16/2/17.
//  Copyright © 2016年 wzf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MFMailComposeViewController.h>

@interface SettingViewController : UIBaseTableViewController<MFMailComposeViewControllerDelegate>


@property (weak, nonatomic) IBOutlet UILabel *userIDLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;

@property (weak, nonatomic) IBOutlet UISwitch *switchBtn;

- (IBAction)switchValueChanged:(id)sender;

@end
