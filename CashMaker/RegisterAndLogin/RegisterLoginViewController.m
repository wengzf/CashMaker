//
//  RegisterLoginViewController.m
//  CashMaker
//
//  Created by 翁志方 on 16/3/30.
//  Copyright © 2016年 wzf. All rights reserved.
//

#import "RegisterLoginViewController.h"

@implementation RegisterLoginViewController



- (void)viewWillAppear:(BOOL)animated
{
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"experienceNow"]) {
        
        self.experienceNowBtn.hidden = YES;
    }else{
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"experienceNow"];
    }
}

#pragma mark - Event

- (IBAction)experienceNowBtnClked:(id)sender
{
    // 立即体验
    
    if (self.navigationController && [self.navigationController.viewControllers firstObject]==self) {
        
        [self dismissViewControllerAnimated:YES completion:NULL];
    }else{
        
        [self.navigationController popToRootViewControllerAnimated:YES];
    }

}



@end
