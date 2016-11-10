#import "DoTextField.h"
@interface DoTextField ()
@property(nonatomic,strong)TapDoneButton tapdonebutton;
@end
@implementation DoTextField
/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */
- (id)initWithFrame:(CGRect)frame
{
    if (self =[super initWithFrame:frame]) {
        // 初始化代码
        self.keyboardType = UIKeyboardTypeDecimalPad;
        UIToolbar * toobar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 38.0f)];
        toobar.translucent = YES;
        toobar.barStyle = UIBarStyleDefault;
        UIBarButtonItem * spaceBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
        UIBarButtonItem * doneBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(resignKeyboard:)];
        [toobar setItems:@[spaceBarButtonItem,doneBarButtonItem]];
        self.inputAccessoryView = toobar;
    }
    return self;
}
- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        self.keyboardType = UIKeyboardTypeDecimalPad;
        UIToolbar * toobar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 38.0f)];
        toobar.translucent = YES;
        toobar.barStyle = UIBarStyleDefault;
        UIBarButtonItem * spaceBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
        UIBarButtonItem * doneBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(resignKeyboard:)];
        [toobar setItems:@[spaceBarButtonItem,doneBarButtonItem]];
        self.inputAccessoryView = toobar;
    }
    return self;
}
- (void)resignKeyboard:(id)sender
{
    [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];
    if (self.tapdonebutton) {
        self.tapdonebutton(self);
    }
    if ([self.delegateMy respondsToSelector:@selector(didTapDoneButton:)]) {
        [self.delegateMy didTapDoneButton:self];
    }
}
-(void)tapDoneButtonBlock:(TapDoneButton)aBlock
{
    self.tapdonebutton = aBlock;
}
@end
