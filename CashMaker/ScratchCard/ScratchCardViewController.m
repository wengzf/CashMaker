//
//  ScratchCardViewController.m
//  CashMaker
//
//  Created by 翁志方 on 16/2/17.
//  Copyright © 2016年 wzf. All rights reserved.
//

#import "ScratchCardViewController.h"


@interface ScratchCardViewController()<UIAlertViewDelegate>
{
    BOOL contentFlag;
    UIImage *img;
    
    UILabel *label;
}
@property (strong, nonatomic) HYScratchCardView *scratchCardView;

@end

@implementation ScratchCardViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 页面初始化
    {
        self.scratchContentView.layer.borderColor = UIColorWithHex(0x0078b4).CGColor;
        self.scratchContentView.layer.borderWidth = 1.5;
        self.scratchContentView.layer.masksToBounds = YES;
        
  }
    
    label = [[UILabel alloc] initWithFrame:self.scratchContentView.bounds];
    label.font = [UIFont systemFontOfSize:20];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor blueColor];
    label.backgroundColor = [UIColor whiteColor];
    label.text = @"你中大家了";
    [self.view addSubview:label];
    

    

}
-  (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
        [self.view sendSubviewToBack:label];
    // 呱呱卡页面初始化
    {
        self.scratchCardView = [[HYScratchCardView alloc] initWithFrame:self.scratchContentView.bounds];
        
        [self.scratchContentView addSubview:self.scratchCardView];
        
        self.scratchCardView.completion = ^(id userInfo) {
        };
        
        //        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(scratchCardViewTaped)];
        //        [self.scratchCardView addGestureRecognizer:tap];
    }
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self requestLottery];
    
    img = label.imageSnapshot;
    
    UIImageView *imgview =  [[UIImageView alloc] initWithImage:img] ;
    imgview.center = self.view.center;
    [self.view addSubview:imgview];
}
- (void)requestLottery
{
    // 请求刮奖的数据并充值呱呱卡
    {
        

        UILabel *label = [[UILabel alloc] initWithFrame:self.scratchContentView.bounds];
        label.font = [UIFont systemFontOfSize:20];
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor blueColor];
        label.backgroundColor = [UIColor whiteColor];
        label.text = @"你中大家了";

        
        [self.scratchCardView setImage:img];
//        [self.scratchCardView setImage:label.imageSnapshot];
//        [self.scratchCardView setImage:[UIImage imageNamed:@"icon_app"]];
        
        [self.scratchCardView reset];
        
    }
}

- (void)scratchCardViewTaped
{
    UIAlertView *alv = [[UIAlertView alloc] initWithTitle:@"刮刮卡" message:@"确定话费10 coins来抽奖" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alv show];
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        [self requestLottery];
    }
}

@end
