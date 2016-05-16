

#import "MineImageView.h"
#import "Public.h"
#import "MineCellModel.h"
#import "LoginController.h"


#define UISCREENWIDTH  self.bounds.size.width//广告的宽度
#define UISCREENHEIGHT  self.bounds.size.height//广告的高度
#define HIGHT self.bounds.origin.y
#define WIDTH self.bounds.origin.x




@implementation MineImageView

- (MineImageView *)initWithFrame:(CGRect)frame CellModel:(MineCellModel *)mineCellModel
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor =  [UIColor whiteColor];
        //self.bgImageView = [[UIImageView alloc] initWithFrame:frame];
        //self.bgImageView.backgroundColor =  [UIColor whiteColor];
       
        
        //UISCREENWIDTH
        //UISCREENWIDTH
        
        self.centerImageView=[[UIImageView alloc] init];
       // self.centerImageView.frame = CGRectMake(20,  8 ,W(self)- 40, H(self)-34);
        
        self.centerImageView.frame = CGRectMake((W(self)-45)/2, (H(self)-75)/2, 45, 50);
        [self.centerImageView setImage:[UIImage imageNamed:mineCellModel.imageName]];
        //
        
        [self addSubview: self.centerImageView];
        
        self.mineLabel=[[UILabel alloc] init];
        self.mineLabel.frame = CGRectMake(0, (H(self)-75)/2+55, W(self), 20);
        self.mineLabel.textAlignment = NSTextAlignmentCenter;
        self.mineLabel.font = [UIFont fontWithName:@"Helvetica" size:14];
        self.mineLabel.backgroundColor = [UIColor clearColor];
        self.mineLabel.textColor = [UIColor colorWithRed:76/255.0 green:184/255.0 blue:255/255.0 alpha:0.85];
        self.mineLabel.text = mineCellModel.mineTitle;
        [self addSubview: self.mineLabel];
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
     //NSLog(@"click12123123");
     [self.delegate  didSelectMineImage];
    
    return;

    //UITouch *touch = [touches anyObject];
    //CGPoint touchLocatin = [touch locationInView:self];

    
    
} 




@end

