#import <UIKit/UIKit.h>
#import "OptionPotModel.h"

@class OptionPotView;

@interface OptionPotView : UIImageView
@property(nonatomic, strong) UILabel *titleLabel;
@property(nonatomic, strong) UILabel *discountLabel;

-(OptionPotView *)initWithFrame:(CGRect)frame optionPot:(OptionPotModel *)optionPotModel ;
-(void)setPotSelect:(BOOL *)optionSelected;
-(void)setPotDiscount:(NSString *)potDiscount;
@end