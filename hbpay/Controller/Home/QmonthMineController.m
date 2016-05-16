


#import "QmonthMineController.h"


@interface QmonthMineController ()

enum TAG_FORM_TEXTFIELD{
    
    
    Tag_QQNumberTextField =20,        //用户名
    Tag_DiscountTip
    
};


@end
@implementation QmonthMineController
@synthesize delegate;
- (void)viewDidLoad
{
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refresh:) name:@"QmonthMineController_Refresh" object:nil];
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    self.appDelegate = [[UIApplication sharedApplication] delegate];

    
    
    _formTableView = [[UITableView alloc] initWithFrame:CGRectMake(0.f, 0, screen_width, screen_height) style:UITableViewStyleGrouped];
    _formTableView.allowsSelection = NO;
    _formTableView.delegate = self;
    _formTableView.dataSource = self;
    _formTableView.separatorStyle = NO;
    _backColor=_formTableView.backgroundColor;
    
    
    [self initLogin];
    [self.view addSubview:_formTableView];
    UITapGestureRecognizer *hideKeyboardRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(allEditActionsResignFirstResponder)];
    [_formTableView addGestureRecognizer:hideKeyboardRecognizer];
    hideKeyboardRecognizer.cancelsTouchesInView = NO;
    
}

- (void)viewDidUnload{
    
    // 取消通知
    [[NSNotificationCenter defaultCenter]removeObserver:self
                                                   name:@"QmonthMineController_Refresh"
                                                 object:nil];
    
    
}
-(void)refresh:(NSNotification *)notification {
    
    BOOL *isLogin = [[Tool sharedInstance]  isLogIn];
    if (!isLogin) {
        return;
    }
    [self initLogin];
    
    
    
    
    
}



-(void) initLogin{
    _isLogin = [[Tool sharedInstance]  isLogIn];
    
    _hasInfo=false;
    _hasOrder=false;
    _tipInfo=@"请先登录后操作";
    if(_isLogin){
        _phoneNumber=[Utils  getStoreValue:STORE_PHONENUMBER];
        //_phoneNumber=@"18006810659";
        NSDictionary *paraInfo = [NSDictionary dictionaryWithObjectsAndKeys:_phoneNumber, @"PhoneNumber" ,nil];
        _HUD = [Utils createHUD];
        _HUD.labelText = @"";
        
        [[NetworkSingleton sharedManager] qmonthInfo:paraInfo   successBlock:^(id responseBody){
            [_HUD hide:YES];
             
            
            self.qmonthInfoRstModel= [QmonthInfoRstModel objectWithKeyValues:responseBody];
            if(self.qmonthInfoRstModel.respCode==0){
                _hasInfo=true;
                if(![self.qmonthInfoRstModel.NowStatus isEqualToString:@"已取消"])
                    _hasOrder=true;
                
                _hasOrder=true;
                
                _formTableView.reloadData;
                
            }else{
                _tipInfo=self.qmonthInfoRstModel.respInfo;
                _hasInfo=false;
                
                
            }
            
        } failureBlock:^(NSString *error){
            
            _HUD = [Utils createHUD];
            _HUD.mode = MBProgressHUDModeCustomView;
            _HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"HUD-error"]];
            _HUD.labelText =error;
            [_HUD hide:YES afterDelay:1.0];
        }];
        
        
    }
}
    




- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if(_hasOrder)
        return 2;
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0 &&  _hasInfo) {
        return 9;
    }
    return 1;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section==0)
        return 35.f;
   
    return 50.f;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier = @"cellIdentifier";
    
    UITableViewCell *cell =  [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier]   ;
    cell.imageView.image =nil;
    [cell   setBackgroundColor:_backColor];
    
    if (indexPath.section == 0 &&  _hasInfo){
        
        
        if (indexPath.row == 0) {
            
            [cell   setBackgroundColor:[UIColor whiteColor]];
            UILabel *label = [Utils labelWithFrame:CGRectMake(15.f, 5.f, screen_width-30, 21.f) withTitle:@"支付手机：" titleFontSize:[UIFont systemFontOfSize:13.f] textColor:[UIColor blackColor] backgroundColor:[UIColor clearColor] alignment:NSTextAlignmentLeft];
            
            
            NSString *labelText=[NSString stringWithFormat:@"支付手机：%@", _phoneNumber];
            NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:labelText ];
            
            
            [AttributedStr addAttribute:NSFontAttributeName
             
                                  value:[UIFont systemFontOfSize:15.0]
             
                                  range:NSMakeRange(5,  [labelText length]-5 )];
            
            [AttributedStr addAttribute:NSForegroundColorAttributeName
             
                                  value:RGB(10, 127, 229)
             
                                  range:NSMakeRange(5, [labelText length]-5 )];
            
            label.attributedText = AttributedStr;
            [cell addSubview:label];
            
            
            UIImageView *imageLine = [[UIImageView alloc]initWithFrame:CGRectMake(15, 30, screen_width-30, 1)];
            
            imageLine.image = PNGIMAGE(@"ll_line");
            [cell addSubview:imageLine];
            
        }
        if (indexPath.row == 1){
            
            [cell   setBackgroundColor:[UIColor whiteColor]];
            UILabel *label = [Utils labelWithFrame:CGRectMake(15.f, 5.f, screen_width-30, 21.f) withTitle:@"" titleFontSize:[UIFont systemFontOfSize:13.f] textColor:[UIColor blackColor] backgroundColor:[UIColor clearColor] alignment:NSTextAlignmentLeft];
            NSString *labelText=[NSString stringWithFormat:@"QQ号码：%@", self.qmonthInfoRstModel.TargetNumber];
            NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:labelText ];
            
            
            [AttributedStr addAttribute:NSFontAttributeName
             
                                  value:[UIFont systemFontOfSize:15.0]
             
                                  range:NSMakeRange(5,  [labelText length]-5 )];
            
            [AttributedStr addAttribute:NSForegroundColorAttributeName
             
                                  value:RGB(149, 149, 149)
             
                                  range:NSMakeRange(5, [labelText length]-5 )];
            
            label.attributedText = AttributedStr;
            [cell addSubview:label];
            
            
            UIImageView *imageLine = [[UIImageView alloc]initWithFrame:CGRectMake(15, 30, screen_width-30, 1)];
            
            imageLine.image = PNGIMAGE(@"ll_line");
            [cell addSubview:imageLine];
        }
        
        if (indexPath.row == 2){
            
            [cell   setBackgroundColor:[UIColor whiteColor]];
            UILabel *label = [Utils labelWithFrame:CGRectMake(15.f, 5.f, screen_width-30, 21.f) withTitle:@"" titleFontSize:[UIFont systemFontOfSize:13.f] textColor:[UIColor blackColor] backgroundColor:[UIColor clearColor] alignment:NSTextAlignmentLeft];
            NSString *labelText=[NSString stringWithFormat:@"包月面额：%@", self.qmonthInfoRstModel.Cost];
            NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:labelText ];
            
            
            [AttributedStr addAttribute:NSFontAttributeName
             
                                  value:[UIFont systemFontOfSize:15.0]
             
                                  range:NSMakeRange(5,  [labelText length]-5 )];
            
            [AttributedStr addAttribute:NSForegroundColorAttributeName
             
                                  value:RGB(149, 149, 149)
             
                                  range:NSMakeRange(5, [labelText length]-5 )];
            
            label.attributedText = AttributedStr;
            [cell addSubview:label];
            
            
            UIImageView *imageLine = [[UIImageView alloc]initWithFrame:CGRectMake(15, 30, screen_width-30, 1)];
            
            imageLine.image = PNGIMAGE(@"ll_line");
            [cell addSubview:imageLine];
        }
        if (indexPath.row == 3){
            
            [cell   setBackgroundColor:[UIColor whiteColor]];
            UILabel *label = [Utils labelWithFrame:CGRectMake(15.f, 5.f, screen_width-30, 21.f) withTitle:@"" titleFontSize:[UIFont systemFontOfSize:13.f] textColor:[UIColor blackColor] backgroundColor:[UIColor clearColor] alignment:NSTextAlignmentLeft];
            //NSLog(@"%@",self.qmonthInfoRstModel.PayMoney);
            
            self.qmonthInfoRstModel.PayMoney=[NSString stringWithFormat:@"%0.2f", [self.qmonthInfoRstModel.PayMoney floatValue]];
            NSString *labelText=[NSString stringWithFormat:@"支付金额：%@元",  self.qmonthInfoRstModel.PayMoney ];
            
           // %.2f
            NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:labelText ];
            
            
            [AttributedStr addAttribute:NSFontAttributeName
             
                                  value:[UIFont systemFontOfSize:15.0]
             
                                  range:NSMakeRange(5,  [labelText length]-5 )];
            
            [AttributedStr addAttribute:NSForegroundColorAttributeName
             
                                  value:RGB(149, 149, 149)
             
                                  range:NSMakeRange(5, [labelText length]-5 )];
            
            label.attributedText = AttributedStr;
            [cell addSubview:label];
            
            
            UIImageView *imageLine = [[UIImageView alloc]initWithFrame:CGRectMake(15, 30, screen_width-30, 1)];
            
            imageLine.image = PNGIMAGE(@"ll_line");
            [cell addSubview:imageLine];
        }
        
        if (indexPath.row ==4){
            
            [cell   setBackgroundColor:[UIColor whiteColor]];
            UILabel *label = [Utils labelWithFrame:CGRectMake(15.f, 5.f, screen_width-30, 21.f) withTitle:@"" titleFontSize:[UIFont systemFontOfSize:13.f] textColor:[UIColor blackColor] backgroundColor:[UIColor clearColor] alignment:NSTextAlignmentLeft];
            NSString *labelText=[NSString stringWithFormat:@"当前状态：%@", self.qmonthInfoRstModel.NowStatus];
            NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:labelText ];
            
            
            [AttributedStr addAttribute:NSFontAttributeName
             
                                  value:[UIFont systemFontOfSize:15.0]
             
                                  range:NSMakeRange(5,  [labelText length]-5 )];
            
            [AttributedStr addAttribute:NSForegroundColorAttributeName
             
                                  value:RGB(149, 149, 149)
             
                                  range:NSMakeRange(5, [labelText length]-5 )];
            
            label.attributedText = AttributedStr;
            [cell addSubview:label];
            
            
            UIImageView *imageLine = [[UIImageView alloc]initWithFrame:CGRectMake(15, 30, screen_width-30, 1)];
            
            imageLine.image = PNGIMAGE(@"ll_line");
            [cell addSubview:imageLine];
        }
        
        
        if (indexPath.row ==5){
            
            [cell   setBackgroundColor:[UIColor whiteColor]];
            UILabel *label = [Utils labelWithFrame:CGRectMake(15.f, 5.f, screen_width-30, 21.f) withTitle:@"" titleFontSize:[UIFont systemFontOfSize:13.f] textColor:[UIColor blackColor] backgroundColor:[UIColor clearColor] alignment:NSTextAlignmentLeft];
            NSString *labelText=[NSString stringWithFormat:@"当月扣费：%@",  self.qmonthInfoRstModel.thisMonth];
            NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:labelText ];
            
            
            [AttributedStr addAttribute:NSFontAttributeName
             
                                  value:[UIFont systemFontOfSize:15.0]
             
                                  range:NSMakeRange(5,  [labelText length]-5 )];
            
            [AttributedStr addAttribute:NSForegroundColorAttributeName
             
                                  value:RGB(149, 149, 149)
             
                                  range:NSMakeRange(5, [labelText length]-5 )];
            
            label.attributedText = AttributedStr;
            [cell addSubview:label];
            
            
            UIImageView *imageLine = [[UIImageView alloc]initWithFrame:CGRectMake(15, 30, screen_width-30, 1)];
            
            imageLine.image = PNGIMAGE(@"ll_line");
            [cell addSubview:imageLine];
        }
        
        
        if (indexPath.row ==6){
            
            [cell   setBackgroundColor:[UIColor whiteColor]];
            UILabel *label = [Utils labelWithFrame:CGRectMake(15.f, 5.f, screen_width-30, 21.f) withTitle:@"" titleFontSize:[UIFont systemFontOfSize:13.f] textColor:[UIColor blackColor] backgroundColor:[UIColor clearColor] alignment:NSTextAlignmentLeft];
            NSString *labelText=[NSString stringWithFormat:@"开通时间：%@", self.qmonthInfoRstModel.ApplyTime];
            NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:labelText ];
            
            
            [AttributedStr addAttribute:NSFontAttributeName
             
                                  value:[UIFont systemFontOfSize:15.0]
             
                                  range:NSMakeRange(5,  [labelText length]-5 )];
            
            [AttributedStr addAttribute:NSForegroundColorAttributeName
             
                                  value:RGB(149, 149, 149)
             
                                  range:NSMakeRange(5, [labelText length]-5 )];
            
            label.attributedText = AttributedStr;
            [cell addSubview:label];
            
            
            UIImageView *imageLine = [[UIImageView alloc]initWithFrame:CGRectMake(15, 30, screen_width-30, 1)];
            
            imageLine.image = PNGIMAGE(@"ll_line");
            [cell addSubview:imageLine];
        }
        if (indexPath.row ==7){
            
            [cell   setBackgroundColor:[UIColor whiteColor]];
            UILabel *label = [Utils labelWithFrame:CGRectMake(15.f, 5.f, screen_width-30, 21.f) withTitle:@"" titleFontSize:[UIFont systemFontOfSize:13.f] textColor:[UIColor blackColor] backgroundColor:[UIColor clearColor] alignment:NSTextAlignmentLeft];
            NSString *labelText=[NSString stringWithFormat:@"取消时间：%@", self.qmonthInfoRstModel.CancelTime];
            NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:labelText ];
            
            
            [AttributedStr addAttribute:NSFontAttributeName
             
                                  value:[UIFont systemFontOfSize:15.0]
             
                                  range:NSMakeRange(5,  [labelText length]-5 )];
            
            [AttributedStr addAttribute:NSForegroundColorAttributeName
             
                                  value:RGB(149, 149, 149)
             
                                  range:NSMakeRange(5, [labelText length]-5 )];
            
            label.attributedText = AttributedStr;
            [cell addSubview:label];
            
            
            UIImageView *imageLine = [[UIImageView alloc]initWithFrame:CGRectMake(15, 30, screen_width-30, 1)];
            
            imageLine.image = PNGIMAGE(@"ll_line");
            [cell addSubview:imageLine];
        }



        
        
        if (indexPath.row == 8){
            UIImageView *imageDown = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, screen_width, 20)];
            imageDown.image = PNGIMAGE(@"ll_bg_paper");
            [cell addSubview:imageDown];
        }
        
        
        
        
    }
    
    
    
    
    
    if (indexPath.section == 0 && !_isLogin){
        APRoundedButton *loginBtn = [APRoundedButton buttonWithType:UIButtonTypeCustom];
        loginBtn.frame = CGRectMake( 20.f, 0.f, screen_width-40, 40.f);
        [loginBtn addTarget:self action:@selector(loginBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [loginBtn setBackgroundImage:nil forState:UIControlStateNormal];
        [loginBtn setBackgroundColor:RGB(84, 188, 223)];
        
        [loginBtn setTitle:@"登录" forState:UIControlStateNormal];
        [loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        loginBtn.titleLabel.font = [UIFont systemFontOfSize:18.f];
        [loginBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
        loginBtn.style=10;
        [loginBtn awakeFromNib];
        [cell addSubview:loginBtn];
        
        
    }
    
    if (indexPath.section == 1 && _hasOrder){
        APRoundedButton *cancelBtn = [APRoundedButton buttonWithType:UIButtonTypeCustom];
        cancelBtn.frame = CGRectMake( 20.f, 0.f, screen_width-40, 40.f);
        [cancelBtn addTarget:self action:@selector(cancelBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [cancelBtn setBackgroundImage:nil forState:UIControlStateNormal];
        [cancelBtn setBackgroundColor:RGB(84, 188, 223)];
        
        [cancelBtn setTitle:@"取消包月" forState:UIControlStateNormal];
        [cancelBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        cancelBtn.titleLabel.font = [UIFont systemFontOfSize:18.f];
        [cancelBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
        cancelBtn.style=10;
        [cancelBtn awakeFromNib];
        [cell addSubview:cancelBtn];
        
        
    }
    
    
    
    
    
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    
    
    return nil;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0  && !_isLogin) {
        
        
        UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0.f, 0.f, screen_width, 80.f)];
        headerView.backgroundColor = [UIColor clearColor];
        UILabel *label = [Utils labelWithFrame:CGRectMake(15.f, (80-30)/2, screen_width-30, 30.f) withTitle:_tipInfo titleFontSize:[UIFont systemFontOfSize:18.f] textColor:RGB(10,127,229) backgroundColor:[UIColor clearColor] alignment:NSTextAlignmentCenter];
        label.tag=Tag_DiscountTip;
        [headerView addSubview:label];
        return  headerView ;
        
    }
    if (section == 0  && !_hasInfo) {
        
        
        UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0.f, 0.f, screen_width, 80.f)];
        headerView.backgroundColor = [UIColor clearColor];
        UILabel *label = [Utils labelWithFrame:CGRectMake(15.f, (80-30)/2, screen_width-30, 30.f) withTitle:_tipInfo titleFontSize:[UIFont systemFontOfSize:18.f] textColor:RGB(10,127,229) backgroundColor:[UIColor clearColor] alignment:NSTextAlignmentCenter];
        label.tag=Tag_DiscountTip;
        [headerView addSubview:label];
        return  headerView ;
        
    }
    
    
    
    
    
    return nil;
}


-(CGFloat)tableView:(UITableView*)tableView heightForHeaderInSection:(NSInteger)section
{
    
    if (section == 0 && !_isLogin) {
        return 80.f;
    }
    if (section == 0 && !_hasInfo) {
        return 80.f;
    }
    
    
    return 0.1;
}


-(CGFloat)tableView:(UITableView*)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 0) {
        return 5.f;
    }
    if (section == 1) {
        return 5.f;
    }
    if(section == 2){
        
        return 10.f;
        
    }
    
        return 21.f;
    
}

/*
-(UIView*)tableView:(UITableView*)tableView viewForHeaderInSection:(NSInteger)section
{
    return  [[UIView alloc] initWithFrame:CGRectZero]  ;
}*/





#pragma mark - RegisterBtnClicked Method
- (void)loginBtnClicked:(id)sender{
    
    
    
    [delegate  skipController:@"LoginController"];
    
    return;
    
}
- (void)cancelBtnClicked:(id)sender{
    
    self.appDelegate.phoneNumber= _phoneNumber;
    self.appDelegate.qqNumber = self.qmonthInfoRstModel.TargetNumber;
    self.appDelegate.qqCount=self.qmonthInfoRstModel.Cost;
    self.appDelegate.payMoney=self.qmonthInfoRstModel.PayMoney;
 
    
    [delegate  skipController:@"QmonthCancelConfirmController"];
    
    return;
    
}


/**
 *	@brief	验证文本框是否为空
 */


#pragma mark - UITextFieldDelegate Method

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    
    return YES;
}

#pragma mark - touchMethod
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    [super touchesBegan:touches withEvent:event];
    
    [self allEditActionsResignFirstResponder];
}

#pragma mark - PrivateMethod
- (void)allEditActionsResignFirstResponder{
    
    
    //用户名
   
    
    
    
}



/**
 *	@brief	键盘出现
 *
 *	@param 	aNotification 	参数
 */
- (void)keyboardWillShow:(NSNotification *)aNotification

{
    
    [UIView animateWithDuration:0.25 animations:^{
        
        self.view.frame = CGRectMake(0.f, -35.f, self.view.frame.size.width, self.view.frame.size.height);
        
    }completion:nil] ;
    
}

/**
 *	@brief	键盘消失
 *
 *	@param 	aNotification 	参数
 */
- (void)keyboardWillHide:(NSNotification *)aNotification

{
    [UIView animateWithDuration:0.25 animations:^{
        
        self.view.frame = CGRectMake(0.f, 0.f, self.view.frame.size.width, self.view.frame.size.height);
        
    }completion:nil];
    
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



@end


