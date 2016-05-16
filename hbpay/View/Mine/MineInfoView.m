

#import "MineInfoView.h"
#import "Public.h"

@implementation MineInfoView

- (MineInfoView *)initWithFrame:(CGRect)frame userLabel:(NSString *)useText
{
    self = [super initWithFrame:frame];
    if (self) { 
        self.backgroundColor = [UIColor colorWithPatternImage: [UIImage imageNamed:@"bg_login"]];
        //头像
        self.userImage = [[UIImageView alloc] initWithFrame:CGRectMake((H(self)-50)/2, (H(self)-50)/2, 50, 50)];
        self.userImage.layer.masksToBounds = YES;
        self.userImage.layer.cornerRadius = 27;
        [self.userImage setImage:[UIImage imageNamed:@"header"]];
        [self addSubview:self.userImage];
        //用户名
        self.userNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(10+50+20, 15, 200, 20)];
        self.userNameLabel.font = [UIFont systemFontOfSize:15];
        self.userNameLabel.text = useText;
        [self addSubview:self.userNameLabel];
        //账户余额
        self.moneyLabel = [[UILabel alloc] initWithFrame:CGRectMake(10+50+20, H(self)-20-15, 200, 20)];
        self.moneyLabel.font = [UIFont systemFontOfSize:12];
        self.moneyLabel.textColor = [UIColor lightGrayColor];
        self.moneyLabel.text = @"话费余额：0.00元";
        [self addSubview:self.moneyLabel]; 
        
        UIImageView *arrowImg = [[UIImageView alloc] initWithFrame:CGRectMake(screen_width-10-20,( H(self)-20)/2, 12, 20)];
        [arrowImg setImage:[UIImage imageNamed:@"icon_mine_accountViewRightArrow"]];
         
        [self addSubview: arrowImg];
        
        self.userInteractionEnabled = YES;
        
    }
    return self;
}

#pragma mark - UIResponder

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    //NSLog(@"click1self123");
    //UITouch *touch = [touches anyObject];
    //CGPoint touchLocatin = [touch locationInView:self];
    
    
    
}




@end

