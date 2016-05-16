#import <UIKit/UIKit.h>

#import "MineCellModel.h"


@class MineImageView;

@protocol MineImageDelegate <NSObject>

@optional
-(void)didSelectMineImage;
//-(void)didSelectHomeBox:(VideosModel *)video;
@end





@interface MineImageView : UIView

@property(nonatomic, strong) UIImageView *centerImageView;
@property(nonatomic, strong) UILabel *mineLabel;
@property(nonatomic, assign) id<MineImageDelegate> delegate;
 

-(MineImageView *)initWithFrame:(CGRect)frame CellModel:(MineCellModel *)mineCellModel;

@end