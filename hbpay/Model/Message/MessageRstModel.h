#import <Foundation/Foundation.h>

@interface MessageRstModel : NSObject



@property (nonatomic, assign) int respCode;

@property (nonatomic, assign)  NSString *respInfo;

@property(nonatomic, strong) NSMutableArray *Messages;


@end