//
//  TaskTableViewCell.m
//  CashMaker
//
//  Created by 翁志方 on 16/3/12.
//  Copyright © 2016年 wzf. All rights reserved.
//

#import "TaskTableViewCell.h"

@implementation TaskTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)updateCellWithModel:(TaskModel *)model
{
    NSString *hintStr;
    NSString *titleStr;
    if ([model.taskNameStr isEqualToString:@"signin"]) {
        self.titleImageView.image = [UIImage imageNamed:@"icon_signin"];
        
    }else if ([model.taskNameStr isEqualToString:@"share"]) {
        
    }else if ([model.taskNameStr isEqualToString:@"signin"]) {
        
    }else if ([model.taskNameStr isEqualToString:@"signin"]) {
        
    }else if ([model.taskNameStr isEqualToString:@"signin"]) {
        
    }else if ([model.taskNameStr isEqualToString:@"signin"]) {
        
    }
    
    self.titleLabel.text = model.titleStr;
    self.contentLabel.text = model.hintStr;
}

@end
