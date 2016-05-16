#import "QmonthCancelConfirmController.h"
#import "PlaceholderTextView.h"
#import "AppDelegate.h"
#import "MBProgressHUD.h"
#import "Utils.h"
#import "Public.h"
#import "Constant.h"
#import "TitleView.h"
#import "SMSCodeRstModel.h"
#import "APRoundedButton.h"
#import "NetworkSingleton.h"
#import "FindController.h"
#import "JYTextField.h"
#import "CancelMonthOrderRstModel.h"
#import "Tool.h"
#import "QmonthCancelRstModel.h"
#import "QmonthCancelSuccessController.h"
@interface QmonthCancelConfirmController ()<UITableViewDataSource,UITableViewDelegate ,UITextFieldDelegate,UIAlertViewDelegate>

@property (nonatomic, strong) MBProgressHUD       *HUD;
@property (nonatomic,retain)  TitleView *titleView;
@property (nonatomic,retain)  UILabel *topLabel;
@property (nonatomic,retain)  UIColor *backColor;
@property (nonatomic,strong)  UITableView *formTableView;


@property (nonatomic,strong)  NSString *qqCount;
@property (nonatomic,strong)  NSString *payMoney;
@property (nonatomic,strong)  NSString *phoneNumber;
@property (nonatomic,strong)  NSString *qqNumber;
@property  AppDelegate *appDelegate;
#pragma mark Register TextField Tag enum
enum TAG_FORM_TEXTFIELD{
 
    Tag_VerifyTextField =20,
    Tag_DiscountTip
    
};


@end
@implementation QmonthCancelConfirmController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    self.appDelegate = [[UIApplication sharedApplication] delegate];
    
    _phoneNumber=[Utils trim:self.appDelegate.phoneNumber];
    _qqNumber=[Utils trim:self.appDelegate.qqNumber];
    _qqCount=[Utils trim:self.appDelegate.qqCount];
    _payMoney=[Utils trim:self.appDelegate.payMoney];

    
    UIButton *backBtn = [UIButton buttonWithType: UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, (title_height+20-40)/2, 40, 40);
    [backBtn setImage:[UIImage imageNamed:@"tital_back"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(OnTapBackBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    _titleView = [[TitleView alloc] initWithFrame:@"Q币包月" leftMenuItem:backBtn rightMenuItem:nil ];
    [self.view addSubview:_titleView];
    
    
    _formTableView = [[UITableView alloc] initWithFrame:CGRectMake(0.f, H(_titleView), screen_width, screen_height) style:UITableViewStyleGrouped];
    _formTableView.allowsSelection = NO;
    _formTableView.delegate = self;
    _formTableView.dataSource = self;
    _formTableView.separatorStyle = NO;
    _backColor=_formTableView.backgroundColor;
    
    
    
    
    [self.view addSubview:_formTableView];
    UITapGestureRecognizer *hideKeyboardRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(allEditActionsResignFirstResponder)];
    [_formTableView addGestureRecognizer:hideKeyboardRecognizer];
    hideKeyboardRecognizer.cancelsTouchesInView = NO;
    
}




- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 5;
    }
    return 1;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section==0)
        return 35.f;
    if(indexPath.section==2)
        return 140.f;
    return 50.f;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier = @"cellIdentifier";
    
    UITableViewCell *cell =  [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier]   ;
    
    
    cell.imageView.image =nil;
    
    
    [cell   setBackgroundColor:_backColor];
    if (indexPath.section == 0){
        
        
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
            NSString *labelText=[NSString stringWithFormat:@"QQ号码：%@", _qqNumber];
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
            NSString *labelText=[NSString stringWithFormat:@"包月面额：%@", _qqCount];
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
            NSString *labelText=[NSString stringWithFormat:@"支付金额：%@元", _payMoney];
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
        if (indexPath.row == 4){
            UIImageView *imageDown = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, screen_width, 20)];
            imageDown.image = PNGIMAGE(@"ll_bg_paper");
            [cell addSubview:imageDown];
        }
        
        
        
        
    }
    
    
    
    
    
    if (indexPath.section == 1){
        APRoundedButton *verifyBtn = [APRoundedButton buttonWithType:UIButtonTypeCustom];
        verifyBtn.frame = CGRectMake( 20.f, 0.f, screen_width-40, 40.f);
        [verifyBtn addTarget:self action:@selector(verifyBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [verifyBtn setBackgroundImage:nil forState:UIControlStateNormal];
        [verifyBtn   setBackgroundColor:RGB(84, 188, 223)];
        
        [verifyBtn setTitle:@"点击获取短信验证码" forState:UIControlStateNormal];
        [verifyBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        verifyBtn.titleLabel.font = [UIFont systemFontOfSize:18.f];
        [verifyBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
        verifyBtn.style=10;
        [verifyBtn awakeFromNib];
        [cell addSubview:verifyBtn];
        
        
    }
    
    
    if (indexPath.section == 2){
        
        
        UIImageView *imageUp = [[UIImageView alloc]initWithFrame:CGRectMake(15, 0, screen_width-30, 20)];
        imageUp.image = PNGIMAGE(@"ll_bg_conu");
        [cell addSubview:imageUp];
        
        UIImageView *imageMiddle = [[UIImageView alloc]initWithFrame:CGRectMake(17, 20, screen_width-33, 100)];
        imageMiddle.image = PNGIMAGE(@"ll_bg_conm");
        [cell addSubview:imageMiddle];
        
        
        UIImageView *imageDown = [[UIImageView alloc]initWithFrame:CGRectMake(18, 120, screen_width-34, 20)];
        imageDown.image = PNGIMAGE(@"ll_bg_cond");
        [cell addSubview:imageDown];
        
        
        JYTextField *textField = [[JYTextField alloc]initWithFrame:CGRectMake(30.f, 23.f, screen_width-60, 38.f)
                                                       cornerRadio:5
                                                       borderColor:RGB(166, 166, 166)
                                                       borderWidth:1
                                                        lightColor:RGB(55, 154, 255)
                                                         lightSize:8
                                                  lightBorderColor:RGB(235, 235, 235)];
        [textField setClearButtonMode:UITextFieldViewModeWhileEditing];
        [textField setPlaceholder:@"验证码,必填"];
        textField.tag = Tag_VerifyTextField;
        textField.returnKeyType = UIReturnKeyDone;
        textField.delegate = self;
        textField.keyboardType = UIKeyboardTypeNumberPad;
        textField.returnKeyType = UIReturnKeyDone;
        [cell addSubview:textField];
        
        
        
        APRoundedButton *confirmBtn = [APRoundedButton buttonWithType:UIButtonTypeCustom];
        confirmBtn.frame = CGRectMake( 30.f, 80.f, screen_width/2-40, 38.f);
        [confirmBtn addTarget:self action:@selector(nextBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [confirmBtn setBackgroundImage:nil forState:UIControlStateNormal];
        [confirmBtn   setBackgroundColor:RGB(84, 188, 223)];
        
        [confirmBtn setTitle:@"取消包月" forState:UIControlStateNormal];
        [confirmBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        confirmBtn.titleLabel.font = [UIFont systemFontOfSize:18.f];
        [confirmBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
        confirmBtn.style=10;
        [confirmBtn awakeFromNib];
        
        
        [cell addSubview:confirmBtn];
        
        
        APRoundedButton *cancelBtn = [APRoundedButton buttonWithType:UIButtonTypeCustom];
        cancelBtn.frame = CGRectMake( screen_width/2+10.f, 80.f, screen_width/2-40, 38.f);
        [cancelBtn addTarget:self action:@selector(cancelBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [cancelBtn setBackgroundImage:nil forState:UIControlStateNormal];
        [cancelBtn   setBackgroundColor:RGB(216, 225, 232)];
        
        [cancelBtn setTitle:@"暂不取消" forState:UIControlStateNormal];
        [cancelBtn setTitleColor:RGB(149, 149, 149) forState:UIControlStateNormal];
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

-(CGFloat)tableView:(UITableView*)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.1;
}


-(CGFloat)tableView:(UITableView*)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 0) {
        return 5.f;
    }
    if (section == 1) {
        return 1.f;
    }
    if(section == 2){
        
        return 10.f;
        
    }
    if(section == 3){
        
        return 50.f;
        
    }else{
        return 21.f;
    }
}

-(UIView*)tableView:(UITableView*)tableView viewForHeaderInSection:(NSInteger)section
{
    return  [[UIView alloc] initWithFrame:CGRectZero]  ;
}





 

/**
 *	@brief	验证文本框是否为空
 */


#pragma mark - UITextFieldDelegate Method

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    
    switch (textField.tag) {
            
            
        case Tag_VerifyTextField:
        {
            if ([textField text] != nil && [[textField text] length]!= 0) {
                
                if ([[textField text] length] < 6) {
                    
                    [Utils alertTitle:@"提示" message:@"验证码小于6位！" delegate:nil cancelBtn:@"取消" otherBtnName:nil];
                }
            }
        }
            break;
            
        default:
            break;
    }
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
    [[self.view viewWithTag:Tag_VerifyTextField] resignFirstResponder];
    
    
    
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

- (void)verifyBtnClicked:(id)sender{
    
    
    UIButton *btn = (UIButton *)sender;
    
    
    NSDictionary *paraInfo = [NSDictionary dictionaryWithObjectsAndKeys:_phoneNumber, @"PhoneNumber", @"cancelQQPerMonth", @"MessageType",nil];
    _HUD = [Utils createHUD];
    _HUD.labelText = @"";
    
    [[NetworkSingleton sharedManager] getSMSCode:paraInfo   successBlock:^(id responseBody){
        [_HUD hide:YES];
        SMSCodeRstModel *smsCodeRstModel = [SMSCodeRstModel objectWithKeyValues:responseBody];
        if(smsCodeRstModel.respCode==0){
            [self startTime:btn];
            
        }else{
            [Utils alertTitle:@"提示" message:smsCodeRstModel.respInfo delegate:self cancelBtn:@"确定" otherBtnName:nil];
            
        }
        
    } failureBlock:^(NSString *error){
        
        _HUD = [Utils createHUD];
        _HUD.mode = MBProgressHUDModeCustomView;
        _HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"HUD-error"]];
        _HUD.labelText =error;
        [_HUD hide:YES afterDelay:1.0];
    }];
    
    
}
- (void)startTime:(UIButton *)btn{
    __block int timeout=60; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout<=0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                [btn  setAttributedTitle:nil forState:UIControlStateNormal];
                [btn setTitle:@"点击获取短信验证码" forState:UIControlStateNormal];
                [btn  setBackgroundColor:RGB(84, 188, 223)];
                [btn  setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                btn.userInteractionEnabled = YES;
            });
        }else{
            int seconds = timeout % 100;
            
            NSString *strTime = [NSString stringWithFormat:@"%d", seconds];
            NSString *remainTip=[NSString stringWithFormat:@"还剩下%@秒可重新发送",strTime];
            NSMutableAttributedString *AttributedStr= [[NSMutableAttributedString alloc]initWithString:remainTip ];
            dispatch_async(dispatch_get_main_queue(), ^{
                [AttributedStr addAttribute:NSFontAttributeName
                                      value:[UIFont systemFontOfSize:16.0]
                                      range:NSMakeRange(0,  [remainTip length] )];
                [AttributedStr addAttribute:NSFontAttributeName
                                      value:[UIFont systemFontOfSize:20.0]
                                      range:NSMakeRange(3,  [strTime length]  )];
                [AttributedStr addAttribute:NSForegroundColorAttributeName
                                      value:RGB(63,70,70)
                                      range:NSMakeRange(0,  [remainTip length])];
                
                [AttributedStr addAttribute:NSForegroundColorAttributeName
                                      value:RGB(84,188,222)
                                      range:NSMakeRange(3,  [strTime length]+1  )];
                
                // [btn  setTitleColor:RGB(63,70,70) forState:UIControlStateNormal];
                [btn  setAttributedTitle:AttributedStr forState:UIControlStateNormal];
                
                
                [btn  setBackgroundColor:RGB(216,225,231)];
                
                btn.userInteractionEnabled = NO;
                
            });
            timeout--;
            
        }
    });
    dispatch_resume(_timer);
}
-(void) cancelBtnClicked:(id)sender{
    
    
    [self.navigationController popToRootViewControllerAnimated:YES];
    
}
-(void) nextBtnClicked:(id)sender{
    
    
    NSString *smsCode=[(UITextField *)[self.view viewWithTag:Tag_VerifyTextField] text];
    smsCode=[Utils trim:smsCode];
    if([smsCode length]!=6){
        [Utils alertTitle:@"提示" message:@"请输入六位短信验证码" delegate:self cancelBtn:@"取消" otherBtnName:nil];
        return ;
        
    }
    
    [Utils alertTitle:@"确定取消包月" message:[NSString stringWithFormat:@"您确定对QQ号码为%@进行取消包月?",_qqNumber] delegate:self cancelBtn:@"确认" otherBtnName:@"取消"];
    
    
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString *btnTitle = [alertView buttonTitleAtIndex:buttonIndex];
    if ([btnTitle isEqualToString:@"确认"]) {
        
        [self takeOrder];
        
    }
}
-(void) takeOrder{
    NSString *smsCode=[(UITextField *)[self.view viewWithTag:Tag_VerifyTextField] text];
    smsCode=[Utils trim:smsCode];
    
    
    
    
    NSDictionary *paraInfo = [NSDictionary dictionaryWithObjectsAndKeys:_phoneNumber, @"PhoneNumber", smsCode, @"SmsValiCode" ,nil];
    _HUD = [Utils createHUD];
    _HUD.labelText = @"";
    
    [[NetworkSingleton sharedManager] cancelMonthOrder:paraInfo   successBlock:^(id responseBody){
        
        CancelMonthOrderRstModel *cancelMonthOrderRstModel = [CancelMonthOrderRstModel objectWithKeyValues:responseBody];
        if(cancelMonthOrderRstModel.respCode==0){
            
            
            [self gotoPay:cancelMonthOrderRstModel.Cost];
            
        }else{
            [_HUD hide:YES];
            [Utils alertTitle:@"提示" message:cancelMonthOrderRstModel.respInfo delegate:self cancelBtn:@"确定" otherBtnName:nil];
            
        }
        
    } failureBlock:^(NSString *error){
        
        _HUD = [Utils createHUD];
        _HUD.mode = MBProgressHUDModeCustomView;
        _HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"HUD-error"]];
        _HUD.labelText =error;
        [_HUD hide:YES afterDelay:1.0];
    }];
    
    
}

-(void)gotoPay:(NSString *)cost{ 
    cost=[Utils trim:cost];
    NSDictionary *paraInfo = [NSDictionary dictionaryWithObjectsAndKeys:_phoneNumber, @"PhoneNumber",
                              _qqNumber, @"TargetNumber",
                              cost, @"Cost", nil];
    
    
    [[NetworkSingleton sharedManager] cancelMonthPay:paraInfo   successBlock:^(id responseBody){
        
        [_HUD hide:YES];
        
        QmonthCancelRstModel *qmonthCancelRstModel = [QmonthCancelRstModel objectWithKeyValues:responseBody];
        
        
        
        if(qmonthCancelRstModel.respCode==0){
            
             QmonthCancelSuccessController  *qmonthCancelSuccessController=[[ QmonthCancelSuccessController alloc]init];
            qmonthCancelSuccessController.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:qmonthCancelSuccessController animated:YES];
            
        }else{
            [Utils alertTitle:@"提示" message:qmonthCancelRstModel.respInfo delegate:self cancelBtn:@"确定" otherBtnName:nil];
            
        }
        
        
    } failureBlock:^(NSString *error){
        
        _HUD = [Utils createHUD];
        _HUD.mode = MBProgressHUDModeCustomView;
        _HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"HUD-error"]];
        _HUD.labelText =error;
        [_HUD hide:YES afterDelay:1.0];
    }];
    
    
}






@end

