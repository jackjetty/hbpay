//
//  MineViewController.m
//  tudou
//
//  Created by jinzelu on 15/6/3.
//  Copyright (c) 2015年 jinzelu. All rights reserved.
//

#import "MineController.h"
#import "Public.h"
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

@interface MineController () <UITableViewDataSource, UITableViewDelegate>
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

@implementation MineController




- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refresh:) name:@"MineController_Refresh" object:nil];
    
    
    
    self.appDelegate = [[UIApplication sharedApplication] delegate];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
    //NSLog(@"%@",@"操作我的主界面");
    _titleView = [[TitleView alloc] initWithFrame:@"我的充值宝" leftMenuItem:nil rightMenuItem:nil ];
    
    
     [self.view addSubview:_titleView];
    
    
    
    MineInfoView *headerView = [[MineInfoView alloc] initWithFrame:CGRectMake(0, H(_titleView), screen_width, 70) userLabel:@"点击登陆" ];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self  action:@selector(clickCategory:)];
    tapGesture.numberOfTouchesRequired = 1; //手指数
    tapGesture.numberOfTapsRequired = 1; //tap次数
    [headerView setUserInteractionEnabled:YES];
    [headerView addGestureRecognizer:tapGesture];
    
    headerView.tag=Tag_HeaderViewField;
    
    
   // UIImageView *arrowImg = [[UIImageView alloc] initWithFrame:CGRectMake(screen_width-10-24, 30, 12, 24)];
   // [arrowImg setImage:[UIImage imageNamed:@"icon_mine_accountViewRightArrow"]];
    
    
    
    //[headerView addSubview: arrowImg];
    
    
    [self.view addSubview:headerView];

  
    _tableV = [[UITableView alloc] initWithFrame:CGRectMake(0, H(_titleView)+H(headerView), CGRectGetWidth(self.view.frame), screen_height -  H(_titleView)  - 20-H(headerView)-30) style:UITableViewStyleGrouped];
    _tableV.dataSource = self;
    _tableV.delegate = self;
   [self.view addSubview:_tableV];
    
    _arData = [NSMutableArray new];
    
    
    NSArray *ar1 = @[@"充值记录"];
    NSArray *ar2 = @[@"常见问题", @"意见反馈"];
    
    //,@"版本更新"
    NSArray *ar3 = @[@"关于我们"];
    
    [_arData addObject:ar1];
    [_arData addObject:ar2];
    [_arData addObject:ar3];
    
   
    [self initLogin];
    [_tableV reloadData];

    
    

    
    
    
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


-(void)refresh:(NSNotification *)notification {
    
    
    [self initLogin];
    [_tableV reloadData];
    
    
    //[NSString stringWithFormat:@"话费余额：%@", [Utils trim:self.appDelegate.phoneNumber]]
    
    /*if(notification.object && [notification.object isKindOfClass:[ShowViewController class]]){
        
        
        ShowViewController *view=(ShowViewController *)[notification object];
        NSDictionary *userInfo= [notification userInfo];
        UINavigationController* navController = (UINavigationController*)self.tabBarController.selectedViewController;
        if (navController!=Nil && view!=Nil) {
            
            [navController pushViewController:view animated:TRUE];
        }
        
    }
     NSLog(@"%@",@"我的主界面");
     */
    
    
    
}
-(void) initLogin{
    
    MineInfoView *headerView= (MineInfoView *)[self.view viewWithTag:Tag_HeaderViewField]  ;
    
    
    
    BOOL *isLogin = [[Tool sharedInstance]  isLogIn];
    headerView.arrowImg.hidden=true;
    if (! isLogin) {
        headerView.userNameLabel.text = @"点击登陆";
        headerView.moneyLabel.text=@"";
        
        headerView.arrowImg.hidden=false;
        return;
    }
    
    NSString *phoneNumber=[Utils getStoreValue:STORE_PHONENUMBER];
    
    headerView.userNameLabel.text = phoneNumber;
    headerView.moneyLabel.text=@"";
    
    
    /*
    
    NSDictionary *paraInfo = [NSDictionary dictionaryWithObjectsAndKeys:phoneNumber, @"PhoneNumber",
                              nil];
    [[NetworkSingleton sharedManager] getLeftMoney:paraInfo   successBlock:^(id responseBody){
        
        LeftRstModel *leftRstModel = [LeftRstModel objectWithKeyValues:responseBody];
        if(leftRstModel.respCode==0){
            
            
            
            leftRstModel.leftMoney=[NSString stringWithFormat:@"%0.0f", [leftRstModel.leftMoney floatValue]];
            [[Tool sharedInstance]  setLeftMoney:leftRstModel.leftMoney];
            
            headerView.moneyLabel.text = [NSString stringWithFormat:@"话费余额：%@元",  leftRstModel.leftMoney ];
            
            
        }else{
            
            _HUD = [Utils createHUD];
            _HUD.mode = MBProgressHUDModeCustomView;
            _HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"HUD-error"]];
            _HUD.labelText =leftRstModel.respInfo;
            [_HUD hide:YES afterDelay:1.0];
            
        }
        
        
    } failureBlock:^(NSString *error){
        
        _HUD = [Utils createHUD];
        _HUD.mode = MBProgressHUDModeCustomView;
        _HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"HUD-error"]];
        _HUD.labelText =error;
        [_HUD hide:YES afterDelay:1.0];
    }];*/

    
}
- (void)viewDidUnload{
    
    // 取消通知
    [[NSNotificationCenter defaultCenter]removeObserver:self
                                                   name:@"MineController_Refresh"
                                                 object:nil];
    
    
}


#pragma mark - action

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [_arData count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[_arData objectAtIndex:section] count];
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    
    /*
    if (section == 0) {
     
        return headerView;
    }else{*/
    
        //UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screen_width, 5)];
       /// headerView.backgroundColor = RGB(239, 239, 244);
       // return headerView;
    return @"";
    //}

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *reuseIdentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    cell.textLabel.text = [[_arData objectAtIndex:[indexPath section]] objectAtIndex:indexPath.row];
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 45;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0)
    {
        return 19;
    }
    return 18;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    BOOL *isLogin = [[Tool sharedInstance]  isLogIn];
    if(section==2 && isLogin)
        return 80;
    return 1;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    
    BOOL *isLogin = [[Tool sharedInstance]  isLogIn];
    if (section == 2 && isLogin){
        UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0.f, 0.f, screen_width, 80.f)];
        footerView.backgroundColor = [UIColor clearColor];
        
        
        
        APRoundedButton *exitBtn = [APRoundedButton buttonWithType:UIButtonTypeCustom];
        exitBtn.frame = CGRectMake( 10.f, 20.f, screen_width-20, 40.f);
        [exitBtn addTarget:self action:@selector(exitBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [exitBtn setBackgroundImage:nil forState:UIControlStateNormal];
        [exitBtn   setBackgroundColor:RGB(223,45,23)];
        //[registerBtn   forState:UIControlStateNormal];
        //backgroundColor
        [exitBtn setTitle:@"退出帐户" forState:UIControlStateNormal];
        [exitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        exitBtn.titleLabel.font = [UIFont systemFontOfSize:18.f];
        [exitBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
        exitBtn.style=10;
        [exitBtn awakeFromNib];
        
        
        [footerView addSubview:exitBtn];
        
        
        
        
        
        
        return  footerView ;
        
    }
    return nil;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    NSString *pictrueNameValue=cell.textLabel.text;
    
    if ([pictrueNameValue isEqualToString:@"关于我们"]){
        
        
        AboutController  *aboutController=[[AboutController alloc]init];
        aboutController.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:aboutController animated:YES];
        return;
        
    }
    
    if ([pictrueNameValue isEqualToString:@"常见问题"]){
        
        
        FaqController  *faqController=[[FaqController alloc]init];
        faqController.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:faqController animated:YES];
        return;
        
    }
    
    if ([pictrueNameValue isEqualToString:@"充值记录"]){
        if(![self checkLogin])
            return;
        
        RecordController  *recordController=[[RecordController alloc]init];
        recordController.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:recordController animated:YES];
        return;
        
    }

    if ([pictrueNameValue isEqualToString:@"意见反馈"]){
        
        if(![self checkLogin])
            return;
         AdviseController  *adviseController=[[ AdviseController alloc]init];
        adviseController.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:adviseController animated:YES];
        return;
        
    }

    
 
    
    
    
    
}


-(BOOL) checkLogin {
    
    BOOL *isLogin = [[Tool sharedInstance]  isLogIn];
    if(isLogin)
        return true;
    
    LoginController  *loginController=[[ LoginController alloc]init];
    loginController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:loginController animated:YES];
    return false;

    
}


-(void)clickCategory:(UITapGestureRecognizer *)gestureRecognizer
{
    
    
    UIView *viewClicked=[gestureRecognizer view];
    
    [self checkLogin];
    
   
    
    
    
}




#pragma mark test
-(void)exitBtnClicked :(UIButton *)sender{
    
    [Utils setStoreValue:STORE_REMEMBER storeValue:@"false"];
    [[Tool sharedInstance]  setLongIn:false];
    
    LoginController  *loginController=[[ LoginController alloc]init];
    loginController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:loginController animated:YES];
    
    return;

    
}





@end
