//
//  FeedbackPage.m
//  iosapp
//
//  Created by chenhaoxiang on 3/7/15.
//  Copyright (c) 2015 oschina. All rights reserved.
//

#import "AdviseController.h"
#import "PlaceholderTextView.h"
#import "AppDelegate.h"
#import "MBProgressHUD.h"
#import "Utils.h"
#import "Public.h"
#import "Constant.h"
#import "TitleView.h"
#import "NetworkSingleton.h"
#import "AdviseRstModel.h"
@interface AdviseController ()<UIAlertViewDelegate>

@property (nonatomic, strong) PlaceholderTextView *feedbackTextView;
@property (nonatomic, strong) MBProgressHUD       *HUD;
@property (nonatomic,retain)  TitleView *titleView;

@end

@implementation AdviseController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
    UIButton *backBtn = [UIButton buttonWithType: UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, (title_height+20-40)/2, 40, 40);
    [backBtn setImage:[UIImage imageNamed:@"tital_back"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(OnTapBackBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    
    UILabel *rightLabel = [UILabel new];
    rightLabel.frame = CGRectMake(screen_width-40, (title_height+22-40)/2, 40, 40);
    
    rightLabel.textColor = [UIColor whiteColor];
    rightLabel.font = [UIFont fontWithName:@"Helvetica" size:16];
    rightLabel.text = @"发送";
    rightLabel.userInteractionEnabled = YES;
    [rightLabel addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onClickRightLabel)]];
    
    
    
    
    _titleView = [[TitleView alloc] initWithFrame:@"意见反馈" leftMenuItem:backBtn rightMenuItem:rightLabel ];
    [self.view addSubview:_titleView];

    
    //self.navigationItem.title = @"";
   /* self.navigationItem.*/
    
     [self setLayout];
   
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    self.view.backgroundColor = [UIColor themeColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [_HUD hide:YES];
    [super viewWillDisappear:animated];
}


- (void)setLayout
{
    _feedbackTextView = [PlaceholderTextView new];
    _feedbackTextView.placeholder = @"感谢您的反馈，请提出您的意见与建议";
    [_feedbackTextView setCornerRadius:3.0];
    _feedbackTextView.font = [UIFont systemFontOfSize:17];
    _feedbackTextView.translatesAutoresizingMaskIntoConstraints = NO;
    [_feedbackTextView becomeFirstResponder];
    [self.view addSubview:_feedbackTextView];
    
    if (((AppDelegate *)[UIApplication sharedApplication].delegate).inNightMode) {
        _feedbackTextView.backgroundColor = [UIColor colorWithRed:60.0/255 green:60.0/255 blue:60.0/255 alpha:1.0];
        _feedbackTextView.textColor = [UIColor titleColor];
    }
    
    NSDictionary *views = NSDictionaryOfVariableBindings(_feedbackTextView);
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-70-[_feedbackTextView]" options:0 metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-8-[_feedbackTextView]-8-|"    options:0 metrics:nil views:views]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.view
                                                          attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual
                                                             toItem:_feedbackTextView attribute:NSLayoutAttributeBottom  multiplier:1.0 constant:10]];
}


- (void)onClickRightLabel
{
    
    NSString *phoneNumber,*fbContent;
    
    
    phoneNumber=[Utils getStoreValue:STORE_PHONENUMBER];

    fbContent=[_feedbackTextView text];
    fbContent=[Utils trim:fbContent];
    if([fbContent isEqualToString:@""]){
        [Utils alertTitle:@"提示" message:@"发送消息不能为空" delegate:self cancelBtn:@"确定" otherBtnName:nil];
        
        return ;

    }
    
    [_feedbackTextView resignFirstResponder];
    fbContent=[Utils encodeUTF8Str:fbContent];
    
    _HUD = [Utils createHUD];
    _HUD.labelText = @"";
    NSDictionary *paraInfo = [NSDictionary dictionaryWithObjectsAndKeys:phoneNumber, @"PhoneNumber", fbContent, @"FBContent",phoneNumber, @"ContactNumber",@"", @"Email",nil];
     
    
    [[NetworkSingleton sharedManager]  feedBack:paraInfo   successBlock:^(id responseBody){
        
        
        [_HUD hide:YES];
        AdviseRstModel *adviseRstModel = [AdviseRstModel objectWithKeyValues:responseBody];
        if(adviseRstModel.respCode==0){
            [Utils alertTitle:@"提示" message:@"提交成功" delegate:self cancelBtn:@"确 定" otherBtnName:nil];
            
        }else{
            [Utils alertTitle:@"提示" message:adviseRstModel.respInfo delegate:self cancelBtn:@"确定" otherBtnName:nil];
            
        }
        
    } failureBlock:^(NSString *error){
        
        _HUD = [Utils createHUD];
        _HUD.mode = MBProgressHUDModeCustomView;
        _HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"HUD-error"]];
        _HUD.labelText =error;
        [_HUD hide:YES afterDelay:1.0];
    }];

    
    
    
     /*  NSString *trimmedString = [_feedbackTextView.text stringByTrimmingCharactersInSet:
                               [NSCharacterSet whitespaceAndNewlineCharacterSet]];*/
  
    
   
    
    
    
}

- (void)OnTapBackBtn:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString *btnTitle = [alertView buttonTitleAtIndex:buttonIndex];
    if ([btnTitle isEqualToString:@"确 定"]) {
        [self.navigationController popViewControllerAnimated:YES];
        
    }
}


@end
