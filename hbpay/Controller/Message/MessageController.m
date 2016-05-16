
#import "MessageController.h"
#import "MessageFrame.h"
 
#import "MessageCell.h"
#import "Public.h"
#import "Utils.h"
#import "TitleView.h"
#import "NetworkSingleton.h" 
#import "Constant.h"
#import "MessageRstModel.h"
#import "MessageModel.h"
@interface MessageController  () <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>
{
    NSMutableArray  *_allMessagesFrame;
    UITableView *tableView;
    
}
@property ( nonatomic,retain) TitleView *titleView;
@property ( nonatomic, strong) MBProgressHUD   *HUD;

@end

@implementation MessageController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    self.view.backgroundColor = [UIColor whiteColor];
    //self.view.backgroundColor = [UIColor themeColor];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
    
    
         //[backView addSubview:backBtn];
    
    
    _titleView = [[TitleView alloc] initWithFrame:@"消 息" leftMenuItem:nil rightMenuItem:nil ];
    
    
    [self.view addSubview:_titleView];
    
    self.tableView=[[UITableView alloc] initWithFrame:CGRectMake(0, H(_titleView), screen_width,screen_height-H(_titleView)-30) style:UITableViewStylePlain];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.allowsSelection = NO;
    /*self.tableView.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"chat_bg_default.jpg"]];*/
    
    
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    [self.view addSubview:self.tableView];
    
    
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    //设置textField输入起始位置
    _messageField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 0)];
    _messageField.leftViewMode = UITextFieldViewModeAlways;
    
    _messageField.delegate = self;
    NSString *phoneNumberKey= [NSString stringWithFormat:STORE_PHONENUMBER];
    NSString *phoneNumber=[Utils getStoreValue:STORE_PHONENUMBER];
    
    
    NSDictionary *paraInfo = [NSDictionary dictionaryWithObjectsAndKeys:phoneNumber, @"PhoneNumber", @"20", @"PageSize",@"1", @"PageIndex",nil];
    
   
    _HUD = [Utils createHUD];
    _HUD.labelText = @"";
    
    [[NetworkSingleton sharedManager] getMessage:paraInfo   successBlock:^(id responseBody){
        
        
        [_HUD hide:YES];
        [[[[[self tabBarController] viewControllers] objectAtIndex: 1] tabBarItem] setBadgeValue:nil];
        MessageRstModel *messageRstModel = [MessageRstModel objectWithKeyValues:responseBody];
        MessageModel *messageModel;
        NSMutableArray *nsma =  [messageRstModel.Messages mutableCopy];
        
        for (int i = 0; i < messageRstModel.Messages.count; i++) {
            
            messageModel= [MessageModel objectWithKeyValues:messageRstModel.Messages[i]];
            
            [nsma replaceObjectAtIndex:i withObject:messageModel];
        }
        messageRstModel.Messages = [nsma copy];
        
        _allMessagesFrame = [NSMutableArray array];
         
        for ( messageModel in messageRstModel.Messages) {
            
            MessageFrame *messageFrame = [[MessageFrame alloc] init];
          
            messageFrame.showTime = true;
            messageFrame.messageModel = messageModel;
           
            [_allMessagesFrame addObject:messageFrame];
        }
       
        [self.tableView reloadData];
        
        
        
        
        
       } failureBlock:^(NSString *error){
        
        _HUD = [Utils createHUD];
        _HUD.mode = MBProgressHUDModeCustomView;
        _HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"HUD-error"]];
        _HUD.labelText =error;
        [_HUD hide:YES afterDelay:1.0];
    }];

}
#pragma mark - 键盘处理

 
#pragma mark 键盘即将显示
- (void)keyBoardWillShow:(NSNotification *)note{
    
    CGRect rect = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat ty = - rect.size.height;
    [UIView animateWithDuration:[note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue] animations:^{
        self.view.transform = CGAffineTransformMakeTranslation(0, ty);
    }];
    
}
#pragma mark 键盘即将退出
- (void)keyBoardWillHide:(NSNotification *)note{
    
    [UIView animateWithDuration:[note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue] animations:^{
        self.view.transform = CGAffineTransformIdentity;
    }];
}
#pragma mark - 文本框代理方法
#pragma mark 点击textField键盘的回车按钮
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    // 1、增加数据源
    NSString *content = textField.text;
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    NSDate *date = [NSDate date];
    fmt.dateFormat = @"MM-dd"; // @"yyyy-MM-dd HH:mm:ss"
    NSString *time = [fmt stringFromDate:date];
    //[self addMessageWithContent:content time:time];
    // 2、刷新表格
    [self.tableView reloadData];
    // 3、滚动至当前行
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:_allMessagesFrame.count - 1 inSection:0];
    [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    // 4、清空文本框内容
    _messageField.text = nil;
    return YES;
}




#pragma mark - tableView数据源方法

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  
    return _allMessagesFrame.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    MessageCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[MessageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // 设置数据
    cell.messageFrame = _allMessagesFrame[indexPath.row];
    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return [_allMessagesFrame[indexPath.row] cellHeight];
}

#pragma mark - 代理方法

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.view endEditing:YES];
}

#pragma mark - 语音按钮点击
- (IBAction)voiceBtnClick:(UIButton *)sender {
    if (_messageField.hidden) { //输入框隐藏，按住说话按钮显示
        _messageField.hidden = NO;
        _speakBtn.hidden = YES;
        [sender setBackgroundImage:[UIImage imageNamed:@"chat_bottom_voice_nor.png"] forState:UIControlStateNormal];
        [sender setBackgroundImage:[UIImage imageNamed:@"chat_bottom_voice_press.png"] forState:UIControlStateHighlighted];
        [_messageField becomeFirstResponder];
    }else{ //输入框处于显示状态，按住说话按钮处于隐藏状态
        _messageField.hidden = YES;
        _speakBtn.hidden = NO;
        [sender setBackgroundImage:[UIImage imageNamed:@"chat_bottom_keyboard_nor.png"] forState:UIControlStateNormal];
        [sender setBackgroundImage:[UIImage imageNamed:@"chat_bottom_keyboard_press.png"] forState:UIControlStateHighlighted];
        [_messageField resignFirstResponder];
    }
}



@end
