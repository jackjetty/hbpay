 
#import "AppDelegate.h"
#import "HomeController.h"
#import "ImageScrollView.h"
#import "TbImageView.h"
#import "MineImageView.h"
#import "Public.h"
#import "HomeCellModel.h"
#import "MineCellModel.h" 
#import "NetworkSingleton.h"
#import "Utils.h"
#import "Constant.h"
#import "LaunchModel.h"
#import "LaunchBussinessModel.h"
#import "LoginController.h"
#import "LaunchProductModel.h"
#import "QcoinController.h"
#import "QmonthController.h"
#import "QmemberController.h"
#import "LaunchSaleModel.h"
#import "LoginRstModel.h"
#import "MineController.h"
static NSUInteger const ADVERTHEIGHT = 140;
static NSUInteger const TABHEIGHT = 50;
static NSUInteger const CELLSPACE = 6;//记录中间图片的下标,开始总是为1

@interface HomeController ()
@property (nonatomic, strong) MBProgressHUD   *HUD;
@property  AppDelegate *appDelegate;
@end

@implementation HomeController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.appDelegate = [[UIApplication sharedApplication] delegate];

    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
   
    
    [self createScrollView];
}
- (void)viewWillAppear:(BOOL)animated{
    NSString * leftMoney= [[Tool sharedInstance]  getLeftMoney];
    if([leftMoney isEqualToString:@""]){
        _mineIcon.mineLabel.text=@"我的168";
    }else{
        
        _mineIcon.mineLabel.text=[NSString stringWithFormat:@"余额：￥%@", leftMoney];
    }
    
    
}

- (void)viewWillDisappear:(BOOL)animated{
    
}

#pragma mark - 构建广告滚动视图
- (void)createScrollView
{
    
    ImageScrollView * scrollView = [[ImageScrollView alloc]initWithFrame:CGRectMake(0, 0, screen_width, ADVERTHEIGHT)  ];
    [self.view addSubview:scrollView];
  
    
    /*
    
    NSString *imageUrl=@"http://115.239.134.175/AppServer/images/QQ.jpg";
    
    NSArray *imageUrlArray=[NSArray arrayWithObjects:
                             imageUrl,
                             imageUrl,
                             imageUrl,nil];
    
    
    
    [scrollView setImageArray:imageUrlArray];*/
    
    //scrollView.pageControl.pageIndicatorTintColor = [UIColor whiteColor];
    //scrollView.pageControl.currentPageIndicatorTintColor = [UIColor purpleColor];
    
    
    
    HomeCellModel *homeCellModel=[HomeCellModel new];
    MineCellModel *mineCellModel;
    
    /*
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self  action:@selector(clickCategory:)];
    tapGesture.numberOfTouchesRequired = 1; //手指数
    tapGesture.numberOfTapsRequired = 1; //tap次数
    [_chargeIcon setUserInteractionEnabled:YES];
    [_chargeIcon addGestureRecognizer:tapGesture];
    */
    
    //_HUD = [Utils createHUD];
    
    //_HUD.labelText=@"正在发送反馈";
    
    
    
    
    
    
    
    homeCellModel.cellId=@"charge";
    homeCellModel.bgColor=[UIColor colorWithRed:69/255.0 green:140/255.0 blue:255/255.0 alpha:1];
    homeCellModel.productTip=@"";
    homeCellModel.imageName=@"img_tip_charge";
    homeCellModel.productName=@"QQ直充";
    
    _chargeIcon= [[TbImageView alloc]initWithFrame:CGRectMake(CELLSPACE, ADVERTHEIGHT+CELLSPACE, (screen_width-4*CELLSPACE)*6/15, (screen_height-ADVERTHEIGHT-TABHEIGHT-4*CELLSPACE)/3) CellModel: homeCellModel];
    
    _chargeIcon.delegate = self;
    [self.view addSubview:_chargeIcon];
    
    
    
    
    
    homeCellModel=[HomeCellModel new];
    homeCellModel.cellId=@"month";
    homeCellModel.bgColor=[UIColor colorWithRed:128/255.0 green:138/255.0 blue:255/255.0 alpha:1];
    homeCellModel.productTip=@"";
    homeCellModel.imageName=@"img_tip_month";
    homeCellModel.productName=@"Q币包月";
    
    _monthIcon = [[TbImageView alloc]initWithFrame:CGRectMake(2*CELLSPACE +(screen_width-4*CELLSPACE)*6/15,  ADVERTHEIGHT+CELLSPACE, (screen_width-4*CELLSPACE)*5/15, (screen_height-ADVERTHEIGHT-TABHEIGHT-4*CELLSPACE)/3) CellModel: homeCellModel];
    _monthIcon.delegate = self;
    [self.view addSubview:_monthIcon];
    
    
    
    homeCellModel=[HomeCellModel new];
    
    homeCellModel.cellId=@"member";
    
    homeCellModel.bgColor=[UIColor colorWithRed:158/255.0 green:86/255.0 blue:255/255.0 alpha:1];
    homeCellModel.productTip=@"";
    homeCellModel.imageName=@"img_tip_member";
    homeCellModel.productName=@"QQ会员";
    
    _memberIcon = [[TbImageView alloc]initWithFrame:CGRectMake(3*CELLSPACE+(screen_width-4*CELLSPACE)*11/15,  ADVERTHEIGHT+CELLSPACE, (screen_width-4*CELLSPACE)*4/15 , (screen_height-ADVERTHEIGHT-TABHEIGHT-4*CELLSPACE)/3) CellModel: homeCellModel];
    _memberIcon.delegate = self;
    [self.view addSubview:_memberIcon];
    
    //第二行
    
    homeCellModel=[HomeCellModel new];
    
    homeCellModel.cellId=@"flow";
    
    homeCellModel.bgColor=[UIColor colorWithRed:15/255.0 green:201/255.0 blue:212/255.0 alpha:1];
    homeCellModel.productTip=@"";
    homeCellModel.imageName=@"img_tip_flow";
    homeCellModel.productName=@"流量包";
    
    _flowIcon = [[TbImageView alloc]initWithFrame:CGRectMake(CELLSPACE ,  ADVERTHEIGHT+2*CELLSPACE+(screen_height-ADVERTHEIGHT-TABHEIGHT-4*CELLSPACE)/3, (screen_width-4*CELLSPACE)*6/15, (screen_height-ADVERTHEIGHT-TABHEIGHT-4*CELLSPACE)/3) CellModel: homeCellModel];
    _flowIcon.delegate = self;
    [self.view addSubview:_flowIcon];
    
    mineCellModel=[MineCellModel new];
    mineCellModel.cellId=@"mine";
    mineCellModel.imageName=@"img_tip_mine";
    mineCellModel.mineTitle=@"我的168";
    
    _mineIcon=[[MineImageView alloc]initWithFrame:CGRectMake(2*CELLSPACE +(screen_width-4*CELLSPACE)*6/15 ,  ADVERTHEIGHT+2*CELLSPACE+(screen_height-ADVERTHEIGHT-TABHEIGHT-4*CELLSPACE)/3, (screen_width-4*CELLSPACE)*5/15, (screen_height-ADVERTHEIGHT-TABHEIGHT-4*CELLSPACE)/3) CellModel: mineCellModel];
    _mineIcon.delegate = self; 
    [self.view addSubview:_mineIcon];
    
    
    
    
    homeCellModel=[HomeCellModel new];
    homeCellModel.cellId=@"vcoin";
    homeCellModel.bgColor=[UIColor colorWithRed:255/255.0 green:103/255.0 blue:121/255.0 alpha:1];
    homeCellModel.productTip=@"";
    homeCellModel.imageName=@"img_tip_vcoin";
    homeCellModel.productName=@"V币";
    
    _vcoinIcon = [[TbImageView alloc]initWithFrame:CGRectMake(3*CELLSPACE+(screen_width-4*CELLSPACE)*11/15 ,  ADVERTHEIGHT+2*CELLSPACE+(screen_height-ADVERTHEIGHT-TABHEIGHT-4*CELLSPACE)/3, (screen_width-4*CELLSPACE)*4/15, (screen_height-ADVERTHEIGHT-TABHEIGHT-4*CELLSPACE)/3) CellModel: homeCellModel];
    
    _vcoinIcon.delegate = self;
    [self.view addSubview:_vcoinIcon];
    
    
    //第三行
    
    homeCellModel=[HomeCellModel new];
    
    homeCellModel.cellId=@"bill";
    
    homeCellModel.bgColor=[UIColor colorWithRed:132/255.0 green:210/255.0 blue:0/255.0 alpha:1];
    homeCellModel.productTip=@"";
    homeCellModel.imageName=@"img_tip_bill";
    homeCellModel.productName=@"话费充值";
    
    _billIcon = [[TbImageView alloc]initWithFrame:CGRectMake(CELLSPACE ,  ADVERTHEIGHT+3*CELLSPACE+2*(screen_height-ADVERTHEIGHT-TABHEIGHT-4*CELLSPACE)/3, (screen_width-4*CELLSPACE)*6/15, (screen_height-ADVERTHEIGHT-TABHEIGHT-4*CELLSPACE)/3) CellModel: homeCellModel];
    _billIcon.delegate = self;
    [self.view addSubview:_billIcon];
    
    
    
    
    homeCellModel=[HomeCellModel new];
    homeCellModel.cellId=@"city";
    homeCellModel.bgColor=[UIColor colorWithRed:255/255.0 green:186/255.0 blue:0/255.0 alpha:1];
    homeCellModel.productTip=@"";
    homeCellModel.imageName=@"img_tip_city";
    homeCellModel.productName=@"同城游";
    
    _cityIcon = [[TbImageView alloc]initWithFrame:CGRectMake(2*CELLSPACE +(screen_width-4*CELLSPACE)*6/15,  ADVERTHEIGHT+3*CELLSPACE+2*(screen_height-ADVERTHEIGHT-TABHEIGHT-4*CELLSPACE)/3, (screen_width-4*CELLSPACE)*5/15, (screen_height-ADVERTHEIGHT-TABHEIGHT-4*CELLSPACE)/3) CellModel: homeCellModel];
    _cityIcon.delegate = self;
    [self.view addSubview:_cityIcon];
    
    

    
    homeCellModel=[HomeCellModel new];
    
    homeCellModel.cellId=@"more";
    homeCellModel.bgColor=[UIColor colorWithRed:255/255.0 green:103/255.0 blue:121/255.0 alpha:1];
    homeCellModel.productTip=@"";
    homeCellModel.imageName=@"img_tip_more";
    homeCellModel.productName=@"更多";
    
    _moreIcon = [[TbImageView alloc]initWithFrame:CGRectMake(3*CELLSPACE+(screen_width-4*CELLSPACE)*11/15 ,  ADVERTHEIGHT+3*CELLSPACE+2*(screen_height-ADVERTHEIGHT-TABHEIGHT-4*CELLSPACE)/3, (screen_width-4*CELLSPACE)*4/15, (screen_height-ADVERTHEIGHT-TABHEIGHT-4*CELLSPACE)/3) CellModel: homeCellModel]; 
    _moreIcon.delegate = self;
    
    [self.view addSubview:_moreIcon];
    
     //NSMutableDictionary *dic=[NSMutableDictionary objectFromJSONStringWithParseOptions:／／JKParseOptionLooseUnicode];
    //网络开始啊
    [[NetworkSingleton sharedManager] getHomeResule:nil   successBlock:^(id responseBody){
        
       //
        
        
        
        
        LaunchModel *launchModel = [LaunchModel objectWithKeyValues:responseBody];
        
        
        //NSLog(@"%d",launchModel.MessageNumber);
        
        
        if(![[Tool sharedInstance]  isLogIn] ){
            NSString *badgeValue =launchModel.MessageNumber>0? [NSString stringWithFormat:@"%d",launchModel.MessageNumber]:nil;
            [[[[[self tabBarController] viewControllers] objectAtIndex: 1] tabBarItem] setBadgeValue:badgeValue];
            [[Tool sharedInstance]  setMessageNumber:launchModel.MessageNumber];
        }
        
        
        
        
        
        
        
        LaunchBussinessModel *launchBussinessModel;
        NSMutableArray *nsma =  [launchModel.businessList mutableCopy];
        
        for (int i = 0; i < launchModel.businessList.count; i++) {
            
            launchBussinessModel= [LaunchBussinessModel objectWithKeyValues:launchModel.businessList[i]];
            [nsma replaceObjectAtIndex:i withObject:launchBussinessModel];
        }
        launchModel.businessList = [nsma copy];
        
        LaunchProductModel *launchProductModel;
        nsma =  [launchModel.ProductInfo mutableCopy];
        for (int i = 0; i < launchModel.ProductInfo.count; i++) {
            
            launchProductModel= [LaunchProductModel objectWithKeyValues:launchModel.ProductInfo[i]];
            [nsma replaceObjectAtIndex:i withObject:launchProductModel];
        }
        launchModel.ProductInfo = [nsma copy];
        
       
        LaunchSaleModel *launchSaleModel;
        nsma =  [launchModel.SalesInfo mutableCopy];
        
        
        NSMutableArray *imageUrlnsma=[[NSMutableArray alloc] init];
        
        
        for (int i = 0; i < launchModel.SalesInfo.count; i++) {
            
            launchSaleModel= [LaunchSaleModel objectWithKeyValues:launchModel.SalesInfo[i]];
            [nsma replaceObjectAtIndex:i withObject:launchSaleModel];
            if(![[Utils trim:launchSaleModel.WholeUrl] isEqualToString:@""])
                [imageUrlnsma addObject:[Utils trim:launchSaleModel.WholeUrl]];
        }
        launchModel.SalesInfo = [nsma copy];
        
        
        
        NSArray *imageUrlArray=[imageUrlnsma copy];
        [scrollView setImageArray:imageUrlArray];
        
        NSString *busId ;
        for(launchBussinessModel in launchModel.businessList){
            
            busId=[launchBussinessModel.code stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
           
            if([busId isEqualToString:QCOINBUSID ]){
                _chargeIcon.rebatLabel.text=[launchBussinessModel.homeTip stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
                
                
                
                continue;
            }
           
            if([busId isEqualToString:QMONTHBUSID ]){
                _monthIcon.rebatLabel.text=[launchBussinessModel.homeTip stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
                continue;
            }
            

            if([busId isEqualToString: QMEMBERBUSID ]){
                _memberIcon.rebatLabel.text=[launchBussinessModel.homeTip stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
                continue;
            }
            
        }
        
        
        for(launchProductModel in launchModel.ProductInfo){
            
            busId=[launchProductModel.id stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
            
            if([busId isEqualToString:QCOINBUSID ]){
                
                [Utils setStoreValue:STORE_QCOINPAYTIP  storeValue:[Utils trim:launchProductModel.chargeTipContent]];
                
                continue;
            }
            
            if([busId isEqualToString:QMONTHBUSID ]){
                [Utils setStoreValue:STORE_QMONTHPAYTIP  storeValue:[Utils trim:launchProductModel.chargeTipContent]];
                continue;
            }
            
            
            if([busId isEqualToString: QMEMBERBUSID ]){
                [Utils setStoreValue:STORE_QMEMBERPAYTIP  storeValue:[Utils trim:launchProductModel.chargeTipContent]];
                continue;
            }
            
        }
        
        

        
        //
        
        
        
        
      //NSLog(@"%@" , [responseBody objectForKey:@"FlowPrompt"] );
        
       // NSMutableArray *array = [responseBody objectForKey:@"businessList"];
        //
        //launchModel.businessList=[[NSMutableArray alloc] init];
        
       // for (int i = 0; i < array.count; i++) {
          //  launchBussinessModel= [LaunchBussinessModel objectWithKeyValues:array[i]];
          //  [launchModel.businessList addObject:launchBussinessModel];
           
       // }

       
        
        
        
       // for(launchBussinessModel in launchModel.businessList)
       // {
            
            
            // NSLog(@"%@",  launchBussinessModel.code );
            
            //
           //
            
             /*tempId=@"100";
             */
       // }
        /*
         #define QCOINBUSID @"100";
         #define QMONTHBUSID @"103";
         #define QMEMBERBUSID @"104";*/
        
        
        //[_HUD hide:YES];
        
        /*_HUD = [Utils createHUD];
         
         _HUD.mode = MBProgressHUDModeCustomView;
         _HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"HUD-done"]];
         _HUD.labelText = @"发送成功，感谢您的反馈";
         [_HUD hide:YES afterDelay:2];*/
        
        
        //[self performSelectorOnMainThread:@selector(reloadTable) withObject:nil waitUntilDone:YES];
    } failureBlock:^(NSString *error){
        //[self performSelectorOnMainThread:@selector(reloadTable) withObject:nil waitUntilDone:YES];
        _HUD = [Utils createHUD];
        _HUD.mode = MBProgressHUDModeCustomView;
        _HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"HUD-error"]];
        _HUD.labelText =error;
        [_HUD hide:YES afterDelay:1.0];
    }];

    
     [self autoLoad];
    
    
     [self hsUpdateApp];
    
    
    
}


-(void)onClickImage{
    
    NSLog(@"图片被点击!");
}

-(void) autoLoad{
    
    NSString *phoneNumber,*password,*isRemember,*encodePassword;
    isRemember=[Utils getStoreValue:STORE_REMEMBER];
    if(![isRemember isEqualToString:@"true"]){
        
        
        
        return;
    }
    phoneNumber=[Utils getStoreValue:STORE_PHONENUMBER];
    password=[Utils getStoreValue:STORE_PASSWORD];
    encodePassword=[Utils md5:password];
    encodePassword=[Utils encodeBase64String:encodePassword];
    NSDictionary *paraInfo = [NSDictionary dictionaryWithObjectsAndKeys:phoneNumber, @"PhoneNumber", encodePassword, @"Password",nil];
    
    
    
    //868108249
    
    
    
    [[NetworkSingleton sharedManager] userLogin:paraInfo   successBlock:^(id responseBody){
        
        
        LoginRstModel *loginRstModel = [LoginRstModel objectWithKeyValues:responseBody];
        if(loginRstModel.respCode!=0){
            return;
        }
        
        NSString *badgeValue =loginRstModel.MessageNumber>0? [NSString stringWithFormat:@"%d",loginRstModel.MessageNumber]:nil;
        [[[[[self tabBarController] viewControllers] objectAtIndex: 1] tabBarItem] setBadgeValue:badgeValue];
        
        [[Tool sharedInstance]  setMessageNumber: loginRstModel.MessageNumber];
        
        
        [[Tool sharedInstance]  setLongIn:true];
        
        
    } failureBlock:^(NSString *error){
        
        _HUD = [Utils createHUD];
        _HUD.mode = MBProgressHUDModeCustomView;
        _HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"HUD-error"]];
        _HUD.labelText =error;
        [_HUD hide:YES afterDelay:1.0];
    }];
    
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(void)clickCategory:(UITapGestureRecognizer *)gestureRecognizer
{
    NSLog(@"%hhd",[gestureRecognizer isMemberOfClass:[UITapGestureRecognizer class]]);
    
    UIView *viewClicked=[gestureRecognizer view];
    if (viewClicked==_chargeIcon) {
        NSLog(@"bbc");
    }
    
}


#pragma mark - HomeBoxDelegate
-(void)didSelectMineImage{
    
    BOOL *isLogin = [[Tool sharedInstance]  isLogIn];
    if (isLogin) {
         MineController  *mineController=[[MineController alloc]init];
        [self.appDelegate gotoTab:2];
        
        //[self.navigationController pushViewController:mineController animated:YES];
        //[self presentModalViewController:mineController animated:YES];
        
        return;
    }

    LoginController  *loginController=[[LoginController alloc]init];
    loginController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:loginController animated:YES];
}
-(void)didSelectTbImage:(NSString *)cellId{
    
    if([cellId isEqualToString:@"charge"]){
        QcoinController  *qcoinController=[[QcoinController alloc]init];
        qcoinController.hidesBottomBarWhenPushed = YES;
        self.appDelegate.titleName=@"Q币直充";
        [self.navigationController pushViewController:qcoinController animated:YES];
        return;

    }
    if([cellId isEqualToString:@"month"]){
        QmonthController  *qmonthController=[[QmonthController alloc]init];
        qmonthController.hidesBottomBarWhenPushed = YES;
        self.appDelegate.titleName=@"Q币包月";
        [self.navigationController pushViewController:qmonthController animated:YES];
        return;
        
    }
    if([cellId isEqualToString:@"member"]){
        QmemberController  *qmemberController=[[QmemberController alloc]init];
        qmemberController.hidesBottomBarWhenPushed = YES;
        self.appDelegate.titleName=@"QQ会员";
        [self.navigationController pushViewController:qmemberController animated:YES];
        return;
        
    }
    NSString *phoneNumber=[Utils getStoreValue:STORE_PHONENUMBER];
    if([cellId isEqualToString:@"flow"] &&
        [phoneNumber isEqualToString:@"18158171080"]){
        QmonthController  *qmonthController=[[QmonthController alloc]init];
        qmonthController.hidesBottomBarWhenPushed = YES;
        self.appDelegate.titleName=@"流量包";
        [self.navigationController pushViewController:qmonthController animated:YES];
        return;
        
    }
    if([cellId isEqualToString:@"vcoin"] &&
       [phoneNumber isEqualToString:@"18158171080"]){
        QcoinController  *qcoinController=[[QcoinController alloc]init];
        qcoinController.hidesBottomBarWhenPushed = YES;
        self.appDelegate.titleName=@"V币";
        [self.navigationController pushViewController:qcoinController animated:YES];
        return;

        
    }
    if([cellId isEqualToString:@"bill"] &&
       [phoneNumber isEqualToString:@"18158171080"]){
        QmemberController  *qmemberController=[[QmemberController alloc]init];
        qmemberController.hidesBottomBarWhenPushed = YES;
        self.appDelegate.titleName=@"话费充值";
        [self.navigationController pushViewController:qmemberController animated:YES];
        return;
        
    }
    
    if([cellId isEqualToString:@"city"] &&
       [phoneNumber isEqualToString:@"18158171080"]){
        QcoinController  *qcoinController=[[QcoinController alloc]init];
        qcoinController.hidesBottomBarWhenPushed = YES;
        self.appDelegate.titleName=@"同城游";
        [self.navigationController pushViewController:qcoinController animated:YES];
        return;
        
        
    }
    if([cellId isEqualToString:@"more"] &&
       [phoneNumber isEqualToString:@"18158171080"]){
        [self.appDelegate gotoTab:2];

        return;
        
        
    }
    
    
    _HUD = [Utils createHUD];
    _HUD.mode = MBProgressHUDModeCustomView;
    _HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"HUD-error"]];
    _HUD.labelText =@"敬请期待！";
    [_HUD hide:YES afterDelay:1.0];
    return;
 }
-(void)hsUpdateApp
{
    //2先获取当前工程项目版本号
    NSDictionary *infoDic=[[NSBundle mainBundle] infoDictionary];
    NSString *currentVersion=infoDic[@"CFBundleShortVersionString"];
    
    //3从网络获取appStore版本号
    NSError *error;
    NSData *response = [NSURLConnection sendSynchronousRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://itunes.apple.com/cn/lookup?id=%@",STOREAPPID]]] returningResponse:nil error:nil];
    if (response == nil) {
        NSLog(@"你没有连接网络哦");
        return;
    }
    NSDictionary *appInfoDic = [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableLeaves error:&error];
    if (error) {
        NSLog(@"hsUpdateAppError:%@",error);
        return;
    }
    NSArray *array = appInfoDic[@"results"];
    NSDictionary *dic = array[0];
    NSString *appStoreVersion = dic[@"version"];
    //打印版本号
   // NSLog(@"当前版本号:%@\n商店版本号:%@",currentVersion,appStoreVersion);
    //4当前版本号小于商店版本号,就更新
    
    
    if([currentVersion compare:appStoreVersion]==NSOrderedAscending )
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"版本有更新" message:[NSString stringWithFormat:@"检测到新版本(%@),是否更新?",appStoreVersion] delegate:self cancelButtonTitle:@"取消"otherButtonTitles:@"更新",nil];
        [alert show];
    }else{
        NSLog(@"版本号好像比商店大噢!检测到不需要更新");
    }
    
}

- (void)alertView:(UIAlertView*)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    //5实现跳转到应用商店进行更新
    if(buttonIndex==1)
    {
        //6此处加入应用在app store的地址，方便用户去更新，一种实现方式如下：
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://itunes.apple.com/us/app/id%@?ls=1&mt=8", STOREAPPID]];
        [[UIApplication sharedApplication] openURL:url];
    }
}


@end

