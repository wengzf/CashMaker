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
    if ([model.taskNameStr isEqualToString:@"signin"]) {
        
        if ([model.isSignIn boolValue]) {
            self.titleImageView.image = [self getGrayImage:[UIImage imageNamed:@"icon_checkin"]];
        }else{
            self.titleImageView.image = [UIImage imageNamed:@"icon_checkin"];
        }
                    self.titleImageView.image = [self getGrayImage:[UIImage imageNamed:@"icon_checkin"]];
        
    }else if ([model.taskNameStr isEqualToString:@"share"]) {
        self.titleImageView.image = [UIImage imageNamed:@"icon_share"];
        
    }else if ([model.taskNameStr isEqualToString:@"signin"]) {
        
    }else if ([model.taskNameStr isEqualToString:@"signin"]) {
        
    }else if ([model.taskNameStr isEqualToString:@"signin"]) {
        
    }else if ([model.taskNameStr isEqualToString:@"signin"]) {
        
    }
    
    self.titleLabel.text = model.titleStr;
    self.contentLabel.text = model.hintStr;
}

#pragma mark - 图片处理为灰色

-(UIImage*)getGrayImage:(UIImage*)sourceImage
{
    int width = sourceImage.size.width;
    int height = sourceImage.size.height;
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceGray();
    CGContextRef context = CGBitmapContextCreate (nil,width,height,8,0,colorSpace,kCGImageAlphaNone);
    CGColorSpaceRelease(colorSpace);
    
    if (context == NULL) {
        return nil;
    }
    
    CGContextDrawImage(context,CGRectMake(0, 0, width, height), sourceImage.CGImage);
    UIImage *grayImage = [UIImage imageWithCGImage:CGBitmapContextCreateImage(context)];
    CGContextRelease(context);
    
    return grayImage;
}

@end
