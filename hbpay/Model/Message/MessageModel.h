#import <Foundation/Foundation.h>

@interface MessageModel : NSObject

//{"Time":"2014-12-19 00:00","Type":"PUBLICINFO","Content":"温馨提醒：亲们，电信170、177号段于12月19日起可以充值啦！"}



@property(nonatomic, strong) NSString *Time;

@property(nonatomic, strong) NSString *Type;

@property(nonatomic, strong) NSString *Content;

@end