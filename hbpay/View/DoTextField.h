    #import <UIKit/UIKit.h>
    @class DoTextField;
    typedef void(^TapDoneButton)(DoTextField * DoTextField);
    @protocol DoTextFieldDelegate;
    @interface DoTextField : UITextField
    @property(nonatomic,weak)id<DoTextFieldDelegate>delegateMy;
    -(void)tapDoneButtonBlock:(TapDoneButton)aBlock;
    @end
    @protocol DoTextFieldDelegate <NSObject>
    @optional
    -(void)didTapDoneButton:(DoTextField *)textfield;



    @end
