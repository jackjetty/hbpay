#import <UIKit/UIKit.h>
 

@class MineInfoView;

@interface MineInfoView : UIView
@property(nonatomic, strong) UIImageView *userImage;
@property(nonatomic, strong) UILabel *userNameLabel;
@property(nonatomic, strong) UILabel *moneyLabel;

@property(nonatomic, strong) UIImageView *arrowImg;

-(MineInfoView *)initWithFrame:(CGRect)frame userLabel:(NSString *)useText ;

@end
