//
//  TaskRecordTableViewCell.h
//  CashMaker
//
//  Created by 翁志方 on 16/4/18.
//  Copyright © 2016年 wzf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TaskRecordsModel.h"

@interface TaskRecordTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *coninsLabel;

- (void)updateCellWithModel:(TaskRecordsModel *)model;

@end
