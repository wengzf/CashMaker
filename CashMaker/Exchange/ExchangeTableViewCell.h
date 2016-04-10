//
//  ExchangeTableViewCell.h
//  CashMaker
//
//  Created by 翁志方 on 16/3/12.
//  Copyright © 2016年 wzf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ExchangeModel.h"

@interface ExchangeTableViewCell : UITableViewCell
{
    ExchangeModel *exchangeModel;
}

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *titleImageView;
@property (weak, nonatomic) IBOutlet UILabel *valueLabel;
@property (weak, nonatomic) IBOutlet UILabel *unitLabel;

@property (weak, nonatomic) IBOutlet UIButton *coinBtn;

@property (strong, nonatomic) void(^exchangeBlock)(ExchangeModel *model);

- (void)updateCellWithModel:(ExchangeModel *)model;


- (IBAction)coinBtnClked:(id)sender;


@end
