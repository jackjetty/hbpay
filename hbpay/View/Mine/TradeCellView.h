#import <UIKit/UIKit.h>

@interface TradeCellView : UITableViewCell

@property (retain, nonatomic)  UIImageView *imageIcon;

@property (retain, nonatomic)  UILabel *titleLabel;

@property (retain, nonatomic)  UILabel *balanceLabel;

@property (retain, nonatomic)  UILabel *stateLabel;

@property (retain, nonatomic)  UILabel *accountLabel;

@property (retain, nonatomic) UIImageView *imageLine;

- (void)setTradeCellView;
@end