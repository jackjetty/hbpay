#import "ExpandTableCellView.h"
#import "Utils.h"
#import "Public.h"
@implementation ExpandTableCellView
//只在第一次加载界面的时候调用里面的东西，不会调用多次，所以要是改变值之类的东西操作，不能放在里面
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier faqModel:(FaqModel  *)faqModel indexPath:(NSIndexPath *) indexPath
{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        
        self.selectedCellIndexPath=indexPath;
        
        self.cellHight=0;
        
        
        CGSize size;
        size = [faqModel.Title sizeWithFont:[UIFont systemFontOfSize:15] constrainedToSize:CGSizeMake(screen_width-10,1000.0f)lineBreakMode:NSLineBreakByCharWrapping];
        self.titleLabel = [Utils labelWithFrame:CGRectMake(5.f, 5.f, size.width, size.height) withTitle:@"" titleFontSize:[UIFont systemFontOfSize:15.f] textColor:[UIColor blackColor] backgroundColor:[UIColor clearColor] alignment:NSTextAlignmentLeft];
        
        self.titleLabel.numberOfLines = 0;
        _titleLabel.text = faqModel.Title;
        [self.titleLabel setTextAlignment:NSTextAlignmentLeft];
        [self.titleLabel setTextColor:[UIColor blackColor]];
        [self.titleLabel setFont:[UIFont systemFontOfSize:15]];
        [self.titleLabel setBackgroundColor:[UIColor clearColor]];
        
        
        [self.contentView addSubview:self.titleLabel];
        self.detailLabel=[Utils labelWithFrame:CGRectMake(H(_titleLabel), 10, screen_width-20, 0.1f) withTitle:@"" titleFontSize:[UIFont systemFontOfSize:13.f] textColor:[UIColor blackColor] backgroundColor:[UIColor clearColor] alignment:NSTextAlignmentLeft];
        
        
        self.detailLabel.numberOfLines = 0;
        _detailLabel.text = faqModel.Content;
        [self.detailLabel setTextAlignment:NSTextAlignmentLeft];
        [self.detailLabel setTextColor:[UIColor lightGrayColor]];
        [self.detailLabel setFont:[UIFont systemFontOfSize:13]];
        [self.detailLabel setBackgroundColor:[UIColor clearColor]];
        [self.contentView addSubview:self.detailLabel];
        [self.detailLabel setHidden:true];
        
        
        
        
        
        
        
        _button= [UIButton buttonWithType:UIButtonTypeCustom];
        _button.frame = CGRectMake( (screen_width-14)/2, _cellHight+5, 14, 8.f);
        [_button addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
        
        size= _detailLabel.frame.size;
        if([faqModel.State isEqualToString:@"false"]){
            [_button setImage:[UIImage imageNamed:@"comment_arrow_down@2x"] forState:UIControlStateNormal];
            
            [self.detailLabel setFrame:CGRectMake(10, H(_titleLabel)+10, size.width,0)];
            [self.detailLabel setHidden:true];

            
        }else{
            [_button setImage:[UIImage imageNamed:@"channel_nav_arrow@2x"] forState:UIControlStateNormal];
            size = [_detailLabel.text sizeWithFont:[UIFont systemFontOfSize:13] constrainedToSize:CGSizeMake(screen_width-20,1000.0f)lineBreakMode:NSLineBreakByCharWrapping];
            
            [self.detailLabel setFrame:CGRectMake(10, H(_titleLabel)+10, size.width, size.height)];
            [self.detailLabel setHidden:false];
        }
        _cellHight=H(_titleLabel) +H(_detailLabel)+15;
        _button.frame = CGRectMake( (screen_width-14)/2, _cellHight+5, 14, 8.f);
       [_button setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
        
        [self.contentView addSubview:_button];
        
        _cellHight=Y(_button)+8+5;
        
        
        
    }
    return self;
}
- (void)clickButton:(UIButton*)sender {
    //sender.selected = !sender.selected;
    
     [self.delegate  didSelectExpandTableCell: self.selectedCellIndexPath];
    
}
@end
