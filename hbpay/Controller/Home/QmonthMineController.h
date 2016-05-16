#import <UIKit/UIKit.h>
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
#import "UIViewContollerSkipDelegate.h"
#import "QmonthInfoRstModel.h"
@interface QmonthMineController : UIViewController<UITableViewDataSource,UITableViewDelegate ,UITextFieldDelegate>{
    __unsafe_unretained NSObject<UIViewContollerSkipDelegate> *delegate;
}

@property (nonatomic, strong) MBProgressHUD       *HUD;
@property (nonatomic,retain)  UILabel *topLabel;
@property (nonatomic,retain)  UIColor *backColor;
@property (nonatomic,strong)  UITableView *formTableView;
@property (nonatomic,assign) NSObject<UIViewContollerSkipDelegate> *delegate;
@property (nonatomic,assign)  BOOL *isLogin;
@property (nonatomic,assign)  BOOL *hasInfo;
@property (nonatomic,assign)  BOOL *hasOrder;
@property (nonatomic,strong)  NSString *phoneNumber;
/*
@property (nonatomic,strong)  NSString *productId;
@property (nonatomic,strong)  NSString *qqCount;
@property (nonatomic,strong)  NSString *payMoney;*/
@property (nonatomic,strong)  NSString *tipInfo;
@property (nonatomic,strong)  QmonthInfoRstModel *qmonthInfoRstModel;



@property  AppDelegate *appDelegate;
@end