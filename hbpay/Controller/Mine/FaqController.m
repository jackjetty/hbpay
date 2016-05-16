#import "FaqController.h"
#import "PlaceholderTextView.h"
#import "AppDelegate.h"
#import "MBProgressHUD.h"
#import "Utils.h"
#import "Public.h"
#import "TitleView.h"
#import "FaqExtendCellView.h"
#import "NetworkSingleton.h"
#import "Constant.h"
#import "FaqRstModel.h"
#import "FaqModel.h"
@interface FaqController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tableView;
    NSMutableArray  *_allFaqFrame;
   
}
@property (nonatomic,retain)  TitleView *titleView;
@property (nonatomic,strong) MBProgressHUD   *HUD;
@end

@implementation FaqController
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
    UIButton *backBtn = [UIButton buttonWithType: UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, (title_height+20-40)/2, 40, 40);
    [backBtn setImage:[UIImage imageNamed:@"tital_back"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(OnTapBackBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    _titleView = [[TitleView alloc] initWithFrame:@"帮助中心" leftMenuItem:backBtn rightMenuItem:nil ];
    [self.view addSubview:_titleView];

    
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, H(_titleView), W(_titleView),screen_height) style:UITableViewStylePlain];
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.dataSource = self;
    _tableView.delegate = self;
    
    [self.view addSubview:_tableView];
   
    NSDictionary *paraInfo = [NSDictionary dictionaryWithObjectsAndKeys: @"20", @"PageSize",@"1", @"PageIndex",nil];
    _HUD = [Utils createHUD];
    _HUD.labelText = @"";
    
    
    [[NetworkSingleton sharedManager] getFaq:paraInfo   successBlock:^(id responseBody){
        
        [_HUD hide:YES];
        FaqRstModel *faqRstModel = [FaqRstModel objectWithKeyValues:responseBody];
        FaqModel *faqModel;
        NSMutableArray *nsma =  [faqRstModel.listFaq mutableCopy];
         _allFaqFrame = [NSMutableArray array];
        for (int i = 0; i < faqRstModel.listFaq.count; i++) {
            faqModel= [FaqModel objectWithKeyValues:faqRstModel.listFaq[i]];
            [nsma replaceObjectAtIndex:i withObject:faqModel];
            faqModel.State=@"false";
            
            [_allFaqFrame addObject:faqModel];
        }
        faqRstModel.listFaq = [nsma copy];
        
        [_tableView reloadData];
        
        
    } failureBlock:^(NSString *error){
        
        _HUD = [Utils createHUD];
        _HUD.mode = MBProgressHUDModeCustomView;
        _HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"HUD-error"]];
        _HUD.labelText =error;
        [_HUD hide:YES afterDelay:1.0];
    }];
    
}


#pragma mark----tableViewDelegate
//返回几个表头
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return _allFaqFrame.count;
}

//每一个表头下返回几行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    
    
    FaqModel *faqModel=[_allFaqFrame objectAtIndex:section];
    
    if ([faqModel.State isEqualToString:@"true"]) {
        UIImageView *imageV = (UIImageView *)[_tableView viewWithTag:20000+section];
        imageV.image = [UIImage imageNamed:@"up_accessory.png"];
        return 1;
        
    }
    return 0;
}

//设置表头的高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 45;
}

//Section Footer的高度
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.2;
}

//设置view，将替代titleForHeaderInSection方法
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 30)];
    view.backgroundColor = [UIColor whiteColor];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, tableView.frame.size.width-35-10, 30)];
    FaqModel *faqModel=[_allFaqFrame objectAtIndex:section];
    
    
    
    [titleLabel setFont:[UIFont boldSystemFontOfSize:15]];
    titleLabel.text = faqModel.Title;
    [view addSubview:titleLabel];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(tableView.frame.size.width-30, 12, 25, 15)];
    imageView.tag = 20000+section;
    

    
    
    if ([faqModel.State isEqualToString:@"true"]) {
        imageView.image = [UIImage imageNamed:@"up_accessory.png"];
    }
    else
    {
        imageView.image = [UIImage imageNamed:@"down_accessory.png"];
    }
    [view addSubview:imageView];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, tableView.frame.size.width, 40);
    button.tag = 100+section;
    [button addTarget:self action:@selector(doButton:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:button];
    
    UIImageView *lineImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 39, tableView.frame.size.width, 1)];
    lineImage.image = [UIImage imageNamed:@"line.png"];
    [view addSubview:lineImage];
    return view;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{ 
    //
    FaqExtendCellView *cell = (FaqExtendCellView *) [self tableView:tableView cellForRowAtIndexPath:indexPath];
    return cell.contentView.frame.size.height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //当前是第几个表头
    FaqModel *faqModel=[_allFaqFrame objectAtIndex:indexPath.section];
    
    
    
        
        static NSString *CellIdentifier = @"MainCell";
        
        FaqExtendCellView *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        if (cell == nil) {
            cell = [[FaqExtendCellView alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            
            cell.selectionStyle = UITableViewCellSelectionStyleGray;
        }
        if ([faqModel.State isEqualToString:@"true"]) {
            [cell setLabelText: faqModel.Content];
        }
        
        
        return cell;
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [_tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSString *indexStr = [NSString stringWithFormat:@"%d",indexPath.section];
    
    NSIndexPath *path = nil;
    
    
    path = [NSIndexPath indexPathForItem:(indexPath.row+1) inSection:indexPath.section];
        
    
    
}

-(void)doButton:(UIButton *)sender
{
    NSString *string = [NSString stringWithFormat:@"%d",sender.tag-100];
    
    //数组selectedArr里面存的数据和表头想对应，方便以后做比较
    
    FaqModel *faqModel=[_allFaqFrame objectAtIndex:sender.tag-100];
    

    if ([faqModel.State isEqualToString:@"true"])
    {
        faqModel.State=@"false";
    }
    else
    {
        faqModel.State=@"true";
    }
    
    [_tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
- (void)OnTapBackBtn:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
