#import "ExpandController.h"
#import "PlaceholderTextView.h"
#import "AppDelegate.h"
#import "MBProgressHUD.h"
#import "ExpandTableCellView.h"
#import "Utils.h"
#import "Public.h"
#import "TitleView.h"
#import "FaqModel.h"
@interface ExpandController ()<UITableViewDataSource,UITableViewDelegate >

@property (nonatomic, strong) PlaceholderTextView *feedbackTextView;
@property (nonatomic, strong) MBProgressHUD       *HUD;
@property (nonatomic,retain)  TitleView *titleView;


@property (nonatomic,retain)  UILabel *topLabel;
@property (nonatomic,retain)  NSMutableArray *faqArray;
@property (nonatomic,retain)  NSMutableArray *heightArray;
@property (nonatomic,strong) UITableView *agreeTableView;




@end
@implementation ExpandController

- (void)viewDidLoad
{
    [super viewDidLoad]; 
    self.view.backgroundColor = [UIColor themeColor];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
    UIButton *backBtn = [UIButton buttonWithType: UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, (title_height+20-40)/2, 40, 40);
    [backBtn setImage:[UIImage imageNamed:@"tital_back"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(OnTapBackBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    _faqArray= [NSMutableArray arrayWithCapacity:20];
    _heightArray= [NSMutableArray arrayWithCapacity:20];
    
    NSNumber *num = [NSNumber numberWithInt:60];
    [_heightArray addObject:num];
    num = [NSNumber numberWithInt:60];
    [_heightArray addObject:num];
    num = [NSNumber numberWithInt:60];
    [_heightArray addObject:num];
    
    
    FaqModel  *faqModel;
    
    faqModel=[[FaqModel alloc] init];
    faqModel.Title=@"168充值宝介绍";
    faqModel.Content= @"    在您使用浙江电信号码百事通（以下简称“浙江号百”）168充值宝小额支付自助交易（以下简称“168充值宝”）各项服务前，请您务必仔细阅读并正确理解本协议全部内容，尤其是双方的权利义务和有关浙江号百的免责事项。您使用168充值宝的行为将被视为对本交易协议全部内容的完全认可。";
    faqModel.State=@"false";
    [_faqArray addObject:faqModel];
    
    
    
    
    faqModel=[[FaqModel alloc] init];
    faqModel.Title=@"注册时提示格式错误，如177号段这是为什么呢？？";
    faqModel.Content = @"    1.1 您应具有完全的民事行为能力。浙江号百不为无民事行为能力或限制民事行为能力人提供本服务。\n    1.2 在签署本协议前，请您仔细阅读本协议条款，如您对本协议有疑义，请要求浙江号百说明。若您在进行注册程序过程中点击“同意”按钮即表示浙江号百已按您的要求予以说明，并表示您完全理解并接受该部分内容。\n    1.3 客户承诺自己在使用168充值宝的服务时，实施的所有行为均遵守国家相关法律、法规、部门规章和浙江号百的相关规定，亦不违反社会公共利益或公共道德。客户从事非法活动或不正当交易产生的一切后果与责任，由客户独立承担。";
    faqModel.State=@"false";
    [_faqArray addObject:faqModel];
     
     
     
     
     faqModel=[[FaqModel alloc] init];
     faqModel.Title=@"为什么提示“您的号码暂时受限呢”？？";
     faqModel.Content = @"    2.1 168充值宝密码是客户重要的个人资料，客户务必注意密码的保密；客户应按照机密的原则设置和保管自设密码，避免使用姓名、生日、电话号码等与本人明显相关的信息作为密码，不应将本人自设密码提供给除法律规定必须提供之外的任何人；客户应采取合理措施，防止本人密码被窃取，由于密码泄露造成的任何后果由客户自行承担。\n    2.2 凡使用手机号码和密码或使用手机短信验证码办理的一切业务，均视为客户亲自办理的业务，由客户承担由此所导致的相关后果和责任，包括但不限于业务费用的支付等。\n    2.3 浙江号百有相应的安全措施来保障客户的交易安全，但并不保证绝对安全。";
     faqModel.State=@"false";
     [_faqArray addObject:faqModel];
     
    
    
    
    
    
    
    _titleView = [[TitleView alloc] initWithFrame:@"意见建议" leftMenuItem:backBtn rightMenuItem:nil ];
    [self.view addSubview:_titleView];
    
    _agreeTableView = [[UITableView alloc] initWithFrame:CGRectMake(0.f, H(_titleView), screen_width, screen_height) style:UITableViewStyleGrouped];
    _agreeTableView.allowsSelection =NO;
    _agreeTableView.delegate = self;
    _agreeTableView.dataSource = self;
    _agreeTableView.separatorStyle = YES;
    [self.view addSubview:_agreeTableView];
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //[tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationNone];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    // ExpandTableCellView *cell = (ExpandTableCellView *) [self tableView:tableView cellForRowAtIndexPath:indexPath];
    
    //NSLog(@"%d",cell.cellHight);
     //return cell.contentView.frame.size.height;
     //return cell.cellHight;
    
    return [[_heightArray objectAtIndex:indexPath.section] intValue];
    //return 200;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier = @"cellIdentifier";
    FaqModel *faqModel=[_faqArray objectAtIndex:indexPath.section];
    
    
    ExpandTableCellView *cell= [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    
 
    
    if (cell == nil) {
        cell =  [[ExpandTableCellView alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier faqModel:faqModel indexPath:indexPath]   ;
        cell.delegate=self;
        
    }
    
    
    return cell; 
}

#pragma mark - UITableViewDelegate
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    
    return  nil;
}

-(CGFloat)tableView:(UITableView*)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.1f;
}


-(CGFloat)tableView:(UITableView*)tableView heightForFooterInSection:(NSInteger)section
{
    
    
    return  0.1f;
    
}

-(UIView*)tableView:(UITableView*)tableView viewForHeaderInSection:(NSInteger)section
{
    
    return  nil;
    //[[UIView alloc] initWithFrame:CGRectZero]
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


-(void)didSelectExpandTableCell:(NSIndexPath *) indexPath{
    FaqModel *faqModel=[_faqArray objectAtIndex:indexPath.section];
    if([faqModel.State isEqualToString:@"true"]){
        faqModel.State=@"false";
    }else{
        faqModel.State=@"true";
    }
    [_heightArray replaceObjectAtIndex:indexPath.section withObject: [NSNumber numberWithInt:500]];
    [_agreeTableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationNone];
    
    //[_agreeTableView reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationAutomatic];
    
    
 
}



@end




