

#import <Foundation/Foundation.h>
#import "UIView+Util.h"
#import "UIColor+Util.h"
#import "UIImageView+Util.h"
#import "UIImage+Util.h"
#import "NSTextAttachment+Util.h"
#import "AFHTTPRequestOperationManager+Util.h"

#import "MBProgressHUD.h"

static NSString * const kKeyYears = @"years";
static NSString * const kKeyMonths = @"months";
static NSString * const kKeyDays = @"days";
static NSString * const kKeyHours = @"hours";
static NSString * const kKeyMinutes = @"minutes";

typedef NS_ENUM(NSUInteger, hudType) {
    hudTypeSendingTweet,
    hudTypeLoading,
    hudTypeCompleted
};
 

@interface Utils : NSObject

+ (NSDictionary *)emojiDict;

 
+ (NSDictionary *)timeIntervalArrayFromString:(NSString *)dateStr;
 
+ (NSString *)intervalSinceNow:(NSString *)dateStr;
+ (NSString *)getWeekdayFromDateComponents:(NSDateComponents *)dateComps;
+ (NSDateComponents *)getDateComponentsFromDate:(NSDate *)date;
+ (NSAttributedString *)emojiStringFromRawString:(NSString *)rawString;
+ (NSMutableAttributedString *)attributedStringFromHTML:(NSString *)HTML;
+ (NSData *)compressImage:(UIImage *)image;
+ (NSString *)convertRichTextToRawText:(UITextView *)textView;

+ (NSString *)escapeHTML:(NSString *)originalHTML;
+ (NSString *)deleteHTMLTag:(NSString *)HTML;

+ (BOOL)isURL:(NSString *)string;
+ (NSInteger)networkStatus;
+ (BOOL)isNetworkExist;

+ (CGFloat)valueBetweenMin:(CGFloat)min andMax:(CGFloat)max percent:(CGFloat)percent;

+ (MBProgressHUD *)createHUD;
+ (UIImage *)createQRCodeFromString:(NSString *)string;
 
+ (UIImageView *)imageViewWithFrame:(CGRect)frame withImage:(UIImage *)image;

+ (UILabel *)labelWithFrame:(CGRect)frame withTitle:(NSString *)title titleFontSize:(UIFont *)font textColor:(UIColor *)color backgroundColor:(UIColor *)bgColor alignment:(NSTextAlignment)textAlignment;


#pragma mark - alertView提示框
+(UIAlertView *)alertTitle:(NSString *)title message:(NSString *)msg delegate:(id)aDeleagte cancelBtn:(NSString *)cancelName otherBtnName:(NSString *)otherbuttonName;
#pragma mark - btnCreate
+(UIButton *)createBtnWithType:(UIButtonType)btnType frame:(CGRect)btnFrame backgroundColor:(UIColor*)bgColor;

#pragma mark isValidateEmail
+(BOOL)isValidateEmail:(NSString *)email;

+(BOOL)isPhoneNumber:(NSString *)phoneNumber;

+ (NSString *)md5:(NSString *)requestString;

+ (NSString *)encodeBase64String:(NSString *)requestString;

+ (NSString *)getStoreValue:(NSString *)storeKey;


+ (void)setStoreValue:(NSString *)storeKey storeValue:(NSString *)valueString;

+ (NSString *)trim:(NSString *)valueString;

+ (NSString *)encodeUTF8Str:(NSString *)valueString;


// 将JSON串转化为字典或者数组
+ (id)toArrayOrNSDictionary:(NSData *)jsonData;
+(id)toArrayOrNSDictionaryByStr:(NSString *)responseBody;

+ (NSString*)deviceString;
@end
