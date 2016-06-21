//
//  CSIIAppDelegate.m
//  ScrollView
//
//  Created by Hu Di on 13-10-11.
//  Copyright (c) 2013年 Sanji. All rights reserved.
//

#import "AppDelegate.h"
#import "GuideController.h"
#import "HomeController.h"
#import "ExpandController.h"
#import "MineController.h"
#import "Constant.h"
#import "Public.h"
#import "AboutController.h"
#import "AdviseController.h"
#import "FaqController.h"

#import "AgreeController.h"
#import "LoginController.h"

#import "MessageController.h"
#import "RecordController.h"
#import "FindController.h"
#import "RegisterController.h" 
#import "QcoinController.h"
#import "UMMobClick/MobClick.h"
#import "QcoinSuccessController.h"
#import "QmonthController.h"
#import "QmonthHandleController.h"
#import "QmonthCancelConfirmController.h"
#import "QmonthHandleConfirmController.h"
#import "QmonthCancelSuccessController.h"
#import "QmemberController.h"
#import "QmemberConfirmController.h"

@interface AppDelegate ()

@property (nonatomic, strong) GuideController *introductionView;
@property (strong, nonatomic) HomeController *homecontroller;

@property (strong, nonatomic) MineController *minecontroller;
@property (strong, nonatomic) MessageController *messagecontroller;
@end
@implementation AppDelegate

-(void) gotoMain{
    
    // self.viewcontroller =[[HomeNController alloc]init];
     //self.window.rootViewController=self.viewcontroller;
    
    
    
    
    self.homecontroller = [[HomeController alloc] init];
    UINavigationController *nav1 = [[UINavigationController alloc] initWithRootViewController:self.homecontroller];
    
    
    self.messagecontroller = [[MessageController alloc] init];
    UINavigationController *nav2 = [[UINavigationController alloc] initWithRootViewController:self.messagecontroller];
    
    
    
    
    self.minecontroller= [[MineController alloc] init];
    UINavigationController *nav3 = [[UINavigationController alloc] initWithRootViewController:self.minecontroller];
    self.homecontroller.title = @"充值";
    self.messagecontroller.title = @"消息";
    self.minecontroller.title = @"我的";
   
    
    NSArray *viewCtrs = @[nav1,nav2,nav3];
    
    UITabBarController *tabbarCtr = [[UITabBarController alloc] init];
   
    [tabbarCtr setViewControllers:viewCtrs animated:YES];
    
    self.window.rootViewController = tabbarCtr;
    
    
    UITabBar *tabbar = tabbarCtr.tabBar;
    UITabBarItem *item1 = [tabbar.items objectAtIndex:0];
    UITabBarItem *item2 = [tabbar.items objectAtIndex:1];
    UITabBarItem *item3= [tabbar.items objectAtIndex:2];
    
    item1.selectedImage = [[UIImage imageNamed:@"home_homepage_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    item1.image = [[UIImage imageNamed:@"home_homepage_notselected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    item1.imageInsets = UIEdgeInsetsMake(3, 0, -3, 0);
    
    item2.selectedImage = [[UIImage imageNamed:@"home_message_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    item2.image = [[UIImage imageNamed:@"home_message_notselected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    item2.imageInsets = UIEdgeInsetsMake(3, 0, -3, 0);
    
    
    item3.selectedImage = [[UIImage imageNamed:@"home_mine_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    item3.image = [[UIImage imageNamed:@"home_mine_notselected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    item3.imageInsets = UIEdgeInsetsMake(3, 0, -3, 0);
    
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:RGB(54, 185,175),UITextAttributeTextColor, nil] forState:UIControlStateSelected];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    
    
    
    //[[[[tabbarCtr viewControllers] objectAtIndex: indexICareAbout] tabBarItem] setBadgeValue:nil];

    //
    [self.window makeKeyAndVisible];
    

    
    
   // self.window.rootViewController=self.minecontroller;
  
    
    
    /*
    
    self.viewcontroller =[[HomeController alloc]init];
    UINavigationController *nav=[[UINavigationController alloc]initWithRootViewController:self.viewcontroller];
    self.window.rootViewController=nav;*/
    
}


-(void) gotoTest{
    
    //self.minecontroller =[[MineController alloc]init];
    ExpandController  *aboutController=[[ExpandController alloc]init];
    //[[UINavigationController alloc] initWithRootViewController:self.minecontroller];
    UINavigationController *testNav=  [[UINavigationController alloc]initWithRootViewController:aboutController];
    self.window.rootViewController = testNav;
     //self.window.rootViewController=aboutController;
    
   // self.testcontroller =[[HomeTController alloc]init];
    //self.window.rootViewController=self.testcontroller;
    
   
    
}
-(void)gotoTab:(int) tabIndex{
    
    tabIndex=tabIndex<0?0:tabIndex;
    tabIndex=tabIndex>2?2:tabIndex;
    
    
    UITabBarController *tabbarCtr =(UITabBarController *)self.window.rootViewController;
    //[tabbarCtr didSelectViewController]
    
    [tabbarCtr setSelectedIndex:tabIndex];
    //tabbarCtr.selectedIndex=tabIndex;
    
}


-(void) gotoLaunch{
    // Added Introduction View Controller
    
    NSArray *coverImageNames = @[@"img_index_01txt", @"img_index_02txt", @"img_index_03txt"];
    
    NSArray *backgroundImageNames = @[@"img_index_01bg", @"img_index_02bg", @"img_index_03bg"];
    
    self.introductionView = [[GuideController alloc] initWithCoverImageNames:coverImageNames backgroundImageNames:backgroundImageNames];
    
    //[self.window addSubview:self.introductionView.view];
    
    
    //self.viewcontroller =[[HomeNController alloc]init];
     self.window.rootViewController=self.introductionView;
    __weak AppDelegate *weakSelf = self;
    
    self.introductionView.didSelectedEnter = ^() {
        
        
        [weakSelf.introductionView.view removeFromSuperview];
        [weakSelf gotoMain] ;
     };
}

- (void)umengTrack {
    //    [MobClick setAppVersion:XcodeAppVersion]; //参数为NSString * 类型,自定义app版本信息，如果不设置，默认从CFBundleVersion里取
    [MobClick setLogEnabled:YES];
    UMConfigInstance.appKey =UM_APPKEY;
    //UMConfigInstance.secret = @"secretstringaldfkals";
    UMConfigInstance.channelId = @"App Store";
    //    UMConfigInstance.eSType = E_UM_GAME;
    [MobClick startWithConfigure:UMConfigInstance];
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    [MobClick setAppVersion:version];
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    
    [self umengTrack];
    
    _inNightMode =false;
 
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [NSThread sleepForTimeInterval:1.0]; //延时2秒，以便用户看清楚启动页
    self.window.backgroundColor = [UIColor whiteColor];
    [_window makeKeyAndVisible];
    
    NSUserDefaults * settings = [NSUserDefaults standardUserDefaults];
    NSString *key= [NSString stringWithFormat:STORE_FIRSTLOAD];
    NSString *value = [settings objectForKey:key];
    
    if (!value)  //如果没有数据
    {
        [self gotoLaunch] ;
        
        //写入数据
        NSUserDefaults * setting = [NSUserDefaults standardUserDefaults];
        NSString * key = [NSString stringWithFormat: STORE_FIRSTLOAD];
        [setting setObject:[NSString stringWithFormat:@"false"] forKey:key];
        [setting synchronize];
    }else{
        [self gotoMain] ;
    }
    
    
    
    
        /*
    self.viewcontroller =[[HBPayViewController alloc]init];
    UINavigationController *nav=[[UINavigationController alloc]initWithRootViewController:self.viewcontroller];
    self.window.rootViewController=nav;
    */
    //[[UIApplication sharedApplication] setStatusBarHidden:NO];
    //启动完成后显示状态栏，该语句应该放在 makeKeyAndVisible 之前
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
