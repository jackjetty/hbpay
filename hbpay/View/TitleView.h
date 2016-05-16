#import <UIKit/UIKit.h>




@class TitleView;


@interface TitleView : UIView

@property(nonatomic, strong) UIImageView *titleImageView;
@property(nonatomic, strong) UIView *leftUIView;
@property(nonatomic, strong) UILabel *centerLabel;
@property(nonatomic, strong) UIView *rightUIView;

- (TitleView *)initWithFrame:(NSString *)title leftMenuItem:(UIView *)menuItem1 rightMenuItem:(UIView *)menuItem2;

@end
