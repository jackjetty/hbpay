
#import <Foundation/Foundation.h>
//{"Cost":"10","respCode":0,"CancelTime":"2015-07-11 19:44:38","PayMoney":9.3,"thisMonth":"扣费失败","TargetNumber":"121437479","PhoneNumber":"18072749082","ApplyTime":"2015-07-11 19:33:47","NowStatus":"已取消","respInfo":""}
@interface QmonthInfoRstModel : NSObject



@property (nonatomic, assign) int respCode;

@property (nonatomic, strong)  NSString *respInfo;

@property (nonatomic, strong)  NSString *Cost;

@property (nonatomic, strong)  NSString *CancelTime;
@property (nonatomic, strong)  NSString *PayMoney;
@property (nonatomic, strong)  NSString *thisMonth;
@property (nonatomic, strong)  NSString *TargetNumber;
@property (nonatomic, strong)  NSString *ApplyTime;
@property (nonatomic, strong)  NSString *NowStatus;


@end