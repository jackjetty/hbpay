#import "TMController.h"#import "Public.h"
#import "TitleView.h"
#import "MineInfoView.h"
#import "AboutController.h"
#import "FaqController.h"
#import "RecordController.h"
#import "AdviseController.h"
#import "LoginController.h"
#import "Tool.h"
#import <mach/mach.h>
#import "APRoundedButton.h"
#import "Utils.h"
#import "Constant.h"
#import "AppDelegate.h"
#import "HomeController.h"
#import "LeftRstModel.h"

@interface TMController () <UITableViewDataSource, UITableViewDelegate>
@property (retain, nonatomic) UITableView *tableV;
@property (retain, nonatomic) NSMutableArray *arData;
@property ( nonatomic,retain) TitleView *titleView;
@property (nonatomic, strong) MBProgressHUD       *HUD;
@property  AppDelegate *appDelegate;
enum TAG_FORM_FIELD{
    
    Tag_HeaderViewField  = 30,    //邮箱
    Tag_AccountTextField ,
    
};
@end

@implementation TMController




- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"leftbaricon"] style:UIBarButtonItemStylePlain target:self action:@selector(tell)];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
    
    
    UIButton *backBtn = [UIButton buttonWithType: UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, (title_height+20-40)/2, 40, 40);
    [backBtn setImage:[UIImage imageNamed:@"tital_back"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(OnTapBackBtn:) forControlEvents:UIControlEventTouchUpInside];
    //[backView addSubview:backBtn];
    
    
    _titleView = [[TitleView alloc] initWithFrame:@"关于" leftMenuItem:backBtn rightMenuItem:nil ];
    
    
    [self.view addSubview:_titleView];
    
    
    
    
    
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)OnTapBackBtn:(UIButton *)sender{
    LoginController  *loginController=[[ LoginController alloc]init];
    loginController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:loginController animated:YES];
}





@end

