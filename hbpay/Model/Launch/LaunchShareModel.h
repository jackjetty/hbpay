#import <Foundation/Foundation.h>

@interface LaunchShareModel : NSObject

//{"siteUrl":"http://www.zj114.net.cn/168/","site":"168充值宝","content":"168充值宝发福利啦，即日起至7.31首次直充Q币即可享9折优惠， www.zj114.net.cn/168  还不赶快行动！","title":"168充值宝","titleUrl":"http://www.zj114.net.cn/168/","imageUrl":"http://115.239.134.175/AppServer/images/9zhe.jpg"}



@property(nonatomic, strong) NSString *siteUrl;

@property(nonatomic, strong) NSString *site;

@property(nonatomic, strong) NSString *content;

@property(nonatomic, strong) NSString *title;

@property(nonatomic, strong) NSString *titleUrl;

@property(nonatomic, strong) NSString *imageUrl;

@end