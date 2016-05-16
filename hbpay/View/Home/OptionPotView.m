

#import "OptionPotView.h"
#import "Public.h"
#import "Utils.h"
@implementation OptionPotView

- (OptionPotView *)initWithFrame:(CGRect)frame optionPot:(OptionPotModel *)optionPotModel
{
    self = [super initWithFrame:frame];
    if (self) {
        
        
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = 8.0; 
        
        //用户名
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, W(self), 25)];
        self.titleLabel.font = [UIFont systemFontOfSize:15];
        self.titleLabel.text = optionPotModel.optionTitle;
        self.titleLabel.textAlignment = UITextAlignmentCenter;
        [self addSubview:self.titleLabel];
        //账户余额
        self.discountLabel = [[UILabel alloc] initWithFrame:CGRectMake((W(self)-80)/2, H(self)-22, 80, 20)];
        self.discountLabel.font = [UIFont systemFontOfSize:10];
        if([optionPotModel.optionDiscout isEqualToString:@""]){
            
            self.discountLabel.text=@"";
            self.titleLabel.frame=CGRectMake( 0, (H(self)-25)/2,W(self), 25);
            
        }else{
            //[NSString stringWithFormat:@"[%@]",   optionPotModel.optionDiscout]
            self.discountLabel.text=    optionPotModel.optionDiscout ;
            self.titleLabel.frame=CGRectMake( 0, 0, W(self), 25);
        }
        
        self.discountLabel.textAlignment = UITextAlignmentCenter;
        
        [self addSubview:self.discountLabel];
        
        if(optionPotModel.optionSelected){
            self.discountLabel.textColor=[UIColor whiteColor];
            self.titleLabel.textColor=[UIColor whiteColor];
             self.backgroundColor=RGB(84,188,223);
            //26, 140, 217
            //
        }else{
            self.discountLabel.textColor=RGB(244, 130, 33);
            self.titleLabel.textColor=RGB(180, 190, 195);
            self.backgroundColor=RGB(221, 225, 234);
        }
        
        
        self.userInteractionEnabled = YES;
        
    }
    return self;
}
-(void)setPotSelect:(BOOL *)optionSelected{
    if(optionSelected){
        self.discountLabel.textColor=[UIColor whiteColor];
        self.titleLabel.textColor=[UIColor whiteColor];
        self.backgroundColor=RGB(84,188,223);
    }else{
        self.discountLabel.textColor=RGB(244, 130, 33);
        self.titleLabel.textColor=RGB(180, 190, 195);
        self.backgroundColor=RGB(221, 225, 234);
    }
}
-(void)setPotDiscount:(NSString *)potDiscount{
    potDiscount=[Utils trim:potDiscount];
    if([potDiscount isEqualToString:@""]){
        
        self.discountLabel.text=@"";
        
        self.titleLabel.frame=CGRectMake(0, (H(self)-25)/2,W(self), 25);
        
    }else{
        self.discountLabel.text=   potDiscount ;
        self.titleLabel.frame=CGRectMake(0, 0, W(self), 25);
    }

    
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

