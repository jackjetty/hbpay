


#import "RecordController.h"
#import "SDRefresh.h"
#import "AppDelegate.h"
#import "MBProgressHUD.h"
#import "Utils.h"
#import "Public.h"
#import "Constant.h"
#import "TitleView.h"
#import "APRoundedButton.h"
#import "NetworkSingleton.h"
#import "LoginRstModel.h"
#import "SMSCodeRstModel.h"
#import "TradeModel.h"
#import "TradeRstModel.h"
#import "TradeCellView.h"
@interface RecordController ()<UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>{
    
}

@property (nonatomic, weak) SDRefreshFooterView *refreshFooter;
@property (nonatomic, weak) SDRefreshHeaderView *refreshHeader;
@property (nonatomic, assign) NSInteger pageIndex;
@property (nonatomic, strong) MBProgressHUD       *HUD;
@property (nonatomic,retain)  TitleView *titleView;


@property (nonatomic,retain)  NSMutableArray  *allTradeList;
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation RecordController

/*
- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        //self.title = @"上拉和下拉刷新";
       self.tableView.rowHeight = 60.0f;
        self.tableView.separatorColor = [UIColor whiteColor];
        // 模拟数据
        _totalRowCount = 3;X
    }
    return self;
}*/

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
    UIButton *backBtn = [UIButton buttonWithType: UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, (title_height+20-40)/2, 40, 40);
    [backBtn setImage:[UIImage imageNamed:@"tital_back"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(OnTapBackBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    _titleView = [[TitleView alloc] initWithFrame:@"充值记录" leftMenuItem:backBtn rightMenuItem:nil ];
    [self.view addSubview:_titleView];
    _pageIndex = 1;
    
    
    
    self.tableView=[[UITableView alloc] initWithFrame:CGRectMake(0, H(_titleView), screen_width,screen_height-H(_titleView)) style:UITableViewStylePlain];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.tableView.allowsSelection = NO;
    /*self.tableView.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"chat_bg_default.jpg"]];*/
    
    
    self.allTradeList = [[NSMutableArray alloc] init];
    
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    [self.view addSubview:self.tableView];
    
    
    
    [self setupHeader];
    [self setupFooter];
}


- (void)setupHeader
{
    SDRefreshHeaderView *refreshHeader = [SDRefreshHeaderView refreshView];
    
    [refreshHeader addToScrollView:self.tableView];
  
    
    
    __weak SDRefreshHeaderView *weakRefreshHeader = refreshHeader;
    refreshHeader.beginRefreshingOperation = ^{
        
        _pageIndex=1;
        
        [self getTableData:_pageIndex sdRefreshHeaderView:weakRefreshHeader];
        //[weakRefreshHeader endRefreshing];
     };
    
    // 进入页面自动加载一次数据
    
    [refreshHeader beginRefreshing];
}

- (void)setupFooter
{
    SDRefreshFooterView *refreshFooter = [SDRefreshFooterView refreshView];
    [refreshFooter addToScrollView:self.tableView];
    [refreshFooter addTarget:self refreshAction:@selector(footerRefresh)];
    _refreshFooter = refreshFooter;
}


-(void) getTableData:(int )pageIndex sdRefreshHeaderView: (SDRefreshHeaderView *)weakRefreshHeader{
 
    
    NSString *phoneNumber=[Utils getStoreValue:STORE_PHONENUMBER];
    
    NSDictionary *paraInfo = [NSDictionary dictionaryWithObjectsAndKeys:phoneNumber, @"PhoneNumber",  [NSString stringWithFormat:@"%d",pageIndex], @"PageIndex",nil];
 
    [[NetworkSingleton sharedManager] getTradeList:paraInfo   successBlock:^(id responseBody){
        //NSLog(@"%@",responseBody);
        TradeRstModel *tradeRstModel = [TradeRstModel objectWithKeyValues:responseBody];
        TradeModel *tradeModel;
       
        NSMutableArray *nsma =  [tradeRstModel.listRecord mutableCopy];
        
        for (int i = 0; i < tradeRstModel.listRecord.count; i++) {
            
            tradeModel= [TradeModel objectWithKeyValues: tradeRstModel.listRecord[i]];
            
            [nsma replaceObjectAtIndex:i withObject:tradeModel];
        }
        tradeRstModel.listRecord = [nsma copy];
        
        
        if(_pageIndex==1)
              self.allTradeList = [NSMutableArray array];
        
        for ( tradeModel in tradeRstModel.listRecord ) {
            [self.allTradeList addObject:tradeModel];
        }
        [self.tableView reloadData];
        if(weakRefreshHeader!=nil)
            [weakRefreshHeader endRefreshing];
        
        
        
        
        
        
        
        
    } failureBlock:^(NSString *error){
        
        _HUD = [Utils createHUD];
        _HUD.mode = MBProgressHUDModeCustomView;
        _HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"HUD-error"]];
        _HUD.labelText =error;
        [_HUD hide:YES afterDelay:1.0];
    }];

}

- (void)footerRefresh
{
 
        _pageIndex++;
        [self getTableData:_pageIndex sdRefreshHeaderView:self.refreshFooter];
        
    
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.allTradeList count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 75.f;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"test";
    TradeCellView  *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        cell = [[TradeCellView alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.backgroundView = nil;
       // cell.textLabel.textColor = [UIColor  blackColor];
    }
    TradeModel *tradeModel=[self.allTradeList objectAtIndex:indexPath.row];
    
   
    //cell.backgroundColor = [self randomColor];
    
    
    if([tradeModel.businessType isEqualToString:QCOINBUSID] && [tradeModel.rechargeResult isEqualToString:@"0"]){
        cell.imageIcon.image =  PNGIMAGE(@"success_charge");
        
    }
    if([tradeModel.businessType isEqualToString:QCOINBUSID] && ![tradeModel.rechargeResult isEqualToString:@"0"]){
        cell.imageIcon.image =  PNGIMAGE(@"fail_charge");
        
    }
    
    
    if([tradeModel.businessType isEqualToString:VCOINBUSID] && [tradeModel.rechargeResult isEqualToString:@"0"]){
        cell.imageIcon.image =  PNGIMAGE(@"success_vcoin");
        
    }
    
    if([tradeModel.businessType isEqualToString:VCOINBUSID] && ![tradeModel.rechargeResult isEqualToString:@"0"]){
        cell.imageIcon.image =  PNGIMAGE(@"fail_vcoin");
        
    }
    
    
    
    if([tradeModel.businessType isEqualToString:QMONTHBUSID] && [tradeModel.rechargeResult isEqualToString:@"0"]){
        cell.imageIcon.image =  PNGIMAGE(@"success_month");
        
    }
    
    if([tradeModel.businessType isEqualToString:QMONTHBUSID] && ![tradeModel.rechargeResult isEqualToString:@"0"]){
        cell.imageIcon.image =  PNGIMAGE(@"fail_month");
        
    }
    
    
    if([tradeModel.businessType isEqualToString:QMEMBERBUSID] && [tradeModel.rechargeResult isEqualToString:@"0"]){
        cell.imageIcon.image =  PNGIMAGE(@"success_member");
        
    }
    
    if([tradeModel.businessType isEqualToString:QMEMBERBUSID] && ![tradeModel.rechargeResult isEqualToString:@"0"]){
        cell.imageIcon.image =  PNGIMAGE(@"fail_member");
        
    }
    
    if([tradeModel.businessType isEqualToString:FLOWBUSID] && [tradeModel.rechargeResult isEqualToString:@"0"]){
        cell.imageIcon.image =  PNGIMAGE(@"success_flow");
        
    }
    
    if([tradeModel.businessType isEqualToString:FLOWBUSID] && ![tradeModel.rechargeResult isEqualToString:@"0"]){
        cell.imageIcon.image =  PNGIMAGE(@"fail_flow");
        
    }
    
    
    if([tradeModel.businessType isEqualToString:BILLBUSID] && [tradeModel.rechargeResult isEqualToString:@"0"]){
        cell.imageIcon.image =  PNGIMAGE(@"success_bill");
        
    }
    
    if([tradeModel.businessType isEqualToString:BILLBUSID] && ![tradeModel.rechargeResult isEqualToString:@"0"]){
        cell.imageIcon.image =  PNGIMAGE(@"fail_bill");
        
    }
    
    
    
    
    
    
    cell.titleLabel.text =  tradeModel.rechargeType;
    
    if([tradeModel.rechargeResult isEqualToString:@"0"])
           cell.stateLabel.text = @"成功";
    else
           cell.stateLabel.text = @"失败";
    
    cell.accountLabel.text= [NSString stringWithFormat:@"充值账号：%@",tradeModel.rechargeNumber];
    
    cell.balanceLabel.text =  [NSString stringWithFormat:@"面额：%.00f 金额：%.02f    %@", [tradeModel.parvalue floatValue], [tradeModel.orderAmount floatValue],tradeModel.rechargeTime] ;
   //
    // float floatString = [newString floatValue];
   
    //NSString *stringFloat = [NSString stringWithFormat:@"%f",intString];
    return cell;
}



- (void)dealloc
{
    [self.refreshHeader removeFromSuperview];
    [self.refreshFooter removeFromSuperview];
}
- (void)OnTapBackBtn:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
    
}

@end
