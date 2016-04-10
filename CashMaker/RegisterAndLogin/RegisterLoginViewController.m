//
//  RegisterLoginViewController.m
//  CashMaker
//
//  Created by 翁志方 on 16/3/30.
//  Copyright © 2016年 wzf. All rights reserved.
//

#import "RegisterLoginViewController.h"

@implementation RegisterLoginViewController





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
