//
//  TaskRecordTableViewCell.m
//  CashMaker
//
//  Created by 翁志方 on 16/4/18.
//  Copyright © 2016年 wzf. All rights reserved.
//

#import "TaskRecordTableViewCell.h"

@implementation TaskRecordTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)updateCellWithModel:(TaskRecordsModel *)model;
{
    self.titleLabel.text = model.source_title;
    self.coninsLabel.text = [model.change_coins stringByAppendingString:@" 积分"];
    self.timeLabel.text = model.created_at;
    
}

@end
