#import "AgreeController.h"
#import "PlaceholderTextView.h"
#import "AppDelegate.h"
#import "MBProgressHUD.h"
#import "Utils.h"
#import "Public.h"
#import "TitleView.h"
@interface AgreeController ()<UITableViewDataSource,UITableViewDelegate >

@property (nonatomic, strong) PlaceholderTextView *feedbackTextView;
@property (nonatomic, strong) MBProgressHUD       *HUD;
@property (nonatomic,retain)  TitleView *titleView;
@property (nonatomic,retain)  UILabel *topLabel;
@property (nonatomic,retain)  NSMutableArray *heightArray;

@property (nonatomic,strong) UITableView *agreeTableView;

@end
@implementation AgreeController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
     self.view.backgroundColor = [UIColor themeColor];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
    UIButton *backBtn = [UIButton buttonWithType: UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, (title_height+20-40)/2, 40, 40);
    [backBtn setImage:[UIImage imageNamed:@"tital_back"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(OnTapBackBtn:) forControlEvents:UIControlEventTouchUpInside];
    
     _heightArray = [NSMutableArray arrayWithCapacity:20];
    
    NSString *topTxt = @"    在您使用浙江电信号码百事通（以下简称“浙江号百”）168充值宝小额支付自助交易（以下简称“168充值宝”）各项服务前，请您务必仔细阅读并正确理解本协议全部内容，尤其是双方的权利义务和有关浙江号百的免责事项。您使用168充值宝的行为将被视为对本交易协议全部内容的完全认可。";
    [_heightArray addObject:topTxt];
    topTxt = @"    1.1 您应具有完全的民事行为能力。浙江号百不为无民事行为能力或限制民事行为能力人提供本服务。\n    1.2 在签署本协议前，请您仔细阅读本协议条款，如您对本协议有疑义，请要求浙江号百说明。若您在进行注册程序过程中点击“同意”按钮即表示浙江号百已按您的要求予以说明，并表示您完全理解并接受该部分内容。\n    1.3 客户承诺自己在使用168充值宝的服务时，实施的所有行为均遵守国家相关法律、法规、部门规章和浙江号百的相关规定，亦不违反社会公共利益或公共道德。客户从事非法活动或不正当交易产生的一切后果与责任，由客户独立承担。";
    [_heightArray addObject:topTxt];
    
    topTxt = @"    2.1 168充值宝密码是客户重要的个人资料，客户务必注意密码的保密；客户应按照机密的原则设置和保管自设密码，避免使用姓名、生日、电话号码等与本人明显相关的信息作为密码，不应将本人自设密码提供给除法律规定必须提供之外的任何人；客户应采取合理措施，防止本人密码被窃取，由于密码泄露造成的任何后果由客户自行承担。\n    2.2 凡使用手机号码和密码或使用手机短信验证码办理的一切业务，均视为客户亲自办理的业务，由客户承担由此所导致的相关后果和责任，包括但不限于业务费用的支付等。\n    2.3 浙江号百有相应的安全措施来保障客户的交易安全，但并不保证绝对安全。";
    [_heightArray addObject:topTxt];
    
    topTxt = @"    3.1 客户进行168充值宝缴费的手机号码，必须为本人属有，并有可支付额度。一旦客户点击确认支付，亦不得要求变更或撤销该指令。\n    3.2 客户不得以与第三方发生纠纷为理由而拒绝支付使用本服务的应付款项。\n    3.3 客户应保证提供的资料真实、准确、完整、合法。对于因客户提供信息不真实或不完整所造成的损失由客户自行承担。客户相关信息发生变化时，应即时更新，浙江号百不承担由于客户未及时更新相关信息所导致的相关责任。\n   3.4 浙江号百有权根据交易显示的资费标准，向客户收取相关费用：通过浙江号百办理的业务，若该业务须缴纳相应的月租费及通信费，则相关的费用将在客户的手机号码账户中一并收取，浙江号百不再另行通知。\n   3.5 客户有任何疑问或发现交易指令未执行、未适当执行、延迟执行的，应第一时间通过拨打客服电话0571-16887885通知浙江号百。浙江号百可以通过电话、短信、邮件、媒体广告等方式向客户告知处理进展或推荐业务。\n   3.6 如客户在168充值宝上存在违法行为或违反本协议的行为，或因客户此前使用本服务的行为引发争议的，浙江号百仍可行使追究的权利。客户同意，浙江号百不对因下述任一情况而发生的服务中断或终止而承担任何赔偿责任。\n     3.6.1 浙江号百基于单方判断，认为客户已经违反本服务条款的规定，将中断或终止向客户提供浙江电信部分或全部服务功能，并将相关资料加以删除。\n     3.6.2 浙江号百在发现客户注册资料虚假、异常交易或有疑义或有违法嫌疑时，不经通知有权先行中断或终止客户的手机号码、密码，并拒绝客户使用浙江电信部分或全部服务功能。\n   3.7 浙江号百有权了解客户使用168充值宝的真实交易背景及目的，客户应如实提供浙江号百所需的真实、全面、准确的信息；如果浙江号百有合理理由怀疑客户提供虚假交易信息的，浙江电信有权暂时或永久限制客户所使用的产品或服务的部分或全部功能。\n   3.8 为保护客户的手机号码账户及其内资金的安全，根据国家法律、行政规章及本协议的相关约定，浙江号百有权依据自行判断认为可能对客户的手机号码账户产生风险的情况，冻结客户的手机号码及可疑交易，即暂时关闭该号码部分或全部使用权限的操作。冻结的逆过程为解冻，即浙江号百对客户的被冻结的手机号码及交易解除冻结。客户可申请解冻已被冻结的手机号码，但浙江号百有权自行判断决定是否允许解冻，客户应知晓并充分理解其解冻申请并不必然被允许。客户申请解冻时应当配合浙江号百核实客户及交易的有关信息要求，提供包括但不限于身份证明文件及浙江号百要求的其他信息或文件。\n   3.9 浙江号百有权将客户及其交易信息提供给国家司法机关、行政机关等权力机构配合调查、处理。";
    [_heightArray addObject:topTxt];
    
    topTxt = @"    4.1 浙江号百仅对本协议中列明的责任范围负责。除本协议另有规定外，在任何情况下，本公司对本协议所承担的违约赔偿责任总额应不超过所收取的当次服务费用总额。\n    4.2 浙江号百仅以现有的、按其现状提供有关的信息、材料及运行。浙江号百不对其所提供的材料和信息的可用性、准确性或可靠性做出任何种类的保证，包括但不限于对所有权，知识产权，风险，不侵权，准确性，可靠性，适销性，使用正确性，适合特定用途或其它适当性。\n    4.3 浙江号百不保证提供的服务一定能满足客户的要求，不保证服务不会中断，不保证服务的绝对及时、安全、真实和无差错，也不保证客户发送的信息一定能完全准确、及时、顺利地被传送。\n   4.4 不论何种情形，浙江号百都不对任何由于使用或无法使用浙江号百提供的服务所造成间接的、附带的、特殊的或余波所及的损失、损害、债务或商务中断承担任何责任。\n   4.5 浙江号百不承担交易货物的交付责任，因货物延迟送达或在送达过程中的丢失、损坏等，应由您与交易对方自行处理。";
    [_heightArray addObject:topTxt];
    
    topTxt = @"    5.1 本协议的成立、生效、履行和解释，均适用中华人民共和国法律； 在法律允许范围内，本协议由浙江号百负责解释。";
    [_heightArray addObject:topTxt];
    
    topTxt = @"    6.1 客户和浙江号百在履行本协议的过程中，如发生争议，应友好协商解决。协商不成的，任何一方均可向杭州仲裁委员会申请仲裁。";
    [_heightArray addObject:topTxt];
    
    topTxt = @"    7.1 本协议自客户点击“同意”按钮时生效。本协议的任何条款如因任何原因而被确认无效，都不影响本协议其他条款的效力。\n    7.2 浙江号百有权对本协议所有条款适时进行修改，如果客户对此持有异议，可以选择终止本协议。如果继续使用本协议项下的相关服务，则视为客户已经完全接受本协议相关条款的修改。\n\n";
    
    [_heightArray addObject:topTxt];

    
    
    
    _titleView = [[TitleView alloc] initWithFrame:@"服务协议" leftMenuItem:backBtn rightMenuItem:nil ];
    [self.view addSubview:_titleView];
    
    
    
    _agreeTableView = [[UITableView alloc] initWithFrame:CGRectMake(0.f, H(_titleView), screen_width, screen_height) style:UITableViewStyleGrouped];
    _agreeTableView.allowsSelection = NO;
    _agreeTableView.delegate = self;
    _agreeTableView.dataSource = self;
    _agreeTableView.separatorStyle = NO;
    [self.view addSubview:_agreeTableView];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 先从缓存中查找图片
    //return [[_heightArray objectAtIndex:indexPath.section] floatValue];
    CGSize  size = [[_heightArray objectAtIndex:indexPath.section] sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(screen_width-20,2000.0f)lineBreakMode:NSLineBreakByCharWrapping];
    
    
    return size.height+20;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 8;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier = @"cellIdentifier";
    
    UITableViewCell *cell =  [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier]   ;
    
    
    
    
    NSString *topTxt;
    CGSize size;
    topTxt =[_heightArray objectAtIndex:indexPath.section];
    if (indexPath.section == 0){
        
        
        
        
        size = [topTxt sizeWithFont:[UIFont systemFontOfSize:15] constrainedToSize:CGSizeMake(screen_width-20,1000.0f)lineBreakMode:NSLineBreakByCharWrapping];
        
        _topLabel=[[UILabel alloc] init] ;
        [_topLabel setFrame:CGRectMake(10, 10, size.width, size.height)];
        _topLabel.numberOfLines = 0;
        _topLabel.text = topTxt;
        [_topLabel setTextAlignment:NSTextAlignmentLeft];
        [_topLabel setTextColor:[UIColor blackColor]];
        [_topLabel setFont:[UIFont boldSystemFontOfSize:15]];
        [_topLabel setBackgroundColor:[UIColor clearColor]];
        [cell addSubview:_topLabel];
        
        
    }
     if (indexPath.section == 1){
         
         
         
         size = [topTxt sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(screen_width-20,1000.0f)lineBreakMode:NSLineBreakByCharWrapping];
         
         _topLabel=[[UILabel alloc] init] ;
         [_topLabel setFrame:CGRectMake(10, 10, size.width, size.height)];
         _topLabel.numberOfLines = 0;
         _topLabel.text = topTxt;
         [_topLabel setTextAlignment:NSTextAlignmentLeft];
         [_topLabel setTextColor:[UIColor blackColor]];
         [_topLabel setFont:[UIFont boldSystemFontOfSize:14]];
         [_topLabel setBackgroundColor:[UIColor clearColor]];
         [cell addSubview:_topLabel];
     }
    
    
    if (indexPath.section == 2){
        
        
        
        
        
        size = [topTxt sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(screen_width-20,1000.0f)lineBreakMode:NSLineBreakByCharWrapping];
        
        _topLabel=[[UILabel alloc] init] ;
        [_topLabel setFrame:CGRectMake(10, 10, size.width, size.height)];
        _topLabel.numberOfLines = 0;
        _topLabel.text = topTxt;
        [_topLabel setTextAlignment:NSTextAlignmentLeft];
        [_topLabel setTextColor:[UIColor blackColor]];
        [_topLabel setFont:[UIFont boldSystemFontOfSize:14]];
        [_topLabel setBackgroundColor:[UIColor clearColor]];
        
        [cell addSubview:_topLabel];
        
        
        
        
        
        
    }
    
    if (indexPath.section == 3){
        
        
        
        size = [topTxt sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(screen_width-20,1000.0f)lineBreakMode:NSLineBreakByCharWrapping];
        
        _topLabel=[[UILabel alloc] init] ;
        [_topLabel setFrame:CGRectMake(10,10, size.width, size.height)];
        _topLabel.numberOfLines = 0;
        _topLabel.text = topTxt;
        [_topLabel setTextAlignment:NSTextAlignmentLeft];
        [_topLabel setTextColor:[UIColor blackColor]];
        [_topLabel setFont:[UIFont boldSystemFontOfSize:14]];
        [_topLabel setBackgroundColor:[UIColor clearColor]];
        [cell addSubview:_topLabel];
        
        
        
    }
    
    if (indexPath.section == 4){
        
        
        
        
        
        
        size = [topTxt sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(screen_width-20,1000.0f)lineBreakMode:NSLineBreakByCharWrapping];
        
        _topLabel=[[UILabel alloc] init] ;
        [_topLabel setFrame:CGRectMake(10, 10, size.width, size.height)];
        _topLabel.numberOfLines = 0;
        _topLabel.text = topTxt;
        [_topLabel setTextAlignment:NSTextAlignmentLeft];
        [_topLabel setTextColor:[UIColor blackColor]];
        [_topLabel setFont:[UIFont boldSystemFontOfSize:14]];
        [_topLabel setBackgroundColor:[UIColor clearColor]];
        [cell addSubview:_topLabel];
        
        
        
    }
    if (indexPath.section == 5){
        
        
        
        
        
        size = [topTxt sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(screen_width-20,1000.0f)lineBreakMode:NSLineBreakByCharWrapping];
        
        _topLabel=[[UILabel alloc] init] ;
        [_topLabel setFrame:CGRectMake(10, 10, size.width, size.height)];
        _topLabel.numberOfLines = 0;
        _topLabel.text = topTxt;
        [_topLabel setTextAlignment:NSTextAlignmentLeft];
        [_topLabel setTextColor:[UIColor blackColor]];
        [_topLabel setFont:[UIFont boldSystemFontOfSize:14]];
        [_topLabel setBackgroundColor:[UIColor clearColor]];
        [cell addSubview:_topLabel];
        
        
    }
    if (indexPath.section == 6){
        
        
        
        
        
        size = [topTxt sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(screen_width-20,1000.0f)lineBreakMode:NSLineBreakByCharWrapping];
        
        _topLabel=[[UILabel alloc] init] ;
        [_topLabel setFrame:CGRectMake(10, 10, size.width, size.height)];
        _topLabel.numberOfLines = 0;
        _topLabel.text = topTxt;
        [_topLabel setTextAlignment:NSTextAlignmentLeft];
        [_topLabel setTextColor:[UIColor blackColor]];
        [_topLabel setFont:[UIFont boldSystemFontOfSize:14]];
        [_topLabel setBackgroundColor:[UIColor clearColor]];
        [cell addSubview:_topLabel];
        
        
    }
    if (indexPath.section == 7){
        
        
        
        
        
        size = [topTxt sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(screen_width-20,1000.0f)lineBreakMode:NSLineBreakByCharWrapping];
        
        _topLabel=[[UILabel alloc] init] ;
        [_topLabel setFrame:CGRectMake(10, 10, size.width, size.height)];
        _topLabel.numberOfLines = 0;
        _topLabel.text = topTxt;
        [_topLabel setTextAlignment:NSTextAlignmentLeft];
        [_topLabel setTextColor:[UIColor blackColor]];
        [_topLabel setFont:[UIFont boldSystemFontOfSize:14]];
        [_topLabel setBackgroundColor:[UIColor clearColor]];
        [cell addSubview:_topLabel];
        
        
    }
    
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    
    return nil;
}

-(CGFloat)tableView:(UITableView*)tableView heightForHeaderInSection:(NSInteger)section
{
    return 35.0;
}


-(CGFloat)tableView:(UITableView*)tableView heightForFooterInSection:(NSInteger)section
{
    
        
        return  0.1f;
        
}

-(UIView*)tableView:(UITableView*)tableView viewForHeaderInSection:(NSInteger)section
{
    NSString *topTxt=@"";
    CGSize size;
    
    if (section == 0) {
         topTxt = @"  尊敬的客户:";
        size = [topTxt sizeWithFont:[UIFont fontWithName:@"Helvetica-Bold" size:18] constrainedToSize:CGSizeMake(screen_width-20,1000.0f)lineBreakMode:NSLineBreakByCharWrapping];
        _topLabel=[[UILabel alloc] init] ;
        [_topLabel setFrame:CGRectMake(10,10, size.width, size.height)];
        _topLabel.numberOfLines = 0;
        _topLabel.text = topTxt;
        [_topLabel setTextAlignment:NSTextAlignmentLeft];
        [_topLabel setTextColor:[UIColor blackColor]];
        [_topLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:18]];
        [_topLabel setBackgroundColor:[UIColor whiteColor]];
        return _topLabel;
        
    }
    if(section == 1){
        
        topTxt = @"第一条 168充值宝使用前提";
        
    }
    if(section == 2){
        
        topTxt = @"第二条 168充值宝密码和安全";
        
    }
    if(section == 3){
        
        topTxt = @"第三条 双方的权利义务";
        
    }
    if(section == 4){
        
        topTxt = @"第四条 免责事项";
        
    }
    if(section == 5){
        
        topTxt = @"第五条 法律适用及协议解释";
        
    }
    if(section == 6){
        
        topTxt = @"第六条 争议的解决";
        
    }
    if(section == 7){
        
        topTxt = @"第七条 协议生效和效力";
        
    }
    
    size = [topTxt sizeWithFont:[UIFont fontWithName:@"Helvetica-Bold" size:16] constrainedToSize:CGSizeMake(screen_width-20,1000.0f)lineBreakMode:NSLineBreakByCharWrapping];
    
    _topLabel=[[UILabel alloc] init] ;
    [_topLabel setFrame:CGRectMake(10, 10, size.width, size.height)];
    _topLabel.numberOfLines = 0;
    _topLabel.text = topTxt;
    [_topLabel setTextAlignment:NSTextAlignmentLeft];
    [_topLabel setTextColor:[UIColor blackColor]];
    [_topLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:16]];
    [_topLabel setBackgroundColor:[UIColor whiteColor]];
    return _topLabel;
    //
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




