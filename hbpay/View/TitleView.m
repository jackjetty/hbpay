

#import "TitleView.h"
#import "Public.h"
@implementation TitleView

- (TitleView *)initWithFrame:(NSString *)title leftMenuItem:(UIView *)menuItem1 rightMenuItem:(UIView *)menuItem2
{
    self = [super initWithFrame:CGRectMake(0,0,screen_width,title_height)];
    if (self) {
        self.backgroundColor =  [UIColor clearColor];
        
        self.titleImageView=[[UIImageView alloc] init];
        self.titleImageView.frame = CGRectMake(0,  0 ,W(self) ,H(self));
        [self.titleImageView setImage:[UIImage imageNamed:@"header_bg"]];
        [self addSubview: self.titleImageView];
        
        
        
        
        self.centerLabel = [[UILabel alloc] initWithFrame:CGRectMake((W(self) - 200)/2, (H(self)+20 - 40)/2, 200, 40)];
        [self.centerLabel setText:title];
        [self.centerLabel setTextAlignment:NSTextAlignmentCenter];
        [self.centerLabel setTextColor:[UIColor whiteColor]];
        [self.centerLabel setFont:[UIFont boldSystemFontOfSize:18]];
        [self.centerLabel setBackgroundColor:[UIColor clearColor]];
        [self addSubview:self.centerLabel];
        
        if (menuItem1 != nil)
        {
            [self addSubview:menuItem1];
        }
        if (menuItem2 != nil)
        {
            [self addSubview:menuItem2];
        }

        
        self.userInteractionEnabled = YES;
        
    }
    return self;
}





@end

