#import <Foundation/Foundation.h>

@interface TradeRstModel : NSObject



@property (nonatomic, assign) int respCode;
@property (nonatomic, assign) int pageSize;


@property (nonatomic, assign)  NSString *respInfo;

@property(nonatomic, strong) NSMutableArray *listRecord;


@end