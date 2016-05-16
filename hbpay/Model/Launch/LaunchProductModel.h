#import <Foundation/Foundation.h>

@interface LaunchProductModel : NSObject

//{"id":"104","productName":"QQ会员","chargeTipTitle":"温馨提示","chargeTipContent":"单个手机号码Q币充值日限60元，月限200元，与拨打168声讯电话累计。","confirmTipTitle":"","confirmTipContent":"","hidden":0}



@property(nonatomic, strong) NSString *id;

@property(nonatomic, strong) NSString *productName;

@property(nonatomic, strong) NSString *chargeTipTitle;

@property(nonatomic, strong) NSString *chargeTipContent;

@property(nonatomic, strong) NSString *confirmTipTitle;

@property(nonatomic, strong) NSString *confirmTipContent;

@property (nonatomic, assign) int hidden;

@end