#import <Foundation/Foundation.h>

@interface OptionPotModel : NSObject


@property(nonatomic, strong) NSString *optionId;

@property(nonatomic, strong) NSString *optionTitle;

@property(nonatomic, strong) NSString *optionDiscout;

@property(nonatomic, readwrite) BOOL *optionSelected;

@end