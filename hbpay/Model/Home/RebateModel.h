#import <Foundation/Foundation.h>
//{"RebateId":30,"RebateType":"SALE9","RebateExplain":"9折","ProductId":"16019","BusId":"100","Denomination":"10","PayMoney":"9.00","PayTip":"【9折】"
@interface RebateModel : NSObject




@property (nonatomic, strong)  NSString *RebateId;
@property (nonatomic, strong)  NSString *RebateType;
@property (nonatomic, strong)  NSString *RebateExplain;
@property (nonatomic, strong)  NSString *ProductId;
@property (nonatomic, strong)  NSString *BusId;
@property (nonatomic, strong)  NSString *Denomination;
@property (nonatomic, strong)  NSString *PayMoney;
@property (nonatomic, strong)  NSString *PayTip;
@end