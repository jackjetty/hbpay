#import "QmonthController.h"
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

#import "Tool.h"
#import "LoginController.h"
#import "QmonthHandleConfirmController.h"
#import "QmonthHandleController.h"
#import "QmonthMineController.h"
#import "QmonthCancelConfirmController.h"
#import "UIViewContollerSkipDelegate.h"

@interface QmonthController ()< UIViewContollerSkipDelegate>

@property (nonatomic, strong) MBProgressHUD       *HUD;
@property (nonatomic,retain)  TitleView *titleView;
@property (nonatomic,retain)  UILabel *topLabel;
@property (nonatomic,retain)  UIColor *backColor;
@property (nonatomic,strong)  UITableView *formTableView;


@property (nonatomic,strong)  NSString *productId;
@property (nonatomic,strong)  NSString *qqCount;
@property (nonatomic,strong)  NSString *payMoney;
@property (nonatomic,strong)  UIView *bodyView;
@property (nonatomic,strong)  UIView *handleView;
@property (nonatomic,strong)  UIView *mineView;

@property  AppDelegate *appDelegate;
@property (nonatomic,strong)  QmonthHandleController *qmonthHandleController;
@property (nonatomic,strong)  QmonthMineController *qmonthMineController;


@end
@implementation QmonthController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    self.appDelegate = [[UIApplication sharedApplication] delegate];
    UIButton *backBtn = [UIButton buttonWithType: UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, (title_height+20-40)/2, 40, 40);
    [backBtn setImage:[UIImage imageNamed:@"tital_back"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(OnTapBackBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    _titleView = [[TitleView alloc] initWithFrame:@"" leftMenuItem:backBtn rightMenuItem:nil ];
    [self.view addSubview:_titleView];
    
    
    NSArray *segmentedData = [[NSArray alloc]initWithObjects:@"包月办理",@"我的包月",nil];
    UISegmentedControl *segmentedControl = [[UISegmentedControl alloc]initWithItems:segmentedData];
    segmentedControl.frame = CGRectMake(40.0, (H(_titleView)+20-30)/2,screen_width-80,30.0);
    /*
     这个是设置按下按钮时的颜色
     */
    segmentedControl.tintColor = [UIColor colorWithRed:49.0 / 256.0 green:148.0 / 256.0 blue:208.0 / 256.0 alpha:1];
    segmentedControl.selectedSegmentIndex = 0;//默认选中的按钮索引
    
    
  //RGB(49, 148, 208)
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont boldSystemFontOfSize:12],NSFontAttributeName,[UIColor whiteColor], NSForegroundColorAttributeName, nil  ];
    
    //RGB(49, 148, 208)
    [segmentedControl setTitleTextAttributes:attributes forState:UIControlStateNormal];
    
    
    NSDictionary *highlightedAttributes = [NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:NSForegroundColorAttributeName];
    
    [segmentedControl setTitleTextAttributes:highlightedAttributes forState:UIControlStateHighlighted];
    
    //设置分段控件点击相应事件
    [segmentedControl addTarget:self action:@selector(doSomethingInSegment:)forControlEvents:UIControlEventValueChanged];
    segmentedControl.segmentedControlStyle = UISegmentedControlStyleBar;
    [self.view addSubview:segmentedControl];
    
    
    
     _bodyView =[[UIView alloc]initWithFrame:CGRectMake(0.f, H(_titleView), screen_width, screen_height)];
    
    [self.view addSubview:_bodyView];

 
    
    
    
    
    _qmonthHandleController=[[QmonthHandleController alloc]init];
    _qmonthMineController=[[QmonthMineController alloc]init];
    _qmonthHandleController.delegate = self;
    _qmonthMineController.delegate= self;
    
    _handleView=_qmonthHandleController.view;
    _mineView=_qmonthMineController.view;
    
    [_bodyView addSubview:_handleView];
    
    
}

-(void)doSomethingInSegment:(UISegmentedControl *)Seg
{
    
    NSInteger Index = Seg.selectedSegmentIndex;
    /*
     [self.view addSubview:self.rmedView];
     [self.nearImageView removeFromSuperview];
     */
    switch (Index)
    {
            
        case 0:
            [_bodyView addSubview:_handleView];
            [_mineView removeFromSuperview];
           
             //[self.view.superview addSubview:ttController.view];
            
             //[self.view removeFromSuperview];
             break;
        case 1:
            [_bodyView addSubview:_mineView];
            [_handleView removeFromSuperview];
            //[self.view addSubview:_qmonthMineController.view];
            //[self.qmonthHandleController.view removeFromSuperview];
                                           
         // RegisterController
           // NSLog(@"%d",Index);
             break;
         
        default:
            break;
    }
}






- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [_HUD hide:YES];
    [super viewWillDisappear:animated];
}

- (void)OnTapBackBtn:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
    
}

-(void)skipController:(NSString *)controllerName{
    
    if([controllerName isEqualToString:@"QmonthHandleConfirmController"]){
        QmonthHandleConfirmController *qmonthHandleConfirmController=[[ QmonthHandleConfirmController alloc]init];
        qmonthHandleConfirmController.hidesBottomBarWhenPushed = YES;
        
        [self.navigationController pushViewController:qmonthHandleConfirmController animated:YES];
        return;
    }
    
    
    if([controllerName isEqualToString:@"LoginController"]){
        LoginController *loginController=[[ LoginController alloc]init];
        loginController.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:loginController animated:YES];
        return;
    }
    
    if([controllerName isEqualToString:@"QmonthCancelConfirmController"]){
        QmonthCancelConfirmController *qmonthCancelConfirmController=[[ QmonthCancelConfirmController alloc]init];
        qmonthCancelConfirmController.hidesBottomBarWhenPushed = YES;
        
        [self.navigationController pushViewController:qmonthCancelConfirmController animated:YES];
        return;
    }
    //QmonthCancelConfirmController
    
}



@end

