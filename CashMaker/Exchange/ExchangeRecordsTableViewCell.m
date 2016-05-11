//
//  ExchangeRecordsTableViewCell.m
//  CashMaker
//
//  Created by 翁志方 on 16/3/12.
//  Copyright © 2016年 wzf. All rights reserved.
//

#import "ExchangeRecordsTableViewCell.h"

@implementation ExchangeRecordsTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

//        *      exchanges: 前5条兑换记录 [
//                                   *          id: 活动兑换记录ID | integer,
//                                   *          exchange_title: 兑换标题 | string,
//                                   *          exchange_account: 兑换账号 | string,
//                                   *          send_status: 兑换奖励发放状态  0 已生成  1 已发放  2 拒绝发放 | integer,
//                                   *          note: 派发兑换奖励备注 如帐号错误等 | string,
//                                   *          created_at: 申请兑换时间 | string
//                                   *      ] | array

- (void)updateCellWithModel:(ExchangeRecordsModel *)model
{
    self.valueLabel.text = model.exchange_amount;
 
    NSString *unitStr = @"RMB";
    if ([model.exchange_type intValue] == 2) {
        // Q币
        unitStr = @"个";
    }
    self.unitLabel.text = unitStr;
    
    
    
    self.titleLabel.text = model.exchange_title;
    
    self.accountLabel.text = model.exchange_account;
    
    self.timeLabel.text = model.created_at;
    
    switch ([model.send_status intValue])
    {
        case 0:
            self.stateLabel.text = @"审核中";
            self.stateLabel.textColor = UIColorWithHex(0xc5c6c8);
            break;
            
        case 1:
            self.stateLabel.text = @"已发放";
            self.stateLabel.textColor = UIColorWithHex(0x68b448);
            break;
            
        case 2:
            self.stateLabel.text = @"审核失败";
            self.stateLabel.textColor = UIColorWithHex(0xff6000);
            break;
    }
}


- (void)homePageUpdateCellWithModel:(ExchangeRecordsModel *)model
{
    self.valueLabel.text = model.exchange_amount;
    
    NSString *unitStr = @"RMB";
    if ([model.exchange_type intValue] == 2) {
        // Q币
        unitStr = @"个";
    }
    self.unitLabel.text = unitStr;

    self.titleLabel.text = model.exchange_title;
    
    self.accountLabel.text = [NSString stringWithFormat:@"ID%06d", [model.exchangeID intValue]];
    
    self.timeLabel.text = model.created_at;
    
    self.stateLabel.hidden = YES;
}

@end
