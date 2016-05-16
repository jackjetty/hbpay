#import <Foundation/Foundation.h>

@interface RebateRstModel : NSObject



@property (nonatomic, readwrite) int respCode;

@property (nonatomic, strong)  NSString *respInfo;

@property (nonatomic, strong)  NSString *rebateType; 

@property(nonatomic, strong) NSMutableArray *productRebateList;


@end