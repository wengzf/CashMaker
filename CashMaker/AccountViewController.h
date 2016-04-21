//
//  AccountViewController.h
//  CashMaker
//
//  Created by 翁志方 on 16/4/18.
//  Copyright © 2016年 wzf. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AccountViewController : UIViewController


@property (weak, nonatomic) IBOutlet UITableView *contentTableView;


- (IBAction)segmentControlValueChanged:(id)sender;


@end
