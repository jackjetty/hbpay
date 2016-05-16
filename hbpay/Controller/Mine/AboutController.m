//
//  AboutPage.m
//  iosapp
//
//  Created by chenhaoxiang on 3/6/15.
//  Copyright (c) 2015 oschina. All rights reserved.
//

#import "AboutController.h"
#import "UIColor+Util.h"
#import "Public.h"
#import "TitleView.h"
@interface AboutController ()
@property ( nonatomic,retain) TitleView *titleView;
@end

@implementation AboutController

- (void)viewDidLoad
{
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
    
    
    UIImageView *logo = [UIImageView new];
    logo.contentMode = UIViewContentModeScaleAspectFit;
    logo.image = [UIImage imageNamed:@"logo_qr"];
    [self.view addSubview:logo];
    
    UILabel *declarationLabel = [UILabel new];
    declarationLabel.numberOfLines = 0;
    declarationLabel.lineBreakMode = NSLineBreakByWordWrapping;
    declarationLabel.textAlignment = NSTextAlignmentCenter;
    declarationLabel.textColor = [UIColor lightGrayColor];
    
    declarationLabel.font = [UIFont fontWithName:@"Helvetica" size:18];
    NSString *version = [[NSBundle mainBundle] objectForInfoDictionaryKey: @"CFBundleShortVersionString"];
    declarationLabel.text = [NSString stringWithFormat:@"Version:%@\n\n©2014-2015 浙江电信.\nAll rights reserved.", version];
    
    [self.view addSubview:declarationLabel];
    
    
    
    UILabel *OSLicenseLabel = [UILabel new];
    
    OSLicenseLabel.textColor = [UIColor lightGrayColor];
    declarationLabel.font = [UIFont fontWithName:@"Helvetica" size:16];
    OSLicenseLabel.text = @"合作运营:杭州冉思科技有限公司";
   //OSLicenseLabel.userInteractionEnabled = YES;
    /*[OSLicenseLabel addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onClickOSLicenseLabel)]];*/
    
    [self.view addSubview:OSLicenseLabel];
    
    for (UIView *view in self.view.subviews) {view.translatesAutoresizingMaskIntoConstraints = NO;}
    NSDictionary *views = NSDictionaryOfVariableBindings(logo, declarationLabel);
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:logo      attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.0f constant:0.f]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:logo      attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view attribute:NSLayoutAttributeCenterY multiplier:1.0f constant:-90.f]];
    
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[logo(80)]-20-[declarationLabel]" options:NSLayoutFormatAlignAllCenterX metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"[logo(80)]" options:0 metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"[declarationLabel(200)]" options:0 metrics:nil views:views]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:OSLicenseLabel attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view      attribute:NSLayoutAttributeCenterX multiplier:1.0f constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:OSLicenseLabel attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view      attribute:NSLayoutAttributeBottom multiplier:1.0f constant:-50.f]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)OnTapBackBtn:(UIButton *)sender{
    [self.navigationController popViewControllerAnimated:YES];
}





@end
