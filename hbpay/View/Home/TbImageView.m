
#import "TbImageView.h"
#import "Public.h"
#import "HomeCellModel.h"
#import "Utils.h"
@implementation TbImageView

- (TbImageView *)initWithFrame:(CGRect)frame CellModel:(HomeCellModel *)homeCellModel
{
    self = [super initWithFrame:frame];
    if (self) {
        
      
        
        // [bgImageView setImage:[UIImage imageNamed:@"img_load"]];

        
         self.backgroundColor = homeCellModel.bgColor  ; 
        
        
        _cellId=[Utils trim:homeCellModel.cellId];
        
        self.centerImageView=[[UIImageView alloc] init];
        self.centerImageView.frame = CGRectMake( (W(self)-3*H(self)/8)/2  ,    H(self)/10 +20 , 3*H(self)/8, 3*H(self)/8);
        [self.centerImageView setImage:[UIImage imageNamed:homeCellModel.imageName]];
        
        [self addSubview: self.centerImageView];
        
        /*
         [imgShadow.layer setShouldRasterize:NO];
         
         // 设置边框颜色
         [imgShadow.layer setBorderColor: [[UIColor whiteColor] CGColor]];
         // 设置边框宽度
         [imgShadow.layer setBorderWidth: 1.0];
         // 设置投影偏移量，CGSizeMake(x轴方向, y轴方向)
         [[imgShadow layer] setShadowOffset:CGSizeMake(1, 1)];
         // 设置投影颜色
         [[imgShadow layer] setShadowColor:[UIColor redColor].CGColor];
         // 设置投影半径
         [[imgShadow layer] setShadowRadius:3];
         // 设置透明度
         [[imgShadow layer] setShadowOpacity:1];*/
      
        
        self.productLabel=[[UILabel alloc] init];
        self.productLabel.frame = CGRectMake(H(self)/16,  H(self)/16, W(self), 20);
        self.productLabel.textAlignment = NSTextAlignmentLeft;
        self.productLabel.font = [UIFont fontWithName:@"Helvetica" size:12];
        self.productLabel.backgroundColor = [UIColor clearColor];
        self.productLabel.textColor = [UIColor whiteColor];
        self.productLabel.text = homeCellModel.productName;
        
        [self addSubview: self.productLabel];
        
        
        self.rebatLabel=[[UILabel alloc] init];
        self.rebatLabel.frame = CGRectMake(H(self)/16, H(self) -15-H(self)/16, W(self)-2*H(self)/16, 15);
        self.rebatLabel.textAlignment = NSTextAlignmentRight;
        self.rebatLabel.font = [UIFont fontWithName:@"Helvetica" size:11];
        self.rebatLabel.backgroundColor = [UIColor clearColor];
        self.rebatLabel.textColor = [UIColor whiteColor];
        self.rebatLabel.text = homeCellModel.productTip;
        [self addSubview: self.rebatLabel];
        self.userInteractionEnabled = YES;
        
        
    }
    return self;
}



- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    //NSLog(@"click_Cell");
    //UITouch *touch = [touches anyObject];
    //CGPoint touchLocatin = [touch locationInView:self];
    [self.delegate  didSelectTbImage:_cellId];
    
    
}





@end

