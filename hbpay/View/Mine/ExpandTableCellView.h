
#import <UIKit/UIKit.h>

#import "FaqModel.h"



@class ExpandTableCellView;

@protocol ExpandTableCellDelegate <NSObject>

@optional
-(void)didSelectExpandTableCell:(NSIndexPath *) indexPath ;
@end




@interface ExpandTableCellView :UITableViewCell



 
@property (weak, nonatomic)   UILabel *titleLabel;
@property (weak, nonatomic)   UILabel *detailLabel;
@property (weak, nonatomic)   UIButton *button;
@property (strong, nonatomic)  NSIndexPath *selectedCellIndexPath;
@property     int cellHight;
@property(nonatomic, assign) id<ExpandTableCellDelegate> delegate;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier faqModel:(FaqModel  *)faqModel indexPath:(NSIndexPath *) indexPath;
@end


