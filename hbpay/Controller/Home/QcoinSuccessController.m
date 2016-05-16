#import "QcoinSuccessController.h"
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

@interface QcoinSuccessController ()<UITableViewDataSource,UITableViewDelegate ,UITextFieldDelegate>

@property (nonatomic, strong) MBProgressHUD       *HUD;
@property (nonatomic,retain)  TitleView *titleView;
@property (nonatomic,retain)  UILabel *topLabel;
@property (nonatomic,retain)  UIColor *backColor;
@property (nonatomic,strong)  UITableView *formTableView;


@property (nonatomic,strong)  NSString *productId;
@property (nonatomic,strong)  NSString *qqCount;
@property (nonatomic,strong)  NSString *payMoney;
@property  AppDelegate *appDelegate;


@end
@implementation QcoinSuccessController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    self.appDelegate = [[UIApplication sharedApplication] delegate];
    
    UIButton *backBtn = [UIButton buttonWithType: UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, (title_height+20-40)/2, 40, 40);
    [backBtn setImage:[UIImage imageNamed:@"tital_back"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(OnTapBackBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    _titleView = [[TitleView alloc] initWithFrame:@"Q币直充" leftMenuItem:backBtn rightMenuItem:nil ];
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
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 1) {
        return 7;
    }
    return 1;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section==0)
        return 50.f;
    if(indexPath.section==1)
        return 35.f;
    
    return 50.f;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier = @"cellIdentifier";
    
    UITableViewCell *cell =  [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier]   ;
    
    
    cell.imageView.image =nil;
    
    
    [cell   setBackgroundColor:_backColor];
    
    
    if (indexPath.section == 0){
        UILabel *label = [Utils labelWithFrame:CGRectMake(15.f, 10.f, screen_width-30, 50.f) withTitle:@"恭喜您，充值成功！" titleFontSize:[UIFont systemFontOfSize:18.f] textColor:RGB(73, 189, 36) backgroundColor:[UIColor clearColor] alignment:NSTextAlignmentCenter];
        [cell addSubview:label];
        
        
    }
    
    
    if (indexPath.section == 1){
        
        
        if (indexPath.row == 0) {
            
            
            
            UIImageView *imageUp = [[UIImageView alloc]initWithFrame:CGRectMake(15, 15, screen_width-30, 20)];
            imageUp.image = PNGIMAGE(@"ll_bg_conu");
            [cell addSubview:imageUp];
            
            
        }
        
        if (indexPath.row == 1){
            UIImageView *imageMiddle = [[UIImageView alloc]initWithFrame:CGRectMake(17, 0, screen_width-33, 35)];
            imageMiddle.image = PNGIMAGE(@"ll_bg_conm");
            [cell addSubview:imageMiddle];
            
            UILabel *label = [Utils labelWithFrame:CGRectMake(30.f, 5.f, screen_width-60, 21.f) withTitle:@"支付手机：" titleFontSize:[UIFont systemFontOfSize:13.f] textColor:[UIColor blackColor] backgroundColor:[UIColor clearColor] alignment:NSTextAlignmentLeft];
            
            
            NSString *labelText=[NSString stringWithFormat:@"支付手机：%@", [Utils trim:self.appDelegate.phoneNumber]];
            NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:labelText ];
            
            
            [AttributedStr addAttribute:NSFontAttributeName
             
                                  value:[UIFont systemFontOfSize:15.0]
             
                                  range:NSMakeRange(5,  [labelText length]-5 )];
            
            [AttributedStr addAttribute:NSForegroundColorAttributeName
             
                                  value:RGB(10, 127, 229)
             
                                  range:NSMakeRange(5, [labelText length]-5 )];
            
            label.attributedText = AttributedStr;
            [cell addSubview:label];
            
            
            UIImageView *imageLine = [[UIImageView alloc]initWithFrame:CGRectMake(30, 30, screen_width-60, 1)];
            
            imageLine.image = PNGIMAGE(@"ll_line");
            [cell addSubview:imageLine];
        }

        
        if (indexPath.row == 2){
            UIImageView *imageMiddle = [[UIImageView alloc]initWithFrame:CGRectMake(17, 0, screen_width-33, 35)];
            imageMiddle.image = PNGIMAGE(@"ll_bg_conm");
            [cell addSubview:imageMiddle];
            
            UILabel *label = [Utils labelWithFrame:CGRectMake(30.f, 5.f, screen_width-60, 21.f) withTitle:@"" titleFontSize:[UIFont systemFontOfSize:13.f] textColor:[UIColor blackColor] backgroundColor:[UIColor clearColor] alignment:NSTextAlignmentLeft];
            NSString *labelText=[NSString stringWithFormat:@"QQ号码：%@", [Utils trim:self.appDelegate.qqNumber]];
            NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:labelText ];
            
            
            [AttributedStr addAttribute:NSFontAttributeName
             
                                  value:[UIFont systemFontOfSize:15.0]
             
                                  range:NSMakeRange(5,  [labelText length]-5 )];
            
            [AttributedStr addAttribute:NSForegroundColorAttributeName
             
                                  value:RGB(149, 149, 149)
             
                                  range:NSMakeRange(5, [labelText length]-5 )];
            
            label.attributedText = AttributedStr;
            [cell addSubview:label];
            
            
            UIImageView *imageLine = [[UIImageView alloc]initWithFrame:CGRectMake(30, 30, screen_width-60, 1)];
            
            imageLine.image = PNGIMAGE(@"ll_line");
            [cell addSubview:imageLine];
        }
        
        if (indexPath.row == 3){
            
            UIImageView *imageMiddle = [[UIImageView alloc]initWithFrame:CGRectMake(17, 0, screen_width-33, 35)];
            imageMiddle.image = PNGIMAGE(@"ll_bg_conm");
            [cell addSubview:imageMiddle];
            UILabel *label = [Utils labelWithFrame:CGRectMake(30.f, 5.f, screen_width-60, 21.f) withTitle:@"" titleFontSize:[UIFont systemFontOfSize:13.f] textColor:[UIColor blackColor] backgroundColor:[UIColor clearColor] alignment:NSTextAlignmentLeft];
            NSString *labelText=[NSString stringWithFormat:@"Q币个数：%@", [Utils trim:self.appDelegate.qqCount]];
            NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:labelText ];
            
            
            [AttributedStr addAttribute:NSFontAttributeName
             
                                  value:[UIFont systemFontOfSize:15.0]
             
                                  range:NSMakeRange(5,  [labelText length]-5 )];
            
            [AttributedStr addAttribute:NSForegroundColorAttributeName
             
                                  value:RGB(149, 149, 149)
             
                                  range:NSMakeRange(5, [labelText length]-5 )];
            
            label.attributedText = AttributedStr;
            [cell addSubview:label];
            
            
            UIImageView *imageLine = [[UIImageView alloc]initWithFrame:CGRectMake(30, 30, screen_width-60, 1)];
            
            imageLine.image = PNGIMAGE(@"ll_line");
            [cell addSubview:imageLine];
        }
        if (indexPath.row == 4){
            
            UIImageView *imageMiddle = [[UIImageView alloc]initWithFrame:CGRectMake(17, 0, screen_width-33, 35)];
            imageMiddle.image = PNGIMAGE(@"ll_bg_conm");
            [cell addSubview:imageMiddle];
            UILabel *label = [Utils labelWithFrame:CGRectMake(30.f, 5.f, screen_width-60, 21.f) withTitle:@"" titleFontSize:[UIFont systemFontOfSize:13.f] textColor:[UIColor blackColor] backgroundColor:[UIColor clearColor] alignment:NSTextAlignmentLeft];
            NSString *labelText=[NSString stringWithFormat:@"支付金额：%@元",[Utils trim:self.appDelegate.payMoney]];
            NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:labelText ];
            
            
            [AttributedStr addAttribute:NSFontAttributeName
             
                                  value:[UIFont systemFontOfSize:15.0]
             
                                  range:NSMakeRange(5,  [labelText length]-5 )];
            
            [AttributedStr addAttribute:NSForegroundColorAttributeName
             
                                  value:RGB(149, 149, 149)
             
                                  range:NSMakeRange(5, [labelText length]-5 )];
            
            label.attributedText = AttributedStr;
            [cell addSubview:label];
            
            
            UIImageView *imageLine = [[UIImageView alloc]initWithFrame:CGRectMake(30, 30, screen_width-60, 1)];
            
            imageLine.image = PNGIMAGE(@"ll_line");
            [cell addSubview:imageLine];
        }
        if (indexPath.row == 5){
            UIImageView *imageMiddle = [[UIImageView alloc]initWithFrame:CGRectMake(17, 0, screen_width-33, 35)];
            imageMiddle.image = PNGIMAGE(@"ll_bg_conm");
            [cell addSubview:imageMiddle];
            
            
            APRoundedButton *confirmBtn = [APRoundedButton buttonWithType:UIButtonTypeCustom];
            confirmBtn.frame = CGRectMake( screen_width/4, 5.f, screen_width/2, 35.f);
            [confirmBtn addTarget:self action:@selector(nextBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
            [confirmBtn setBackgroundImage:nil forState:UIControlStateNormal];
            [confirmBtn   setBackgroundColor:RGB(84, 188, 223)];
            
            [confirmBtn setTitle:@"确定" forState:UIControlStateNormal];
            [confirmBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            confirmBtn.titleLabel.font = [UIFont systemFontOfSize:18.f];
            [confirmBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
            confirmBtn.style=10;
            [confirmBtn awakeFromNib];
            [cell addSubview:confirmBtn];
            
        }
        
        if (indexPath.row == 6){
            UIImageView *imageDown = [[UIImageView alloc]initWithFrame:CGRectMake(18, 0, screen_width-34, 20)];
            imageDown.image = PNGIMAGE(@"ll_bg_cond");
            [cell addSubview:imageDown];
        }
        
        
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
        return 0.f;
    }
    if (section == 1) {
        return 1.f;
    }
    if(section == 2){
        
        return 10.f;
        
    }
    
        return 21.f;
    
}

-(UIView*)tableView:(UITableView*)tableView viewForHeaderInSection:(NSInteger)section
{
    return  [[UIView alloc] initWithFrame:CGRectZero]  ;
}





#pragma mark - RegisterBtnClicked Method
- (void)nextBtnClicked:(id)sender{
    
    
    [self.navigationController popToRootViewControllerAnimated:YES];

    
   /* [Utils alertTitle:@"提示" message:@"请输入正确的密码" delegate:self cancelBtn:@"取消" otherBtnName:nil];*/
        
   
    
    
    
   
    
    
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

