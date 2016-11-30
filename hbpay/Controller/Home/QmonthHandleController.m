
#import "QmonthHandleController.h" 



@interface QmonthHandleController ()
enum TAG_FORM_TEXTFIELD{
    
    
    Tag_QQNumberTextField =21,        //用户名
    Tag_QQImageView10 ,
    Tag_QQImageView20 ,
    Tag_QQImageView30 ,
    Tag_QQImageView50 ,
    Tag_DiscountTip
    
};

@end

@implementation QmonthHandleController

@synthesize delegate;

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    self.appDelegate = [[UIApplication sharedApplication] delegate];
    
    
    _formTableView = [[UITableView alloc] initWithFrame:CGRectMake(0.f, 0.f, screen_width, screen_height) style:UITableViewStyleGrouped];
    _formTableView.allowsSelection = NO;
    _formTableView.delegate = self;
    _formTableView.dataSource = self;
    _formTableView.separatorStyle = NO;
    _backColor=_formTableView.backgroundColor;
    
    
    
    
    [self.view addSubview:_formTableView];
    UITapGestureRecognizer *hideKeyboardRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(allEditActionsResignFirstResponder)];
    [_formTableView addGestureRecognizer:hideKeyboardRecognizer];
    hideKeyboardRecognizer.cancelsTouchesInView = NO;
    
    
    NSDictionary *paraInfo = [NSDictionary dictionaryWithObjectsAndKeys:[Utils getStoreValue:STORE_PHONENUMBER], @"PhoneNumber", QMONTHBUSID, @"BusId", [Utils getStoreValue:STORE_QQNUMBER], @"TargetNumber",nil];
    
    
    _HUD = [Utils createHUD];
    _HUD.labelText = @"";
    
    [[NetworkSingleton sharedManager] userRebate:paraInfo   successBlock:^(id responseBody){
        
        
        [_HUD hide:YES];
        
        _rebateRstModel = [RebateRstModel objectWithKeyValues:responseBody];
        RebateModel *rebateModel;
        NSMutableArray *nsma =  [_rebateRstModel.productRebateList mutableCopy];
        
        for (int i = 0; i < _rebateRstModel.productRebateList.count; i++) {
            
            rebateModel= [RebateModel objectWithKeyValues:_rebateRstModel.productRebateList[i]];
            
            [nsma replaceObjectAtIndex:i withObject:rebateModel];
        }
        _rebateRstModel.productRebateList = [nsma copy];
        rebateModel=[self getProductRebate:@"1605003"];
        [(OptionPotView *)[self.view viewWithTag:Tag_QQImageView10] setPotDiscount:rebateModel.PayTip];
        rebateModel=[self getProductRebate:@"1605004"];
        [(OptionPotView *)[self.view viewWithTag:Tag_QQImageView20] setPotDiscount:rebateModel.PayTip];
        rebateModel=[self getProductRebate:@"1605001"];
        [(OptionPotView *)[self.view viewWithTag:Tag_QQImageView30] setPotDiscount:rebateModel.PayTip];
        
        rebateModel=[self getProductRebate:@"1605002"];
        [(OptionPotView *)[self.view viewWithTag:Tag_QQImageView50] setPotDiscount:rebateModel.PayTip];
        
        
        
        
    } failureBlock:^(NSString *error){
        
        _HUD = [Utils createHUD];
        _HUD.mode = MBProgressHUDModeCustomView;
        _HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"HUD-error"]];
        _HUD.labelText =error;
        [_HUD hide:YES afterDelay:1.0];
    }];
    
    
    
    
    
    
    
    
}

-(RebateModel *) getProductRebate:(NSString *)productId {
    
    RebateModel *rebateModel=nil;
    for (int i = 0; i < _rebateRstModel.productRebateList.count; i++) {
        
        rebateModel=_rebateRstModel.productRebateList[i];
        if([rebateModel.ProductId isEqualToString:productId]  )
            return rebateModel;
        
    }
    return rebateModel;
    
    
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    //if (section == 2) {
    return 1;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier = @"cellIdentifier";
    
    UITableViewCell *cell =  [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier]   ;
    
    
    cell.imageView.image =nil;
    
    
    [cell   setBackgroundColor:_backColor];
    if (indexPath.section == 0){
        
        JYTextField *textField = [[JYTextField alloc]initWithFrame:CGRectMake(10.f, 3.f, screen_width-20, 38.f)
                                                       cornerRadio:5
                                                       borderColor:RGB(166, 166, 166)
                                                       borderWidth:1
                                                        lightColor:RGB(55, 154, 255)
                                                         lightSize:8
                                                  lightBorderColor:RGB(235, 235, 235)];
        [textField setClearButtonMode:UITextFieldViewModeWhileEditing];
        [textField setPlaceholder:@"QQ号码,必填"];
        textField.tag = Tag_QQNumberTextField;
        textField.returnKeyType = UIReturnKeyDone;
        textField.delegate = self;
        textField.keyboardType = UIKeyboardTypeNumberPad;
        textField.returnKeyType = UIReturnKeyDone;
        textField.text=[Utils getStoreValue:STORE_QQNUMBER];
        [cell addSubview:textField];
        
        
    }
    
    
    
    //[_chargeIcon setUserInteractionEnabled:YES];
    
    if (indexPath.section == 1){
        [UIColor clearColor];
        
        UITapGestureRecognizer *tapGesture   = [[UITapGestureRecognizer alloc] initWithTarget:self  action:@selector(clickCategory:)];
        tapGesture.numberOfTouchesRequired = 1; //手指数
        tapGesture.numberOfTapsRequired = 1; //tap次数
        
        OptionPotModel *optionPotModel=[OptionPotModel alloc];
        optionPotModel.optionId=@"10";
        optionPotModel.optionTitle=@"Q 10";
        optionPotModel.optionDiscout=@"";
        optionPotModel.optionSelected=false;
        
        
        
        OptionPotView *optionPotView=[[OptionPotView alloc] initWithFrame:CGRectMake(30.f, 2.f,  screen_width/2-60, 40.f) optionPot: optionPotModel];
        optionPotView.tag = Tag_QQImageView10;
        [optionPotView addGestureRecognizer:tapGesture];
        
        [cell addSubview:optionPotView];
        
        
        tapGesture   = [[UITapGestureRecognizer alloc] initWithTarget:self  action:@selector(clickCategory:)];
        tapGesture.numberOfTouchesRequired = 1; //手指数
        tapGesture.numberOfTapsRequired = 1;
        
        optionPotModel=[OptionPotModel alloc];
        optionPotModel.optionId=@"20";
        optionPotModel.optionTitle=@"Q 20";
        optionPotModel.optionDiscout=@"";
        optionPotModel.optionSelected=false;
        
        
        
        optionPotView=[[OptionPotView alloc] initWithFrame:CGRectMake(screen_width/2+30.f, 2.f,  screen_width/2-60, 40.f) optionPot: optionPotModel];
        optionPotView.tag = Tag_QQImageView20;
        [optionPotView addGestureRecognizer:tapGesture];
        
        [cell addSubview:optionPotView];
        
    }
    
    
    if (indexPath.section == 2){
        [UIColor clearColor];
        
        UITapGestureRecognizer *tapGesture   = [[UITapGestureRecognizer alloc] initWithTarget:self  action:@selector(clickCategory:)];
        tapGesture.numberOfTouchesRequired = 1; //手指数
        tapGesture.numberOfTapsRequired = 1;
        
        OptionPotModel *optionPotModel=[OptionPotModel alloc];
        optionPotModel.optionId=@"30";
        optionPotModel.optionTitle=@"Q 30";
        optionPotModel.optionDiscout=@"";
        optionPotModel.optionSelected=false;
        
        
        
        OptionPotView *optionPotView=[[OptionPotView alloc] initWithFrame:CGRectMake(30.f, 2.f,  screen_width/2-60, 40.f) optionPot: optionPotModel];
        optionPotView.tag = Tag_QQImageView30;
        [optionPotView addGestureRecognizer:tapGesture];
        [cell addSubview:optionPotView];
        
        tapGesture   = [[UITapGestureRecognizer alloc] initWithTarget:self  action:@selector(clickCategory:)];
        tapGesture.numberOfTouchesRequired = 1; //手指数
        tapGesture.numberOfTapsRequired = 1;
        
        optionPotModel=[OptionPotModel alloc];
        optionPotModel.optionId=@"50";
        optionPotModel.optionTitle=@"Q 50";
        optionPotModel.optionDiscout=@"";
        optionPotModel.optionSelected=false;
        
        
        
        optionPotView=[[OptionPotView alloc] initWithFrame:CGRectMake(screen_width/2+30.f, 2.f,  screen_width/2-60, 40.f) optionPot: optionPotModel];
        optionPotView.tag = Tag_QQImageView50;
        [optionPotView addGestureRecognizer:tapGesture];
        
        [cell addSubview:optionPotView];
        
    }
    
    if (indexPath.section == 3){
        
        APRoundedButton *nextBtn = [APRoundedButton buttonWithType:UIButtonTypeCustom];
        nextBtn.frame = CGRectMake( 20.f, 0.f, screen_width-40, 40.f);
        [nextBtn addTarget:self action:@selector(nextBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [nextBtn setBackgroundImage:nil forState:UIControlStateNormal];
        [nextBtn   setBackgroundColor:RGB(84,188,223)];
        //[registerBtn   forState:UIControlStateNormal];
        //backgroundColor
        [nextBtn setTitle:@"下一步" forState:UIControlStateNormal];
        [nextBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        nextBtn.titleLabel.font = [UIFont systemFontOfSize:18.f];
        [nextBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
        nextBtn.style=10;
        [nextBtn awakeFromNib];
        NSString *phoneNumber=[Utils getStoreValue:STORE_PHONENUMBER];
        if(  ![phoneNumber isEqualToString:@"18158171080"])
        [cell addSubview:nextBtn];
    }
    return cell;
}

#pragma mark - UITableViewDelegate
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (section == 0) {
        
        
        UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0.f, 4.f, 320.f, 21.f)];
        footerView.backgroundColor = [UIColor clearColor];
        UILabel *label = [Utils labelWithFrame:CGRectMake(15.f, 0.f, 300.f, 21.f) withTitle:@"请选择充值面额" titleFontSize:[UIFont systemFontOfSize:12.f] textColor:RGB(149, 149, 149) backgroundColor:[UIColor clearColor] alignment:NSTextAlignmentLeft];
        
        
        
        label.tag=Tag_DiscountTip;
        
        [footerView addSubview:label];
        
        return  footerView ;
        
    }
    
    
    
    if (section == 3){
        UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0.f, 0.f, screen_width, 21.f)];
        footerView.backgroundColor = [UIColor clearColor];
        
        UILabel *payTipHeadLabel = [Utils labelWithFrame:CGRectMake(15.f, 15.f, screen_width-30, 21.f) withTitle:@"温馨提示：" titleFontSize:[UIFont systemFontOfSize:15.f] textColor:RGB(149, 149, 149) backgroundColor:[UIColor clearColor] alignment:NSTextAlignmentLeft];
        
        
        
        [footerView addSubview:payTipHeadLabel];
        
        
        NSString *payTip=[Utils getStoreValue:STORE_QMONTHPAYTIP];
        if([payTip isEqualToString:@""]){
            payTip=@"单个手机号码Q币充值日限60元，月限200元，与拨打168声讯电话累计。";
        }
        payTip=[NSString stringWithFormat:@"       %@",    payTip];
        
        CGSize size = [payTip sizeWithFont:[UIFont systemFontOfSize:13] constrainedToSize:CGSizeMake(screen_width-30,10000.0f)lineBreakMode:NSLineBreakByCharWrapping];
        
        
        
        
        UILabel *payTipLabel = [Utils labelWithFrame:CGRectMake(15.f, 40.f, size.width, size.height ) withTitle:payTip titleFontSize:[UIFont systemFontOfSize:13.f] textColor:RGB(149, 149, 149) backgroundColor:[UIColor clearColor] alignment:NSTextAlignmentLeft];
        payTipLabel.numberOfLines=0;
        
        
        [footerView addSubview:payTipLabel];
        
        
        
        return  footerView ;
        
    }
    return nil;
}

-(CGFloat)tableView:(UITableView*)tableView heightForHeaderInSection:(NSInteger)section
{
    return 5.0;
}


-(CGFloat)tableView:(UITableView*)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 0) {
        return 25.f;
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

#pragma mark - RegisterBtnClicked Method
- (void)nextBtnClicked:(id)sender{ 
    
    BOOL *isLogin = [[Tool sharedInstance]  isLogIn];
    if(!isLogin){
        
        [delegate  skipController:@"LoginController"];
        
        return;
    }
   
    
    
   
        
    

    
    NSString *qqNumber,*phoneNumber;
    phoneNumber=[Utils getStoreValue:STORE_PHONENUMBER];
    _productId=[Utils trim:_productId];
    
    qqNumber=[(UITextField *)[self.view viewWithTag:Tag_QQNumberTextField] text];
    qqNumber=[Utils trim:qqNumber];
    
    if ( [qqNumber length]<6) {
        
        [Utils alertTitle:@"提示" message:@"请输入正确的QQ号码" delegate:self cancelBtn:@"取消" otherBtnName:nil];
        
        return  ;
    }
    
    if([_productId isEqualToString:@""]){
        [Utils alertTitle:@"提示" message:@"请选择包月Q币个数" delegate:self cancelBtn:@"取消" otherBtnName:nil];
        
        return  ;
    }
    
    self.appDelegate.phoneNumber=phoneNumber;
    self.appDelegate.qqNumber = qqNumber;
    self.appDelegate.qqCount=_qqCount;
    self.appDelegate.payMoney=_payMoney;
    self.appDelegate.productId=_productId;
    
    [delegate  skipController:@"QmonthHandleConfirmController"];
    
 
    
    
}

/**
 *	@brief	验证文本框是否为空
 */


#pragma mark - UITextFieldDelegate Method

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    
    switch (textField.tag) {
            
      
        case Tag_QQNumberTextField:
        {
            if ([textField text] != nil && [[textField text] length]!= 0) {
                
                if ([[textField text] length] < 6) {
                    
                    [Utils alertTitle:@"提示" message:@"QQ账号小于6位！" delegate:nil cancelBtn:@"取消" otherBtnName:nil];
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
    
   
    [[self.view viewWithTag:Tag_QQNumberTextField] resignFirstResponder];
    
    
    
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




-(void)clickCategory:(UITapGestureRecognizer *)gestureRecognizer
{
    
    
     UIView *viewClicked=[gestureRecognizer view];
    
    [(OptionPotView *)[self.view viewWithTag:Tag_QQImageView10] setPotSelect:false];
    [(OptionPotView *)[self.view viewWithTag:Tag_QQImageView20] setPotSelect:false];
    [(OptionPotView *)[self.view viewWithTag:Tag_QQImageView30] setPotSelect:false];
    [(OptionPotView *)[self.view viewWithTag:Tag_QQImageView50] setPotSelect:false];
    
    
    [(OptionPotView *)viewClicked setPotSelect:true];
    RebateModel *rebateModel;
    NSMutableAttributedString *AttributedStr;
    NSString *discountTip;
    if (viewClicked.tag ==Tag_QQImageView10) {
        _productId=@"1605003";
        
    }
    if (viewClicked.tag ==Tag_QQImageView20) {
        _productId=@"1605004";
    }
    if (viewClicked.tag ==Tag_QQImageView30) {
        _productId=@"1605001";
    }
    if (viewClicked.tag ==Tag_QQImageView50) {
        _productId=@"1605002";
    }
    
    
    rebateModel=[self getProductRebate:_productId];
    _qqCount=[Utils trim:rebateModel.Denomination];
    _payMoney=[Utils trim:rebateModel.PayMoney];
    
    
    
    discountTip=[NSString stringWithFormat:@"充值%@个Q币 实付金额%@元", _qqCount,_payMoney];
    AttributedStr = [[NSMutableAttributedString alloc]initWithString:discountTip ];
    
    
    [AttributedStr addAttribute:NSFontAttributeName
     
                          value:[UIFont systemFontOfSize:14.0]
     
                          range:NSMakeRange(8,  [discountTip length]-8 )];
    
    [AttributedStr addAttribute:NSForegroundColorAttributeName
     
                          value:[UIColor blueColor]
     
                          range:NSMakeRange(8, [discountTip length]-8 )];
    
    ((UILabel *)[self.view viewWithTag:Tag_DiscountTip]).attributedText = AttributedStr;
    
    
}



@end

