#import "LoginController.h"
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
#import "LoginRstModel.h"
#import "FindController.h"
#import "MineController.h"

@interface LoginController ()<UITableViewDataSource,UITableViewDelegate ,UITextFieldDelegate>
@property (nonatomic, strong) PlaceholderTextView *feedbackTextView;
@property (nonatomic, strong) MBProgressHUD       *HUD;
@property (nonatomic,retain)  TitleView *titleView;
@property (nonatomic,retain)  UILabel *topLabel;
@property (nonatomic,assign) BOOL          isRemember;
@property (nonatomic,strong) UITableView *registerTableView;
@property  AppDelegate *appDelegate;
#pragma mark Register TextField Tag enum
enum TAG_REGISTER_TEXTFIELD{
    
    Tag_EmailTextField  = 100,    //邮箱
    Tag_AccountTextField ,        //用户名
    Tag_TempPasswordTextField
    
};

#pragma mark - Register Label Tag


#pragma mark - protocol Btn Tag 协议有关的btn的tag值
enum TAG_PROTOCOL_BUTTON{
    
    Tag_isReadButton = 200,   //是否已阅读
    Tag_servicesButton
};

@end
@implementation LoginController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.appDelegate = [[UIApplication sharedApplication] delegate];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
    UIButton *backBtn = [UIButton buttonWithType: UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, (title_height+20-40)/2, 40, 40);
    [backBtn setImage:[UIImage imageNamed:@"tital_back"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(OnTapBackBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    NSUserDefaults * settings = [NSUserDefaults standardUserDefaults];
    
    NSString *rememberKey= [NSString stringWithFormat:STORE_REMEMBER];
    NSString *rememberValue = [settings objectForKey:rememberKey];
    _isRemember=false;
    if(rememberValue && [rememberValue isEqualToString:@"true"] ){
        _isRemember=true;
    }
    
    
    
    UILabel *rightLabel = [UILabel new];
    rightLabel.frame = CGRectMake(screen_width-40, (title_height+22-40)/2, 40, 40);
    
    rightLabel.textColor = [UIColor whiteColor];
    rightLabel.font = [UIFont fontWithName:@"Helvetica" size:16];
    rightLabel.text = @"注册";
    rightLabel.userInteractionEnabled = YES;
    [rightLabel addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onClickRightLabel)]];

    
    
    _titleView = [[TitleView alloc] initWithFrame:@"登 录" leftMenuItem:backBtn rightMenuItem:rightLabel ];
    [self.view addSubview:_titleView];
    
    _registerTableView = [[UITableView alloc] initWithFrame:CGRectMake(0.f, H(_titleView), screen_width, screen_height) style:UITableViewStyleGrouped];
    _registerTableView.allowsSelection = NO;
    _registerTableView.delegate = self;
    _registerTableView.dataSource = self;
    _registerTableView.separatorStyle = NO;
    [self.view addSubview:_registerTableView];
    
    UITapGestureRecognizer *hideKeyboardRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(allEditActionsResignFirstResponder)];
    [_registerTableView addGestureRecognizer:hideKeyboardRecognizer];
    hideKeyboardRecognizer.cancelsTouchesInView = NO;
}


#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    //if (section == 2) {
        return 1;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier = @"cellIdentifier";
    
    UITableViewCell *cell =  [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier]   ;
    
    
    
    
    
    
    
    NSString *key;
    
   if (indexPath.section == 0){
        
        cell.imageView.image = PNGIMAGE(@"register_user@2x");
        UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(50.f, 12.f, 220.f, 21.f)];
        textField.tag = Tag_AccountTextField;
        textField.returnKeyType = UIReturnKeyDone;
        textField.delegate = self;
        textField.placeholder = @"手机号码,必填";
        textField.keyboardType = UIKeyboardTypeNumberPad;
        textField.returnKeyType = UIReturnKeyDone;
        if(_isRemember){
           key= [NSString stringWithFormat:STORE_PHONENUMBER];
           textField.text=[Utils getStoreValue:key];
        }
        [cell addSubview:textField];
        
        
    }
    if (indexPath.section == 1){
        
            cell.imageView.image = PNGIMAGE(@"register_password@2x");
            UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(50.f, 12.f, 220.f, 21.f)];
            textField.tag = Tag_TempPasswordTextField;
            textField.keyboardType=UIKeyboardAppearanceDefault;
            textField.returnKeyType = UIReturnKeyDone;
            textField.secureTextEntry = YES;
            textField.delegate = self;
            textField.placeholder = @"密码,必填";
            if(_isRemember){
                key= [NSString stringWithFormat:STORE_PASSWORD];
                textField.text=[Utils getStoreValue:key];
            }
            [cell addSubview:textField];
        
    }
    
    if (indexPath.section == 2){
        [cell   setBackgroundColor:RGB(235, 235, 241)];
        APRoundedButton *registerBtn = [APRoundedButton buttonWithType:UIButtonTypeCustom];
        registerBtn.frame = CGRectMake( 15.f, 0.f, screen_width-30, 44.f);
        [registerBtn addTarget:self action:@selector(registerBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
         [registerBtn setBackgroundImage:nil forState:UIControlStateNormal];
         [registerBtn   setBackgroundColor:RGB(84,188,223)];
        //[registerBtn   forState:UIControlStateNormal];
        //backgroundColor
        [registerBtn setTitle:@"登 录" forState:UIControlStateNormal];
        [registerBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        registerBtn.titleLabel.font = [UIFont systemFontOfSize:18.f];
        [registerBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
        registerBtn.style=10;
        [registerBtn awakeFromNib];
        [cell addSubview:registerBtn];
    }
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (section == 0) {
        
        
        UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0.f, 0.f, 320.f, 21.f)];
        footerView.backgroundColor = [UIColor clearColor];
        UILabel *label = [Utils labelWithFrame:CGRectMake(10.f, 0.f, 300.f, 21.f) withTitle:@"浙江电信11位手机号码" titleFontSize:[UIFont systemFontOfSize:10.f] textColor:[UIColor blackColor] backgroundColor:[UIColor clearColor] alignment:NSTextAlignmentLeft];
        [footerView addSubview:label];
        
        return  footerView ;
        
        //
    }
    
    if (section == 1){
        UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0.f, 0.f, 320.f, 21.f)];
        footerView.backgroundColor = [UIColor clearColor];
        UILabel *label = [Utils labelWithFrame:CGRectMake(10.f, 0.f, 300.f, 21.f) withTitle:@"6位字符以上，可包含数字、字母（区分大小写）" titleFontSize:[UIFont systemFontOfSize:10.f] textColor:[UIColor blackColor] backgroundColor:[UIColor clearColor] alignment:NSTextAlignmentLeft];
        [footerView addSubview:label];
        return  footerView  ;
        
        
    }
    
    if (section == 2){
        UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0.f, 0.f, 320.f, 21.f)];
        footerView.backgroundColor = [UIColor clearColor];
        
        UIButton *isReadBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        isReadBtn.frame = CGRectMake(10.f, 4.f, 21.f, 21.f);
        if(_isRemember){
            [isReadBtn setImage:[UIImage imageNamed:@"isRead_selectedButton@2x"] forState:UIControlStateNormal];
        }else{
            [isReadBtn setImage:[UIImage imageNamed:@"isRead_waiting_selectButton@2x"] forState:UIControlStateNormal];
        }
        
        [isReadBtn addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        isReadBtn.tag = Tag_isReadButton;
        [footerView addSubview:isReadBtn];
        
        
        UILabel *label1 = [Utils labelWithFrame:CGRectMake(35.f, 4.f, 70.f, 21.f) withTitle:@"记住密码" titleFontSize:[UIFont systemFontOfSize:13.f] textColor:[UIColor blackColor] backgroundColor:[UIColor clearColor] alignment:NSTextAlignmentLeft];
        [footerView addSubview:label1];
        
        UIButton *servicesBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        servicesBtn.frame = CGRectMake(W(_registerTableView)/2, 4.f, W(_registerTableView)/2-15, 21.f);
        [servicesBtn setTitle:@"重置密码" forState:UIControlStateNormal];
        [servicesBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        servicesBtn.titleLabel.font = [UIFont systemFontOfSize:13.f];
        [servicesBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
        [servicesBtn addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        servicesBtn.tag = Tag_servicesButton;
        [footerView addSubview:servicesBtn];
        
        
        
        
        
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
        return 21.f;
    }
    if(section == 2){
        
        return 35.f;
        
    }else{
        return 21.f;
    }
}

-(UIView*)tableView:(UITableView*)tableView viewForHeaderInSection:(NSInteger)section
{
    return  [[UIView alloc] initWithFrame:CGRectZero]  ;
}


#pragma mark - UIButtonClicked Method
- (void)buttonClicked:(id)sender{
    
    UIButton *btn = (UIButton *)sender;
    switch (btn.tag) {
        case Tag_isReadButton:
        {
            //是否阅读协议
            if (_isRemember) {
                
                [btn setImage:[UIImage imageNamed:@"isRead_waiting_selectButton@2x"] forState:UIControlStateNormal];
                _isRemember = NO;
            }else{
                
                [btn setImage:[UIImage imageNamed:@"isRead_selectedButton@2x"] forState:UIControlStateNormal];
                
                _isRemember = YES;
            }
        }
            break;
        case Tag_servicesButton:
        {
            //服务协议
            FindController   *findController=[[FindController alloc]init];
            [self.navigationController pushViewController:findController animated:YES];
        }
            break;
        
            
        default:
            break;
    }
    
}
#pragma mark - sourceBtnClicked Method
- (void)sourceBtnClicked:(id)sender{
    
    [Utils alertTitle:@"提示" message:@"来源接口方法入口" delegate:nil cancelBtn:@"确定" otherBtnName:nil];
}

#pragma mark - RegisterBtnClicked Method
- (void)registerBtnClicked:(id)sender{
    
    NSString *phoneNumber,*password,*encodePassword;
    phoneNumber=[(UITextField *)[self.view viewWithTag:Tag_AccountTextField] text];
    if(phoneNumber==nil)
        phoneNumber=@"";
    phoneNumber=[phoneNumber stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    password=[(UITextField *)[self.view viewWithTag:Tag_TempPasswordTextField] text];
    if(password==nil)
        password=@"";
    password=[password stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    
    if(![Utils isPhoneNumber:phoneNumber]){
        [Utils alertTitle:@"提示" message:@"请输入正确的手机号码" delegate:self cancelBtn:@"取消" otherBtnName:nil];
        
        return ;
        
    }
    
    if ( [password length]<6) {
        
        [Utils alertTitle:@"提示" message:@"请输入正确的密码" delegate:self cancelBtn:@"取消" otherBtnName:nil];
        
        return  ;
    }
    encodePassword=[Utils md5:password];
    encodePassword=[Utils encodeBase64String:encodePassword];
    
    
    NSDictionary *paraInfo = [NSDictionary dictionaryWithObjectsAndKeys:phoneNumber, @"PhoneNumber", encodePassword, @"Password",nil];
    
    
    _HUD = [Utils createHUD];
    _HUD.labelText = @"";
    
    [[NetworkSingleton sharedManager] userLogin:paraInfo   successBlock:^(id responseBody){
        
        
        [_HUD hide:YES];
        LoginRstModel *loginRstModel = [LoginRstModel objectWithKeyValues:responseBody];
        if(loginRstModel.respCode!=0){
            [Utils alertTitle:@"提示" message:loginRstModel.respInfo delegate:nil cancelBtn:@"确定" otherBtnName:nil];
            return;
        }
        
        
        NSUserDefaults * settings = [NSUserDefaults standardUserDefaults];
        NSString *phoneNumberKey= [NSString stringWithFormat:STORE_PHONENUMBER];
        
        [settings setObject: phoneNumber forKey:phoneNumberKey];
        
        NSString *passwordKey= [NSString stringWithFormat:STORE_PASSWORD];
        [settings setObject: password forKey:passwordKey];
        
        
         NSString *rememberKey= [NSString stringWithFormat:STORE_REMEMBER];
        if(_isRemember)
            [settings setObject: @"true" forKey:rememberKey];
        else
            [settings setObject: @"false" forKey:rememberKey];
        
        
        [settings synchronize];
        NSString *badgeValue =loginRstModel.MessageNumber>0? [NSString stringWithFormat:@"%d",loginRstModel.MessageNumber]:nil;
        [[[[[self tabBarController] viewControllers] objectAtIndex: 1] tabBarItem] setBadgeValue:badgeValue];
        [[Tool sharedInstance]  setLongIn:true];
        [[Tool sharedInstance] setLeftMoney:@""];
         //[self.navigationController popToRootViewControllerAnimated:YES];
        
       // [[NSNotificationCenter defaultCenter] postNotificationName:@"MineController_Refresh" object:nil];
        
        NSNotification *notification= [NSNotification notificationWithName:@"MineController_Refresh" object:self userInfo:nil];
        [[NSNotificationCenter defaultCenter] postNotification:notification];
        
        notification= [NSNotification notificationWithName:@"QmonthMineController_Refresh" object:self userInfo:nil];
        [[NSNotificationCenter defaultCenter] postNotification:notification];
        
         //[self.appDelegate gotoTab:0];

        
        [self.navigationController popViewControllerAnimated:YES]; 
        
       /* for (UIViewController *controller in self.navigationController.viewControllers) {
            if ([controller isKindOfClass:[MineController class]]) {
                [self.navigationController popToViewController:controller animated:YES];
            }
        }*/
        
        
        
        
        
        

        
        
        
        
        
        
    } failureBlock:^(NSString *error){
        
        _HUD = [Utils createHUD];
        _HUD.mode = MBProgressHUDModeCustomView;
        _HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"HUD-error"]];
        _HUD.labelText =error;
        [_HUD hide:YES afterDelay:1.0];
    }];
        
    
            
           //
    
    
}

/**
 *	@brief	验证文本框是否为空
 */


#pragma mark - UITextFieldDelegate Method

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    
    }

- (void)textFieldDidEndEditing:(UITextField *)textField{
    
    switch (textField.tag) {
            
        case Tag_EmailTextField:
        {
            if ([textField text] != nil && [[textField text] length]!= 0) {
                
                if (![Utils isValidateEmail:textField.text]) {
                    
                    [Utils alertTitle:@"提示" message:@"邮箱格式不正确" delegate:nil cancelBtn:@"取消" otherBtnName:nil];
                }
            }
        }
            break;
        case Tag_TempPasswordTextField:
        {
            if ([textField text] != nil && [[textField text] length]!= 0) {
                
                if ([[textField text] length] < 6) {
                    
                    [Utils alertTitle:@"提示" message:@"用户密码小于6位！" delegate:nil cancelBtn:@"取消" otherBtnName:nil];
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
    [[self.view viewWithTag:Tag_AccountTextField] resignFirstResponder];
    
    //temp密码
    [[self.view viewWithTag:Tag_TempPasswordTextField] resignFirstResponder];
    
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
   // NSLog(@"%@",@"我发了通知了啊");
    NSNotification *notification= [NSNotification notificationWithName:@"MineController_Refresh" object:self userInfo:nil];
    [[NSNotificationCenter defaultCenter] postNotification:notification];
    /*notification= [NSNotification notificationWithName:@"QmonthMineController_Refresh" object:self userInfo:nil];
    [[NSNotificationCenter defaultCenter] postNotification:notification];*/
     [self.navigationController popViewControllerAnimated:YES];
    
}
- (void)onClickRightLabel{
    
    
    
     RegisterController  *registerController=[[RegisterController alloc]init];
     [self.navigationController pushViewController:registerController animated:YES];
    
    
}




@end

