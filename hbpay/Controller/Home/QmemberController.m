#import "QmemberController.h"
#import "CZPicker.h"
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
#import "RebateModel.h"
#import "RebateRstModel.h"
#import "Tool.h"
#import "LoginController.h"

#import "QmemberTypeModel.h"
#import "QmemberConfirmController.h"
@interface QmemberController ()<UITableViewDataSource,UITableViewDelegate ,UITextFieldDelegate,CZPickerViewDataSource, CZPickerViewDelegate>

@property (nonatomic, strong) MBProgressHUD       *HUD;
@property (nonatomic,retain)  TitleView *titleView;
@property (nonatomic,retain)  UILabel *topLabel;
@property (nonatomic,retain)  UIColor *backColor;
@property (nonatomic,strong)  UITableView *formTableView;
@property NSArray *qmemberTypeArr;
@property  AppDelegate *appDelegate;


@property (nonatomic,strong)  QmemberTypeModel *qmemberTypeModel;
@property (nonatomic,strong)  RebateRstModel *rebateRstModel;
@property (nonatomic,strong)  NSString *productId;
@property (nonatomic,strong)  NSString *qqMemberTypeName;
@property (nonatomic,strong)  NSString *qqMonth;
@property (nonatomic,strong)  NSString *payMoney;




#pragma mark Register TextField Tag enum
enum TAG_FORM_TEXTFIELD{
    
    
    Tag_QQNumberTextField =20,        //用户名
    Tag_QQImageView10 ,
    Tag_QQImageView20 ,
    Tag_QQImageView30 ,
    Tag_QQmemberButton,
    Tag_DiscountTip
    
};


@end
@implementation QmemberController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    self.appDelegate = [[UIApplication sharedApplication] delegate];
    
    UIButton *backBtn = [UIButton buttonWithType: UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, (title_height+20-40)/2, 40, 40);
    [backBtn setImage:[UIImage imageNamed:@"tital_back"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(OnTapBackBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    
    //@"QQ会员"
    _titleView = [[TitleView alloc] initWithFrame:self.appDelegate.titleName leftMenuItem:backBtn rightMenuItem:nil ];
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
    
    
    NSDictionary *paraInfo = [NSDictionary dictionaryWithObjectsAndKeys:[Utils getStoreValue:STORE_PHONENUMBER], @"PhoneNumber", QMEMBERBUSID, @"BusId", [Utils getStoreValue:STORE_QQNUMBER], @"TargetNumber",nil];
    
    
    _HUD = [Utils createHUD];
    _HUD.labelText = @"";
    
    [[NetworkSingleton sharedManager] userRebate:paraInfo   successBlock:^(id responseBody){
        
        
        [_HUD hide:YES];
        
        
        // NSLog(@"%@",responseBody);
        
        _rebateRstModel = [RebateRstModel objectWithKeyValues:responseBody];
        RebateModel *rebateModel;
        NSMutableArray *nsma =  [_rebateRstModel.productRebateList mutableCopy];
        
        for (int i = 0; i < _rebateRstModel.productRebateList.count; i++) {
            
            rebateModel= [RebateModel objectWithKeyValues:_rebateRstModel.productRebateList[i]];
            
            [nsma replaceObjectAtIndex:i withObject:rebateModel];
        }
        _rebateRstModel.productRebateList = [nsma copy];
        
        
        
        
        [(OptionPotView *)[self.view viewWithTag:Tag_QQImageView10] setPotDiscount:@""];
        [(OptionPotView *)[self.view viewWithTag:Tag_QQImageView20] setPotDiscount:@""];
        [(OptionPotView *)[self.view viewWithTag:Tag_QQImageView30] setPotDiscount:@""];
        
        
        
    } failureBlock:^(NSString *error){
        
        _HUD = [Utils createHUD];
        _HUD.mode = MBProgressHUDModeCustomView;
        _HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"HUD-error"]];
        _HUD.labelText =error;
        [_HUD hide:YES afterDelay:1.0];
    }];
    
    
    self.qmemberTypeModel=[[QmemberTypeModel alloc] init]  ;
    [self.qmemberTypeModel initWithValue:@"" QmemberTypeTitle:@""];
    
    QmemberTypeModel *qmemberTypeModel1=[[QmemberTypeModel alloc] init]  ;
    [qmemberTypeModel1 initWithValue:@"1" QmemberTypeTitle:@"超级QQ"];
    
    QmemberTypeModel *qmemberTypeModel2=[[QmemberTypeModel alloc] init];
    [qmemberTypeModel2 initWithValue:@"2" QmemberTypeTitle:@"QQ会员"];
    
    QmemberTypeModel *qmemberTypeModel3=[[QmemberTypeModel alloc] init];
    [qmemberTypeModel3 initWithValue:@"3" QmemberTypeTitle:@"蓝钻贵族"];
    
    QmemberTypeModel *qmemberTypeModel4=[[QmemberTypeModel alloc] init];
    [qmemberTypeModel4 initWithValue:@"4" QmemberTypeTitle:@"黄钻贵族"];
    
    QmemberTypeModel *qmemberTypeModel5=[[QmemberTypeModel alloc] init];
    [qmemberTypeModel5 initWithValue:@"5" QmemberTypeTitle:@"红钻贵族"];
    
    QmemberTypeModel *qmemberTypeModel6=[[QmemberTypeModel alloc] init];
    [qmemberTypeModel6 initWithValue:@"6" QmemberTypeTitle:@"读书VIP"];
    
    QmemberTypeModel *qmemberTypeModel7=[[QmemberTypeModel alloc] init];
    [qmemberTypeModel7 initWithValue:@"7" QmemberTypeTitle:@"魔钻贵族"];
    
    
    
  
    
  
   
    
    
    
     self.qmemberTypeArr = @[qmemberTypeModel1, qmemberTypeModel2,
                             qmemberTypeModel3, qmemberTypeModel4,
                             qmemberTypeModel5, qmemberTypeModel6,
                             qmemberTypeModel7];
    
    
    
    
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
    if (indexPath.section == 1){
        [UIColor clearColor];
        UIButton *memberBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        memberBtn.frame = CGRectMake( 10.f, 0.f, screen_width-20, 40.f);
        [memberBtn addTarget:self action:@selector(memberBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [memberBtn setBackgroundImage:PNGIMAGE(@"ll_spinner_item_normal") forState:UIControlStateNormal];
        
       
        [memberBtn setTitle:@" 选择会员类型" forState:UIControlStateNormal];
        [memberBtn setTitleColor:RGB(149, 149, 149) forState:UIControlStateNormal];
        memberBtn.titleLabel.font = [UIFont systemFontOfSize:15.f];
        [memberBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
        memberBtn.tag=Tag_QQmemberButton;
       
        [cell addSubview:memberBtn];
        
        
        
        
    }

    
    
    //[_chargeIcon setUserInteractionEnabled:YES];
    
    if (indexPath.section == 2){
        [UIColor clearColor];
        
        UITapGestureRecognizer *tapGesture   = [[UITapGestureRecognizer alloc] initWithTarget:self  action:@selector(clickCategory:)];
        tapGesture.numberOfTouchesRequired = 1; //手指数
        tapGesture.numberOfTapsRequired = 1; //tap次数
        
        OptionPotModel *optionPotModel=[OptionPotModel alloc];
        optionPotModel.optionId=@"10";
        optionPotModel.optionTitle=@"Q 1个月";
        optionPotModel.optionDiscout=@"";
        optionPotModel.optionSelected=false;
        
        
        
        OptionPotView *optionPotView=[[OptionPotView alloc] initWithFrame:CGRectMake(10.f, 2.f,  (screen_width-40)/3, 40.f) optionPot: optionPotModel];
        optionPotView.tag = Tag_QQImageView10;
        [optionPotView addGestureRecognizer:tapGesture];
        
        [cell addSubview:optionPotView];
        
        
        tapGesture   = [[UITapGestureRecognizer alloc] initWithTarget:self  action:@selector(clickCategory:)];
        tapGesture.numberOfTouchesRequired = 1; //手指数
        tapGesture.numberOfTapsRequired = 1;
        
        optionPotModel=[OptionPotModel alloc];
        optionPotModel.optionId=@"20";
        optionPotModel.optionTitle=@"Q 2个月";
        optionPotModel.optionDiscout=@"";
        optionPotModel.optionSelected=false;
        
        
        
        optionPotView=[[OptionPotView alloc] initWithFrame:CGRectMake((screen_width-40)/3+20.f, 2.f,  (screen_width-40)/3, 40.f) optionPot: optionPotModel];
        optionPotView.tag = Tag_QQImageView20;
        [optionPotView addGestureRecognizer:tapGesture];
        
        [cell addSubview:optionPotView];
        
        
        tapGesture   = [[UITapGestureRecognizer alloc] initWithTarget:self  action:@selector(clickCategory:)];
        tapGesture.numberOfTouchesRequired = 1; //手指数
        tapGesture.numberOfTapsRequired = 1;
        
        optionPotModel=[OptionPotModel alloc];
        optionPotModel.optionId=@"30";
        optionPotModel.optionTitle=@"Q 3个月";
        optionPotModel.optionDiscout=@"";
        optionPotModel.optionSelected=false;
        
        
        
        optionPotView=[[OptionPotView alloc] initWithFrame:CGRectMake(2*(screen_width-40)/3+30, 2.f,  (screen_width-40)/3, 40.f) optionPot: optionPotModel];
        optionPotView.tag = Tag_QQImageView30;
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
        
        
        NSString *payTip=[Utils getStoreValue:STORE_QMEMBERPAYTIP];
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
        return 10.f;
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



#pragma mark - sourceBtnClicked Method
- (void)memberBtnClicked:(id)sender{
    
    CZPickerView *picker = [[CZPickerView alloc] initWithHeaderTitle:@"会员类型" cancelButtonTitle:@"Cancel" confirmButtonTitle:@"Confirm"];
    picker.delegate = self;
    picker.dataSource = self;
    picker.needFooterView = NO;
    [picker show];
    
}

- (NSAttributedString *)czpickerView:(CZPickerView *)pickerView
               attributedTitleForRow:(NSInteger)row{
    QmemberTypeModel *qmemberTypeModel=(QmemberTypeModel *)self.qmemberTypeArr[row];
   
    NSAttributedString *att = [[NSAttributedString alloc]
                               initWithString:qmemberTypeModel.QmemberTypeTitle
                               attributes:@{
                                            NSFontAttributeName:[UIFont fontWithName:@"Avenir-Light" size:18.0]
                                            }];
    return att;
}

- (NSString *)czpickerView:(CZPickerView *)pickerView
               titleForRow:(NSInteger)row{
    QmemberTypeModel *qmemberTypeModel=(QmemberTypeModel *)self.qmemberTypeArr[row];
    
    return qmemberTypeModel.QmemberTypeTitle;
}

- (NSInteger)numberOfRowsInPickerView:(CZPickerView *)pickerView{
    return self.qmemberTypeArr.count;
}

- (void)czpickerView:(CZPickerView *)pickerView didConfirmWithItemAtRow:(NSInteger)row{
    QmemberTypeModel *qmemberTypeModel=(QmemberTypeModel *)self.qmemberTypeArr[row];
    
    UIButton *memberBtn=(UIButton *)[self.view viewWithTag:Tag_QQmemberButton]  ;
    [memberBtn setTitle:[NSString stringWithFormat:@"  %@",    qmemberTypeModel.QmemberTypeTitle] forState:UIControlStateNormal];
    
    
    
    
    [memberBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    self.qmemberTypeModel=qmemberTypeModel;
    
    [(OptionPotView *)[self.view viewWithTag:Tag_QQImageView10] setPotSelect:false];
    [(OptionPotView *)[self.view viewWithTag:Tag_QQImageView20] setPotSelect:false];
    [(OptionPotView *)[self.view viewWithTag:Tag_QQImageView30] setPotSelect:false];
    
    RebateModel *rebateModel;
    
    self.qqMemberTypeName=[Utils trim: qmemberTypeModel.QmemberTypeTitle];
    
    rebateModel=[self getProductRebate:[NSString stringWithFormat:@"160600%@01",qmemberTypeModel.QmemberTypeId]];
    [(OptionPotView *)[self.view viewWithTag:Tag_QQImageView10] setPotDiscount:rebateModel.PayTip];
    
    rebateModel=[self getProductRebate:[NSString stringWithFormat:@"160600%@02",qmemberTypeModel.QmemberTypeId]];
    [(OptionPotView *)[self.view viewWithTag:Tag_QQImageView20] setPotDiscount:rebateModel.PayTip];
    rebateModel=[self getProductRebate:[NSString stringWithFormat:@"160600%@03",qmemberTypeModel.QmemberTypeId]];
    [(OptionPotView *)[self.view viewWithTag:Tag_QQImageView30] setPotDiscount:rebateModel.PayTip];

    
    //NSLog(@"%@ 123 is chosen!", );
}

-(void)czpickerView:(CZPickerView *)pickerView didConfirmWithItemsAtRows:(NSArray *)rows{
    for(NSNumber *n in rows){
        NSInteger row = [n integerValue];
      
    }
}

- (void)czpickerViewDidClickCancelButton:(CZPickerView *)pickerView{
    NSLog(@"Canceled.");
}


#pragma mark - RegisterBtnClicked Method
- (void)nextBtnClicked:(id)sender{
    
    
    
    BOOL *isLogin = [[Tool sharedInstance]  isLogIn];
   

    if(!isLogin){
        LoginController  *loginController=[[ LoginController alloc]init];
        loginController.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:loginController animated:YES];
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
        [Utils alertTitle:@"提示" message:@"请选择QQ服务以及包月" delegate:self cancelBtn:@"取消" otherBtnName:nil];
        
        return  ;
    }
    
    self.appDelegate.phoneNumber=phoneNumber;
    self.appDelegate.qqNumber = qqNumber;
    self.appDelegate.qqMonth=_qqMonth;
    self.appDelegate.qqMemberTypeName=_qqMemberTypeName;
    self.appDelegate.payMoney=_payMoney;
    self.appDelegate.productId=_productId;
    QmemberConfirmController  *qmemberConfirmController=[[ QmemberConfirmController alloc]init];
    qmemberConfirmController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:qmemberConfirmController animated:YES];
    return;

    
    
    
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
                    
                    [Utils alertTitle:@"提示" message:@"QQ号码小于6位！" delegate:nil cancelBtn:@"取消" otherBtnName:nil];
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

- (void)OnTapBackBtn:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
    
}


-(void)clickCategory:(UITapGestureRecognizer *)gestureRecognizer
{
    
    
    UIView *viewClicked=[gestureRecognizer view];
    
    [(OptionPotView *)[self.view viewWithTag:Tag_QQImageView10] setPotSelect:false];
    [(OptionPotView *)[self.view viewWithTag:Tag_QQImageView20] setPotSelect:false];
    [(OptionPotView *)[self.view viewWithTag:Tag_QQImageView30] setPotSelect:false];
    
    
    [(OptionPotView *)viewClicked setPotSelect:true];
    
    
    
    
    RebateModel *rebateModel;
    NSMutableAttributedString *AttributedStr;
    NSString *discountTip;
    
    
   
    if (viewClicked.tag ==Tag_QQImageView10) {
        _productId=[NSString stringWithFormat:@"160600%@01",self.qmemberTypeModel.QmemberTypeId];
        _qqMonth=@"1个月";
        
    }
    if (viewClicked.tag ==Tag_QQImageView20) {
        _productId=[NSString stringWithFormat:@"160600%@02",self.qmemberTypeModel.QmemberTypeId];
        _qqMonth=@"2个月";

    }
    if (viewClicked.tag ==Tag_QQImageView30) {
        _productId=[NSString stringWithFormat:@"160600%@03",self.qmemberTypeModel.QmemberTypeId];
        _qqMonth=@"3个月";

    }
  
    
    
    rebateModel=[self getProductRebate:_productId];
    
    _payMoney=[Utils trim:rebateModel.PayMoney];
    
   
    
    discountTip=[NSString stringWithFormat:@"%@办理%@，实付金额%@元", _qqMemberTypeName,_qqMonth,_payMoney];
    AttributedStr = [[NSMutableAttributedString alloc]initWithString:discountTip ];
    
    
    [AttributedStr addAttribute:NSFontAttributeName
     
                          value:[UIFont systemFontOfSize:14.0]
     
                          range:NSMakeRange(10,  [discountTip length]-10 )];
    
    [AttributedStr addAttribute:NSForegroundColorAttributeName
     
                          value:[UIColor blueColor]
     
                          range:NSMakeRange(10, [discountTip length]-10 )];
    
    ((UILabel *)[self.view viewWithTag:Tag_DiscountTip]).attributedText = AttributedStr;
    
    
}



@end

