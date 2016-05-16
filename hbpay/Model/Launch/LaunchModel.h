#import <Foundation/Foundation.h>

@interface LaunchModel : NSObject



@property (nonatomic, assign) int MessageNumber;

@property (nonatomic, assign) int DiscountNumber;


@property(nonatomic, strong) NSMutableArray *SalesInfo;

@property(nonatomic, strong) NSMutableArray *businessList;

@property(nonatomic, strong) NSMutableArray *shareInfo;

@property(nonatomic, strong) NSString *AppStartImageName;

@property(nonatomic, strong) NSString *FlowPrompt;

@property(nonatomic, strong) NSMutableArray *ProductInfo;

@end