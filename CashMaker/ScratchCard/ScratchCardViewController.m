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
    
    UILabel *contentLabel;
    
    UITapGestureRecognizer *tap;
    
    UIButton *lotteryBtn;
}
@property (strong, nonatomic) STScratchView *scratchCardView;

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

    // 确认抽奖手势
//    tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(scratchCardViewTaped)];


}
-  (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    

}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    

    // 添加呱呱卡底片
    {
        contentLabel = [[UILabel alloc] initWithFrame:self.scratchContentView.bounds];
        contentLabel.font = [UIFont systemFontOfSize:20];
        contentLabel.textAlignment = NSTextAlignmentCenter;
        contentLabel.textColor = [UIColor whiteColor];
        contentLabel.backgroundColor = [UIColor clearColor];
        contentLabel. text = @"较低的贷款的";
        [self.scratchContentView addSubview:contentLabel];
        
    }
    // 呱呱卡页面初始化
    {
        self.scratchContentView.backgroundColor = [UIColor clearColor];
        [self resetScratchView];
        
    }
}

- (void)initScratchCardView{
    
    if (self.scratchCardView) {
        [self.scratchCardView removeFromSuperview];
        
    }
    self.scratchCardView = [[STScratchView alloc] initWithFrame:self.scratchContentView.bounds];
    [self.scratchContentView addSubview:self.scratchCardView];
    
    UIView *bgView = [[UIView alloc] initWithFrame:self.scratchContentView.bounds];
    bgView.backgroundColor = RGB(255, 255, 187);
    [self.scratchCardView setHideView: bgView];
    
    [self.scratchContentView bringSubviewToFront:self.scratchCardView];
}

- (void)resetScratchView
{
    [self initScratchCardView];
    
    // 抽奖按钮
    lotteryBtn = [[UIButton alloc] initWithFrame:ScreenBounds];
    [lotteryBtn addTarget:self action:@selector(scratchCardViewTaped)];
//    lotteryBtn.backgroundColor =  [UIColor blueColor];
    [self.view addSubview:lotteryBtn];
}

- (void)requestLottery
{
    // 请求刮奖的数据并充值呱呱卡
    {
        [self.view showLoading];
        [FSNetworkManagerDefaultInstance dopostWithUserID:Global.userID successBlock:^(long status, NSDictionary *dic) {
            
            [self.view hideLoading];
            
            if (status == 1000) {

                [lotteryBtn removeFromSuperview];
                
                contentLabel.text = [NSString stringWithFormat:@"奖励%@coins", dic[@"data"][@"reward_coins"] ];
                
                [self initScratchCardView];
                
                WS(weakSelf);
                self.scratchCardView.completion = ^(){
                    
                    [weakSelf performSelector:@selector(resetScratchView) withObject:nil afterDelay:2];
                };
            }else{
                [self.view showLoadingWithMessage:dic[@"message"] hideAfter:2];
            }

        }];
    }
}

- (void)scratchCardViewTaped
{
    UIAlertView *alv = [[UIAlertView alloc] initWithTitle:@"刮刮卡" message:@"确定花费10 coins来抽奖" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alv show];
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        [self requestLottery];

    }
}

@end
