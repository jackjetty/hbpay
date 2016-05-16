#import <UIKit/UIKit.h>

@interface MessageController : UIViewController
@property (strong, nonatomic)   UITableView *tableView;

@property (weak, nonatomic)   UITextField *messageField;
@property (weak, nonatomic)   UIButton *speakBtn;
- (IBAction)voiceBtnClick:(UIButton *)sender;
@end