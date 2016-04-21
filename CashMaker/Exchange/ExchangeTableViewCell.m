//
//  ExchangeTableViewCell.m
//  CashMaker
//
//  Created by 翁志方 on 16/3/12.
//  Copyright © 2016年 wzf. All rights reserved.
//

#import "ExchangeTableViewCell.h"

@implementation ExchangeTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)updateCellWithModel:(ExchangeModel *)model
{
    
    exchangeModel = model;
    

    self.titleLabel.text = model.title;
//    [self.titleImageView sd_setImageWithURL:[NSURL URLWithString:model.img]];
    
    self.valueLabel.text = model.reward_amount;
    switch ([model.reward_type intValue]) {
        case 1:
            self.unitLabel.text = @"元";
            self.titleImageView.image = [UIImage imageNamed:@"pic_zhifubao"];
            break;
        case 2:
            self.unitLabel.text = @"个";
            self.titleImageView.image = [UIImage imageNamed:@"pic_qbi"];
            break;
        case 3:
            self.unitLabel.text = @"元";
            self.titleImageView.image = [UIImage imageNamed:@"pic_huafei"];
            break;
        case 4:
            self.unitLabel.text = @"元";
            break;
            
        default:
            break;
    }
    
    [self.coinBtn setTitle:model.cost_coins];
    
}

- (IBAction)coinBtnClked:(id)sender {
    
    // 弹出警告框输入兑换账号
//    UIAlertView *alv
    
    
    
    self.exchangeBlock(exchangeModel);
}

@end
