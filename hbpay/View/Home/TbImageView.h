#import <UIKit/UIKit.h>

#import "HomeCellModel.h"

@class TbImageView;

@protocol TbImageDelegate <NSObject>

@optional
-(void)didSelectTbImage:(NSString *) cellId;
@end

@interface TbImageView : UIView
 
@property(nonatomic, strong) UIImageView *centerImageView;
@property(nonatomic, strong) UILabel *productLabel;
@property(nonatomic, strong) UILabel *rebatLabel;
@property(nonatomic, assign) id<TbImageDelegate> delegate;
@property (nonatomic,strong)  NSString *cellId;
-(TbImageView *)initWithFrame:(CGRect)frame CellModel:(HomeCellModel *)homeCellModel;
 
@end