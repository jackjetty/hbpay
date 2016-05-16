#import <Foundation/Foundation.h>

@interface FaqRstModel : NSObject



@property (nonatomic, assign) int respCode;

@property (nonatomic, assign)  NSString *respInfo;

@property(nonatomic, strong) NSMutableArray *listFaq;


@end