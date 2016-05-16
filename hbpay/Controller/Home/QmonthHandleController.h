#import <UIKit/UIKit.h>
#import "UIViewContollerSkipDelegate.h"
#import "PlaceholderTextView.h"
#import "AppDelegate.h"
#import "MBProgressHUD.h"
#import "Utils.h"
#import "Public.h"
#import "Constant.h"
#import "TitleView.h"
#import "RegisterController.h"
#import "APRoundedButton.h"
#import "NetworkSingleton.h"
#import "FindController.h"
#import "JYTextField.h"
#import "OptionPotView.h"
#import "OptionPotModel.h"
#import "RebateModel.h"
#import "RebateRstModel.h"
#import "Tool.h"
#import "LoginController.h"
#import "QmonthHandleConfirmController.h"
@interface QmonthHandleController : UIViewController <UITableViewDataSource,UITableViewDelegate ,UITextFieldDelegate>{
    __unsafe_unretained NSObject<UIViewContollerSkipDelegate> *delegate;
}

@property (nonatomic, strong) MBProgressHUD       *HUD;
@property (nonatomic,retain)  UILabel *topLabel;
@property (nonatomic,retain)  UIColor *backColor;
@property (nonatomic,strong)  UITableView *formTableView;
@property(nonatomic,assign)NSObject<UIViewContollerSkipDelegate> *delegate;

@property (nonatomic,strong)  RebateRstModel *rebateRstModel;
@property (nonatomic,strong)  NSString *productId;
@property (nonatomic,strong)  NSString *qqCount;
@property (nonatomic,strong)  NSString *payMoney;
@property  AppDelegate *appDelegate;




@end

