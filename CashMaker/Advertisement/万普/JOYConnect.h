#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol JOYConnectDelegate;


#define E_SIZE_320X50                           @"I/2rUlqZUek="

#define E_SIZE_375x60                           @"v8Q0S5HZ9oc="

#define E_SIZE_375x65                           @"pGUMvgNzCRE="

#define E_SIZE_414x70                           @"cYqFnyhc2U4="

#define E_SIZE_480X75                           @"N711wthZ4XA="

#define E_SIZE_640X100                          @"yr2WWhOyC+E="

#define E_SIZE_768X90                           @"0K4g4USLOR4="

#define E_SIZE_768X100                          @"cQo4fIM59zg="

@interface JOYConnect : NSObject

@property(assign) BOOL isInitial;
@property(nonatomic,strong) NSString *  ap;
@property(nonatomic,strong) NSString *pd;
@property(nonatomic,strong) NSString *ud;

@property(nonatomic, assign) id <JOYConnectDelegate> delegate;

#pragma mark 初始化&计数器调用
+ (JOYConnect *)sharedJOYConnect;

+ (JOYConnect *)getConnect:(NSString *)id;

+ (JOYConnect *)getConnect:(NSString *)id pid:(NSString *)channel;

+ (JOYConnect *)getConnect:(NSString *)id pid:(NSString *)channel userID:(NSString *)theUserID;

+ (NSMutableDictionary *)getConfigItems;

#pragma mark 广告条的相关调用
+ (void)showBan:(UIViewController *)vController adSize:(NSString *)aSize showX:(CGFloat)x showY:(CGFloat)y;

+ (void)closeBan;


#pragma mark 插屏广告的相关调用
+ (void)showPop:(UIViewController *)controller;

+ (void)closePop;


#pragma mark 积分墙的相关调用
+ (void)showList:(UIViewController *)controller;

+ (void)showList:(UIViewController *)controller url:(NSString *)url;

+ (void)showUrl:(NSString * )url;

+ (void)closeList;


#pragma mark 用户积分相关的调用
+ (void)getPoints;

+ (void)spendPoints:(int)points;

+ (void)awardPoints:(int)points;

@end










@protocol JOYConnectDelegate <NSObject>
@optional
- (void)onConnectSuccess;

- (void)onConnectFailed:(NSString *)error;

- (void)onBannerShow;

- (void)onBannerShowFailed:(NSString *)error;

- (void)onBannerClick;

- (void)onBannerClose;

- (void)onPopShow;

- (void)onPopShowFailed:(NSString *)error;

- (void)onPopClose;

- (void)onPopClick;

- (void)onListOpen;

- (void)onListShowFailed:(NSString *)error;

- (void)onListClose;

- (void)onRequestPoints:(int)points pointName:(NSString *)name status:(BOOL)status message:(NSString *)message;

- (void)onSpendPoints:(int)points pointName:(NSString *)name status:(BOOL)status message:(NSString *)message;

- (void)onAwardPoints:(int)points pointName:(NSString *)name status:(BOOL)status message:(NSString *)message;

- (void)onEarnPoints:(int)points pointName:(NSString *)name;

@end
