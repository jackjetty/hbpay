#import "Tool.h"
#import "Utils.h"
static Tool *sharedObj = nil; //第一步：静态实例，并初始化。

BOOL isLogIn =  NO;

int messageNumber=0;

NSString *leftMoney=@"";

@implementation Tool

//phoneField.text = [[Tools sharedInstance] getPhoneNumber];


+ (Tool *) sharedInstance  //第二步：实例构造检查静态实例是否为nil
{
    @synchronized (self)
    {
        if (sharedObj == nil)
        {
            sharedObj = [[self alloc] init];
        }
    }
    return sharedObj;
}

-(BOOL)isLogIn
{
    return isLogIn;
}

-(void)setLongIn:(BOOL)logIn
{
    isLogIn = logIn;
}


-(int)getMessageNumber
{
    return messageNumber;
}

-(void)setMessageNumber:(int)messageNumber
{
    messageNumber = messageNumber;
}

-(void)setLeftMoney:(NSString *)leftmoney
{
    leftMoney = leftmoney;
}
-(NSString *)getLeftMoney
{
    return   [Utils trim:leftMoney]  ;
}


@end


