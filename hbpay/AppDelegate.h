//
//  CSIIAppDelegate.h
//  ScrollView
//
//  Created by Hu Di on 13-10-11.
//  Copyright (c) 2013年 Sanji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIColor+Util.h"
#import "Utils.h"
#import "Constant.h"
#import "Tool.h"
#import "MBProgressHUD.h"
#import "Public.h"
#import "NetworkSingleton.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, assign) BOOL inNightMode;
@property (strong, nonatomic) NSString *qqNumber;
@property (strong, nonatomic) NSString *phoneNumber;

@property (strong, nonatomic) NSString *qqCount;
@property (strong, nonatomic) NSString *payMoney;
@property (strong, nonatomic) NSString *productId;
@property (strong, nonatomic) NSString *qqMonth;
@property (strong, nonatomic) NSString *qqMemberTypeName;

@property (strong, nonatomic) NSString *titleName;
-(void)gotoTab:(int) tabIndex;
//UIViewController

@end
