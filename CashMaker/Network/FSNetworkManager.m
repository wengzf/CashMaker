//
//  NJNetWorkManager.m
//  FireShadow
//
//  Created by Mr nie on 15/4/18.
//  Copyright (c) 2015年 Yonglibao. All rights reserved.
//
#import "FSNetworkManager.h"

@implementation FSNetworkManager

@synthesize networkingManager;

+ (FSNetworkManager *)instance
{
    static FSNetworkManager * instance;
    @synchronized(self){
        if (!instance) {
            instance = [[FSNetworkManager alloc] init];
            
            instance.networkingManager = [AFHTTPRequestOperationManager manager];

            instance.networkingManager.responseSerializer = [AFJSONResponseSerializer serializer];
        
            instance.networkingManager.requestSerializer.timeoutInterval = 10;
        
        }
    }
    return instance;
}

#pragma mark - 加密

+ (NSDictionary *)packingWithDictionaryParameters:(NSDictionary *)params
{
    return @{@"i": [FSNetworkManager encryptStringWithParameters:params]};
}


+ (NSString *)packingURL:(NSString *) url
{

    NSString *baseURL = @"http://www.shoujizhuan.com.cn/";
    
    return [baseURL stringByAppendingString:url];
}



// 注册
//POST /user/register
- (void)registerWithPhoneStr:(NSString *)phoneStr
                    password:(NSString *)password
                      nation:(NSString *)nation
              inviter_userid:(NSString *)inviter_userid
                    app_name:(NSString *)app_name
                 app_version:(NSString *)app_version
                    platform:(NSString *)platform
                successBlock:(SuccessBlock)sBlock
{
    NSString *url = [FSNetworkManager packingURL:@"user/register"];
    NSDictionary *parameterDic  = @{@"phone" : phoneStr,
                                    @"password" : password,
                                    @"nation" : nation,
                                    @"inviter_userid" : inviter_userid,
                                    @"app_name" : app_name,
                                    @"app_version" : app_version,
                                    @"platform" : platform
                                    };
    
    [networkingManager POST:url parameters:parameterDic success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        
        NSDictionary *dic = responseObject;
        if ([dic[@"code"] integerValue] == 1000) {
            // 成功
            
            sBlock(1000,dic[@"data"]);
        }else{
            // 显示错误信息
            
        }
        
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        
    }];
    
}

// 登陆
//POST /user/login
- (void)loginWithPhoneStr:(NSString *)phoneStr
                 password:(NSString *)password
             successBlock:(SuccessBlock)sBlock
{
    NSString *url = [FSNetworkManager packingURL:@"user/login"];
    NSDictionary *parameterDic  = @{@"phone" : phoneStr,
                                    @"password" : password
                                    };
    
    [networkingManager POST:url parameters:parameterDic success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        
        NSDictionary *dic = responseObject;
        if ([dic[@"code"] integerValue] == 1000) {
            // 成功
            
            sBlock(1000,dic[@"data"]);
        }else{
            // 显示错误信息
            [[UIApplication sharedApplication].keyWindow showLoadingWithMessage:dic[@"message"] hideAfter:1.8];
        }
        
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        
    }];
}


// 更改密码
// user/changepasswd
- (void)changepasswdWithUserid:(NSString *)userid
                  old_password:(NSString *)old_password
                  new_password:(NSString *)new_password
              successBlock:(SuccessBlock)sBlock
{
    NSString *url = [FSNetworkManager packingURL:@"user/changepasswd"];
    NSDictionary *parameterDic  = @{@"userid" :userid,
                                    @"old_password":old_password,
                                    @"new_password":new_password
                                    };
    
    [networkingManager POST:url parameters:parameterDic success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        
        NSDictionary *dic = responseObject;
        if ([dic[@"code"] integerValue] == 1000) {
            // 成功
            sBlock(1000,dic[@"data"]);
        }else{
            // 显示错误信息
        }
        
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        
    }];
}


// 退出登陆
//POST /user/logout
- (void)logoutWithPhoneStr:(NSString *)phoneStr
              successBlock:(SuccessBlock)sBlock
{
    NSString *url = [FSNetworkManager packingURL:@"user/logout"];
    NSDictionary *parameterDic  = @{@"phone" :phoneStr
                                    };
    
    [networkingManager POST:url parameters:parameterDic success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        
        NSDictionary *dic = responseObject;
        if ([dic[@"code"] integerValue] == 1000) {
            // 成功
            
            sBlock(1000,dic[@"data"]);
        }else{
            // 显示错误信息
            sBlock(911,nil);
        }
        
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        
    }];
}

// 用户详情
//POST /user/info
- (void)userInfoDetailWithUserID:(NSString *)userID
              successBlock:(SuccessBlock)sBlock
{
    NSString *url = [FSNetworkManager packingURL:@"user/info"];
    NSDictionary *parameterDic  = @{@"userid" : userID
                                    };
    
    [networkingManager POST:url parameters:parameterDic success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        
        NSDictionary *dic = responseObject;
        if ([dic[@"code"] integerValue] == 1000) {
            // 成功
            sBlock(1000,dic[@"data"]);
        }else{
            // 显示错误信息
        }
        
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
 
    }];
}

#pragma mark - 任务模块
// 获取任务列表
//POST /task/getlist
- (void)taskListWithUserID:(NSString *)userID
              successBlock:(SuccessBlock)sBlock
{
    NSString *url = [FSNetworkManager packingURL:@"task/getlist"];
    NSDictionary *parameterDic  = @{@"userid" : userID
                                    };
    
    [networkingManager POST:url parameters:parameterDic success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        
        NSDictionary *dic = responseObject;
        if ([dic[@"code"] integerValue] == 1000) {
            // 成功
            sBlock(1000,dic[@"data"]);
        }else{
            // 显示错误信息
        }
        
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        
    }];
}

// 签到
//POST /task/signin
- (void)signinWithUserID:(NSString *)userID
            successBlock:(SuccessBlock)sBlock
{
    NSString *url = [FSNetworkManager packingURL:@"task/signin"];
    NSDictionary *parameterDic  = @{@"userid" : userID
                                    };
    
    [networkingManager POST:url parameters:parameterDic success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        
        NSDictionary *dic = responseObject;
        if ([dic[@"code"] integerValue] == 1000) {
            // 成功
            sBlock(1000,dic[@"data"]);
        }else{
            // 显示错误信息
        }
        
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        
    }];
}


// 分享
//POST /task/share
- (void)shareWithUserID:(NSString *)userID
               platform:(NSString *)platform                // 分享渠道 | 1微信 2微博
           successBlock:(SuccessBlock)sBlock
{
    NSString *url = [FSNetworkManager packingURL:@"task/share"];
    NSDictionary *parameterDic  = @{@"userid" : userID,
                                    @"platform" : platform
                                    };
    
    [networkingManager POST:url parameters:parameterDic success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        
        NSDictionary *dic = responseObject;
        if ([dic[@"code"] integerValue] == 1000) {
            // 成功
            sBlock(1000,dic[@"data"]);
        }else{
            // 显示错误信息
        }
        
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        
    }];
}


// 我的金币记录列表
//POST /task/myrecords
- (void)myrecordsWithUserID:(NSString *)userID
       last_coins_record_id:(NSString *)last_coins_record_id
               successBlock:(SuccessBlock)sBlock
{
    NSString *url = [FSNetworkManager packingURL:@"task/myrecords"];
    NSDictionary *parameterDic  = @{@"userid" : userID,
                                    @"last_coins_record_id" : last_coins_record_id
                                    };
    
    [networkingManager POST:url parameters:parameterDic success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        
        NSDictionary *dic = responseObject;
        if ([dic[@"code"] integerValue] == 1000) {
            // 成功
            sBlock(1000,dic[@"data"]);
        }else{
            // 显示错误信息
        }
        
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        
    }];
}


#pragma mark - 刮刮卡模块
//POST /scratchcard/dopost
- (void)dopostWithUserID:(NSString *)userID
            successBlock:(SuccessBlock)sBlock
{
    NSString *url = [FSNetworkManager packingURL:@"scratchcard/dopost"];
    NSDictionary *parameterDic  = @{@"userid" : userID
                                    };
    
    [networkingManager POST:url parameters:parameterDic success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        
        NSDictionary *dic = responseObject;

        sBlock([dic[@"code"] integerValue],dic);
        
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        
    }];
}


#pragma mark - 活动模块
// 抽奖活动列表
//POST /activity/lotterylist
- (void)lotterylistWithUserID:(NSString *)userID
                   activityid:(NSString *)activityid
                 successBlock:(SuccessBlock)sBlock
{
    NSString *url = [FSNetworkManager packingURL:@"activity/lotterylist"];
    NSDictionary *parameterDic  = @{@"userid" : userID,
                                    @"activityid" : activityid
                                    };
    
    [networkingManager POST:url parameters:parameterDic success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        
        NSDictionary *dic = responseObject;
        if ([dic[@"code"] integerValue] == 1000) {
            // 成功
            sBlock(1000,dic[@"data"]);
        }else{
            // 显示错误信息
        }
        
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        
    }];
}

// 抽奖详情
//POST /activity/lotteryinfo
- (void)lotteryinfoWithUserID:(NSString *)userID
                   activityid:(NSString *)activityid
                 successBlock:(SuccessBlock)sBlock
{
    NSString *url = [FSNetworkManager packingURL:@"activity/lotteryinfo"];
    NSDictionary *parameterDic  = @{@"userid" : userID,
                                    @"activityid" : activityid
                                    };
    
    [networkingManager POST:url parameters:parameterDic success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        
        NSDictionary *dic = responseObject;
        if ([dic[@"code"] integerValue] == 1000) {
            // 成功
            sBlock(1000,dic[@"data"]);
        }else{
            // 显示错误信息
        }
        
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        
    }];
}

// 参加抽奖
//POST /activity/dolottery
- (void)dolotteryWithUserID:(NSString *)userID
                 activityid:(NSString *)activityid
               successBlock:(SuccessBlock)sBlock
{
    NSString *url = [FSNetworkManager packingURL:@"activity/dolottery"];
    NSDictionary *parameterDic  = @{@"userid" : userID,
                                    @"activityid" : activityid
                                    };
    
    [networkingManager POST:url parameters:parameterDic success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        
        NSDictionary *dic = responseObject;
        if ([dic[@"code"] integerValue] == 1000) {
            // 成功
            sBlock(1000,dic[@"data"]);
        }else{
            // 显示错误信息
        }
        
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        
    }];
}

// 我的抽奖活动列表
//POST /activity/myrecords
- (void)myrecordsWithUserID:(NSString *)userID
         activity_record_id:(NSString *)activity_record_id
               successBlock:(SuccessBlock)sBlock
{
    NSString *url = [FSNetworkManager packingURL:@"activity/myrecords"];
    NSDictionary *parameterDic  = @{@"userid" : userID,
                                    @"activity_record_id" : activity_record_id
                                    };
    
    [networkingManager POST:url parameters:parameterDic success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        
        NSDictionary *dic = responseObject;
        if ([dic[@"code"] integerValue] == 1000) {
            // 成功
            sBlock(1000,dic[@"data"]);
        }else{
            // 显示错误信息
        }
        
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        
    }];
}


#pragma mark - 兑换模块
//兑换列表
//POST /exchange/getlist
- (void)elistWithUserID:(NSString *)userID
       last_exchange_id:(NSString *)last_exchange_id
           successBlock:(SuccessBlock)sBlock
{
    
    NSString *url = [FSNetworkManager packingURL:@"exchange/getlist"];
    NSDictionary *parameterDic  = @{@"userid" : userID,
                                    @"last_exchange_id" : last_exchange_id
                                    };
    
    [networkingManager POST:url parameters:parameterDic success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        
        NSDictionary *dic = responseObject;
        if ([dic[@"code"] integerValue] == 1000) {
            // 成功
            sBlock(1000,dic[@"data"]);
        }else{
            // 显示错误信息
        }
        
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        
    }];
}

//兑换
//POST /exchange/dopost
- (void)dopostWithUserID:(NSString *)userID
              exchangeid:(NSString *)exchangeid
        exchange_account:(NSString *)exchange_account
            successBlock:(SuccessBlock)sBlock
{
    NSString *url = [FSNetworkManager packingURL:@"exchange/dopost"];
    NSDictionary *parameterDic  = @{@"userid" : userID,
                                    @"exchangeid" : exchangeid,
                                    @"exchange_account": exchange_account
                                    };
    
    [networkingManager POST:url parameters:parameterDic success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        
        sBlock(0,responseObject);
    
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        sBlock(911,nil);
    }];
}

//我的兑换活动列表
//POST /exchange/myrecords
- (void)myrecordsWithUserID:(NSString *)userID
         exchange_record_id:(NSString *)exchange_record_id
               successBlock:(SuccessBlock)sBlock
{
    NSString *url = [FSNetworkManager packingURL:@"exchange/myrecords"];
    NSDictionary *parameterDic  = @{@"userid" : userID,
                                    @"exchange_record_id" : exchange_record_id
                                    };
    
    [networkingManager POST:url parameters:parameterDic success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        
        NSDictionary *dic = responseObject;
        if ([dic[@"code"] integerValue] == 1000) {
            // 成功
            sBlock(1000,dic[@"data"]);
        }else{
            // 显示错误信息
        }
        
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        
    }];
}





@end
