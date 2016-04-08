//
//  TaskTableViewCell.h
//  CashMaker
//
//  Created by 翁志方 on 16/3/12.
//  Copyright © 2016年 wzf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TaskModel.h"



@interface TaskTableViewCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UIImageView *titleImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

- (void)updateCellWithModel:(TaskModel *)model;

@end
