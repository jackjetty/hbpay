//
//  NetworkSingleton.m
//  tudou
//
//  Created by jinzelu on 15/6/3.
//  Copyright (c) 2015年 jinzelu. All rights reserved.
//

#import "NetworkSingleton.h"
#import "AppDelegate.h"
#import "RegexKitLite.h"
#import "MJExtension.h"
#import "GTMBase64.h"
#import <CommonCrypto/CommonDigest.h>
@implementation NetworkSingleton

+(NetworkSingleton *)sharedManager{
    static NetworkSingleton *sharedNetworkSingleton = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate,^{
        sharedNetworkSingleton = [[self alloc] init];
    });
    return sharedNetworkSingleton;
}
-(AFHTTPRequestOperationManager *)baseHtppRequest{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager.requestSerializer setTimeoutInterval:TIMEOUT];
    //header 设置
    //    [manager.requestSerializer setValue:K_PASS_IP forHTTPHeaderField:@"Host"];
    //    [manager.requestSerializer setValue:@"max-age=0" forHTTPHeaderField:@"Cache-Control"];
    //    [manager.requestSerializer setValue:@"text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8" forHTTPHeaderField:@"Accept"];
    //    [manager.requestSerializer setValue:@"zh-cn,zh;q=0.8,en-us;q=0.5,en;q=0.3" forHTTPHeaderField:@"Accept-Language"];
    //    [manager.requestSerializer setValue:@"gzip, deflate" forHTTPHeaderField:@"Accept-Encoding"];
    //    [manager.requestSerializer setValue:@"keep-alive" forHTTPHeaderField:@"Connection"];
    //AFJSONRequestSerializer
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    
    
    
    //@"ios_c6.9_iphone5"
    
    [manager.requestSerializer setValue:[NSString stringWithFormat:@"ios_c%0.2f_%@", [[[UIDevice currentDevice]systemVersion]floatValue],[Utils deviceString]] forHTTPHeaderField:@"User-Agent"];
 
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", @"text/html", @"application/json", nil];
    return manager;
}

#pragma mark - 检测网络连接
- (BOOL)isConnectionAvailable
{
    
    BOOL isExistenceNetwork = YES;
    Reachability *reach = [Reachability reachabilityWithHostName:@"www.baidu.com"];
    switch ([reach currentReachabilityStatus]) {
        case NotReachable:
            isExistenceNetwork = NO;
            //NSLog(@"notReachable");
            break;
        case ReachableViaWiFi:
            isExistenceNetwork = YES;
            //NSLog(@"WIFI");
            break;
        case ReachableViaWWAN:
            isExistenceNetwork = YES;
            //NSLog(@"3G");
            break;
    }
    
    if (!isExistenceNetwork) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"当前网络不可用,请检查网络连接!" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alertView show];
        
        //        [SVProgressHUD dismiss];
        return NO;
        
    }else{
        
        return isExistenceNetwork;
        
    }
    return YES;
}

//解密
-(NSString *)decodeResponse:(NSData *)responseObject{
    NSString *result = [[NSString alloc] initWithData:responseObject encoding:NSASCIIStringEncoding];
    NSString *receiveString = [result stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [GTMBase64 decodeString:receiveString];
    
    NSString *base64DecodeString = [[NSString alloc] initWithBytes:[data bytes] length:[data length] encoding:NSUTF8StringEncoding];
    
    
    
    NSString *regexString       = @"^(.+)(&md5).+$";
    
    NSString *replaceWithString = @"$1";
    base64DecodeString = [base64DecodeString stringByReplacingOccurrencesOfRegex:regexString withString:replaceWithString];
    NSMutableString *outputStr = [NSMutableString stringWithString:base64DecodeString];
    
    [outputStr replaceOccurrencesOfString:@"+"
     
                               withString:@" "
     
                                  options:NSLiteralSearch
     
                                    range:NSMakeRange(0, [outputStr length])];
    
    NSString *responseString=[outputStr stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    return responseString;
    
}
/*
- (NSString *)md5:(NSString *)requestString
{
    const char *original_str = [requestString UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH] = {0};
    CC_MD5(original_str, (unsigned int)strlen(original_str), result);
    
    // NSString * hash = [GTMBase64 stringByEncodingBytes:result length:16];
    //
    NSMutableString *hash = [NSMutableString string];
    for (int nIndex = 0; nIndex < CC_MD5_DIGEST_LENGTH; nIndex++)
    {
        [hash appendFormat:@"%02X",result[nIndex]];
    }
    
    NSString *restr =[[hash lowercaseString] substringWithRange:NSMakeRange(8, 16)];
    
    return restr;
}


//加密
-(NSString *)encryptStr:(NSString *)requestString
{
    NSMutableString *tappendString = [NSMutableString stringWithString:requestString];
    [tappendString appendString:@"&key=dhfHa99SdfiMasYY"];
    NSString *md5String= [self md5:tappendString];
    NSMutableString *appendString = [NSMutableString stringWithString:requestString];
    [appendString appendFormat:@"&md5=%@",md5String];
    NSString *base64String = [GTMBase64 stringByEncodingBytes:[appendString UTF8String] length:[appendString lengthOfBytesUsingEncoding:NSUTF8StringEncoding]];
 
    
    NSString *urlString = (NSString*)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(nil,
                                                                                               
                                                                                               (CFStringRef)base64String, nil,
                                                                                               
                                                                                               (CFStringRef)@"!*'();:@&=+$,/?%#[]", kCFStringEncodingUTF8));
    
 
    return urlString;
    
}
//参数
- (NSString*) parseXML:(NSDictionary *)paraInfo {
    
    NSMutableString *xmlString = [[NSMutableString alloc] initWithString:@"<?xml version='1.0' encoding='utf-8'?>"];
    [xmlString appendString:@"<mcp type='request'>"];
    [xmlString appendString:@"<params>"];
    
    
    NSArray *keys;
    int i, count;
    id key, value;
    
    keys = [paraInfo allKeys];
    count = [keys count];
    for (i = 0; i < count; i++)
    {
        key = [keys objectAtIndex: i];
        value = [paraInfo objectForKey: key];
        [xmlString appendFormat:@"<param id='%@' value='%@'/>", key, value];
        
    }
    
   [xmlString appendString:@"</params></mcp>"];
    NSLog(@"%@",xmlString);
    return [self encryptStr:xmlString];
    
}*/




#pragma mark 获取首页信息
-(void)getHomeResule:(NSDictionary *)paraInfo  successBlock:(SuccessBlock)successBlock failureBlock:(FailureBlock)failureBlock{
    if (![self isConnectionAvailable]) {
       
        return;
    }
    AFHTTPRequestOperationManager *manager = [self baseHtppRequest];
    NSString *url   = [[NSString alloc] initWithFormat:@"%@%@", SERVERURL, @"/android/homePage?version=2.0" ];
    
    NSString *urlStr = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [manager POST:urlStr parameters:paraInfo success:^(AFHTTPRequestOperation *operation, id responseObject){ 
        successBlock([self decodeResponse:responseObject]);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error){
       
         NSLog(@"%@",error.description);
        failureBlock(@"网络连接失败");
    }];
}




#pragma mark 获取消息
-(void)getMessage:(NSDictionary *)paraInfo   successBlock:(SuccessBlock)successBlock failureBlock:(FailureBlock)failureBlock{
    
    if (![self isConnectionAvailable]) {
        
        return;
    } 
    AFHTTPRequestOperationManager *manager = [self baseHtppRequest];
    
    NSString *url   = [[NSString alloc] initWithFormat:@"%@%@", SERVERURL, @"/publicInfo/getMessage" ];
    
    //NSLog(@"%@",[self parseXML:paraInfo]);
    
    //;

    
    NSString *urlStr = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [manager POST:urlStr parameters:paraInfo success:^(AFHTTPRequestOperation *operation, id responseObject ){
        successBlock([self decodeResponse:responseObject] );
    } failure:^(AFHTTPRequestOperation *operation, NSError *error){
        
        //NSLog(@"%@",error.description);
        failureBlock(@"网络连接失败");
    }];

    
    
    
    
}

#pragma mark 获取分类信息

-(void)getFaq:(NSDictionary *)paraInfo   successBlock:(SuccessBlock)successBlock failureBlock:(FailureBlock)failureBlock{
    AFHTTPRequestOperationManager *manager = [self baseHtppRequest];
    NSString *url   = [[NSString alloc] initWithFormat:@"%@%@", SERVERURL, @"/faq/get" ];
    
    NSString *urlStr = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [manager POST:urlStr parameters:paraInfo success:^(AFHTTPRequestOperation *operation, id responseObject){ 
        successBlock([self decodeResponse:responseObject] );
    } failure:^(AFHTTPRequestOperation *operation, NSError *error){
        failureBlock(@"网络连接失败");
    }];
}

#pragma mark 获取订阅信息
-(void)userLogin:(NSDictionary *)paraInfo  successBlock:(SuccessBlock)successBlock failureBlock:(FailureBlock)failureBlock{
    
    
    AFHTTPRequestOperationManager *manager = [self baseHtppRequest];
    NSString *url   = [[NSString alloc] initWithFormat:@"%@%@", SERVERURL, @"/user/login" ];
    
    NSString *urlStr = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [manager POST:urlStr parameters:paraInfo success:^(AFHTTPRequestOperation *operation, id responseObject){
        successBlock([self decodeResponse:responseObject]);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error){
        failureBlock(@"网络连接失败");
    }];
}

#pragma mark 获取推荐信息
-(void)getSMSCode:(NSDictionary *)paraInfo   successBlock:(SuccessBlock)successBlock failureBlock:(FailureBlock)failureBlock;{
    //user/getSMSCode
    AFHTTPRequestOperationManager *manager = [self baseHtppRequest];
    NSString *url   = [[NSString alloc] initWithFormat:@"%@%@", SERVERURL, @"/user/getSMSCode" ];
    NSString *urlStr = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [manager POST:urlStr parameters:paraInfo success:^(AFHTTPRequestOperation *operation, id responseObject){
       // NSLog(@"%@",responseObject);
        successBlock([self decodeResponse:responseObject]);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error){
        failureBlock(@"网络连接失败");
    }];
}

#pragma mark 获取频道信息
-(void)checkSMSCode:(NSDictionary *)paraInfo   successBlock:(SuccessBlock)successBlock failureBlock:(FailureBlock)failureBlock{
    AFHTTPRequestOperationManager *manager = [self baseHtppRequest];
    NSString *url   = [[NSString alloc] initWithFormat:@"%@%@", SERVERURL, @"/SMSCode/check" ];
    NSString *urlStr = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [manager POST:urlStr parameters:paraInfo success:^(AFHTTPRequestOperation *operation, id responseObject){
        successBlock([self decodeResponse:responseObject]);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error){
        failureBlock(@"网络连接失败");
    }];
}

#pragma mark 获取最新视频信息
-(void)changePassword:(NSDictionary *)paraInfo   successBlock:(SuccessBlock)successBlock failureBlock:(FailureBlock)failureBlock{
    AFHTTPRequestOperationManager *manager = [self baseHtppRequest];
    NSString *url   = [[NSString alloc] initWithFormat:@"%@%@", SERVERURL, @"/user/changePassword" ];
    NSString *urlStr = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [manager POST:urlStr parameters:paraInfo success:^(AFHTTPRequestOperation *operation, id responseObject){
        successBlock([self decodeResponse:responseObject]);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error){
        failureBlock(@"网络连接失败");
    }];
}

#pragma mark 获取最热视频信息
-(void)userRegister:(NSDictionary *)paraInfo  successBlock:(SuccessBlock)successBlock failureBlock:(FailureBlock)failureBlock{
    AFHTTPRequestOperationManager *manager = [self baseHtppRequest];
    NSString *url   = [[NSString alloc] initWithFormat:@"%@%@", SERVERURL, @"/user/register" ];
    NSString *urlStr = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [manager POST:urlStr parameters:paraInfo success:^(AFHTTPRequestOperation *operation, id responseObject){
        successBlock([self decodeResponse:responseObject]);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error){
        failureBlock(@"网络连接失败");
    }];
}

#pragma mark 获取栏目信息
-(void)feedBack:(NSDictionary *)paraInfo successBlock:(SuccessBlock)successBlock failureBlock:(FailureBlock)failureBlock{
    AFHTTPRequestOperationManager *manager = [self baseHtppRequest];
    
    NSString *url   = [[NSString alloc] initWithFormat:@"%@%@", SERVERURL, @"/feedBack/record" ];
    NSString *urlStr = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [manager POST:urlStr parameters:paraInfo success:^(AFHTTPRequestOperation *operation, id responseObject){
        successBlock([self decodeResponse:responseObject]);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error){
        failureBlock(@"网络连接失败");
    }];
}


#pragma mark 获取历史记录信息
-(void)getTradeList:(NSDictionary *)paraInfo   successBlock:(SuccessBlock)successBlock failureBlock:(FailureBlock)failureBlock{
    AFHTTPRequestOperationManager *manager = [self baseHtppRequest];
    NSString *url   = [[NSString alloc] initWithFormat:@"%@%@", SERVERURL, @"/trade/simpleList" ];
    NSString *urlStr = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [manager POST:urlStr parameters:paraInfo success:^(AFHTTPRequestOperation *operation, id responseObject){
        successBlock([self decodeResponse:responseObject]);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error){
         failureBlock(@"网络连接失败");
    }];
}


#pragma mark 获取发现信息
-(void)userRebate:(NSDictionary *)paraInfo   successBlock:(SuccessBlock)successBlock failureBlock:(FailureBlock)failureBlock{
    AFHTTPRequestOperationManager *manager = [self baseHtppRequest];
    NSString *url   = [[NSString alloc] initWithFormat:@"%@%@", SERVERURL, @"/user/rebate" ];
    NSString *urlStr = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [manager POST:urlStr parameters:paraInfo success:^(AFHTTPRequestOperation *operation, id responseObject){
        successBlock([self decodeResponse:responseObject]);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error){
       failureBlock(@"网络连接失败");
    }];
}



-(void)takeOrder:(NSDictionary *)paraInfo   successBlock:(SuccessBlock)successBlock failureBlock:(FailureBlock)failureBlock{
    AFHTTPRequestOperationManager *manager = [self baseHtppRequest];
    NSString *url   = [[NSString alloc] initWithFormat:@"%@%@", SERVERURL, @"/charge/takeOrder" ];
    NSString *urlStr = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [manager POST:urlStr parameters:paraInfo success:^(AFHTTPRequestOperation *operation, id responseObject){
        successBlock([self decodeResponse:responseObject]);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error){
        failureBlock(@"网络连接失败");
    }];
}



-(void)qcoinPay:(NSDictionary *)paraInfo   successBlock:(SuccessBlock)successBlock failureBlock:(FailureBlock)failureBlock{
    AFHTTPRequestOperationManager *manager = [self baseHtppRequest];
    NSString *url   = [[NSString alloc] initWithFormat:@"%@%@", SERVERURL, @"/charge/pay" ];
    NSString *urlStr = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [manager POST:urlStr parameters:paraInfo success:^(AFHTTPRequestOperation *operation, id responseObject){
        successBlock([self decodeResponse:responseObject]);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error){
        failureBlock(@"网络连接失败");
    }];
}

-(void)takeMonthOrder:(NSDictionary *)paraInfo   successBlock:(SuccessBlock)successBlock failureBlock:(FailureBlock)failureBlock{
    AFHTTPRequestOperationManager *manager = [self baseHtppRequest];
    NSString *url   = [[NSString alloc] initWithFormat:@"%@%@", SERVERURL, @"/charge/takeQQPerMonthOrder" ];
    NSString *urlStr = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [manager POST:urlStr parameters:paraInfo success:^(AFHTTPRequestOperation *operation, id responseObject){
        successBlock([self decodeResponse:responseObject]);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error){
        failureBlock(@"网络连接失败");
    }];
}




-(void)qmonthPay:(NSDictionary *)paraInfo   successBlock:(SuccessBlock)successBlock failureBlock:(FailureBlock)failureBlock{
    AFHTTPRequestOperationManager *manager = [self baseHtppRequest];
    NSString *url   = [[NSString alloc] initWithFormat:@"%@%@", SERVERURL, @"/charge/payQQPerMonth" ];
    NSString *urlStr = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [manager POST:urlStr parameters:paraInfo success:^(AFHTTPRequestOperation *operation, id responseObject){
        successBlock([self decodeResponse:responseObject]);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error){
        failureBlock(@"网络连接失败");
    }];
}


-(void)qmonthInfo:(NSDictionary *)paraInfo   successBlock:(SuccessBlock)successBlock failureBlock:(FailureBlock)failureBlock{
    AFHTTPRequestOperationManager *manager = [self baseHtppRequest];
    NSString *url   = [[NSString alloc] initWithFormat:@"%@%@", SERVERURL, @"/charge/checkQQPerMonth" ];
    NSString *urlStr = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [manager POST:urlStr parameters:paraInfo success:^(AFHTTPRequestOperation *operation, id responseObject){
        successBlock([self decodeResponse:responseObject]);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error){
        failureBlock(@"网络连接失败");
    }];
}
-(void)cancelMonthOrder:(NSDictionary *)paraInfo   successBlock:(SuccessBlock)successBlock failureBlock:(FailureBlock)failureBlock{
    AFHTTPRequestOperationManager *manager = [self baseHtppRequest];
    
    NSString *url   = [[NSString alloc] initWithFormat:@"%@%@", SERVERURL, @"/charge/checkQQPerMonthWithSecurityCode" ];
    NSString *urlStr = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [manager POST:urlStr parameters:paraInfo success:^(AFHTTPRequestOperation *operation, id responseObject){
        successBlock([self decodeResponse:responseObject]);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error){
        failureBlock(@"网络连接失败");
    }];
}

-(void)cancelMonthPay:(NSDictionary *)paraInfo   successBlock:(SuccessBlock)successBlock failureBlock:(FailureBlock)failureBlock{
    AFHTTPRequestOperationManager *manager = [self baseHtppRequest];
    
    NSString *url   = [[NSString alloc] initWithFormat:@"%@%@", SERVERURL, @"/charge/cancelQQPerMonthOrder" ];
    NSString *urlStr = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [manager POST:urlStr parameters:paraInfo success:^(AFHTTPRequestOperation *operation, id responseObject){
        successBlock([self decodeResponse:responseObject]);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error){
        failureBlock(@"网络连接失败");
    }];
}

-(void)takeMemberOrder:(NSDictionary *)paraInfo   successBlock:(SuccessBlock)successBlock failureBlock:(FailureBlock)failureBlock{
    AFHTTPRequestOperationManager *manager = [self baseHtppRequest];
    NSString *url   = [[NSString alloc] initWithFormat:@"%@%@", SERVERURL, @"/charge/takeQQVIPOrder" ];
    NSString *urlStr = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [manager POST:urlStr parameters:paraInfo success:^(AFHTTPRequestOperation *operation, id responseObject){
        successBlock([self decodeResponse:responseObject]);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error){
        failureBlock(@"网络连接失败");
    }];
}



-(void)qmemberPay:(NSDictionary *)paraInfo   successBlock:(SuccessBlock)successBlock failureBlock:(FailureBlock)failureBlock{
    AFHTTPRequestOperationManager *manager = [self baseHtppRequest];
    NSString *url   = [[NSString alloc] initWithFormat:@"%@%@", SERVERURL, @"/charge/payQQVIP" ];
    NSString *urlStr = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [manager POST:urlStr parameters:paraInfo success:^(AFHTTPRequestOperation *operation, id responseObject){
        successBlock([self decodeResponse:responseObject]);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error){
        failureBlock(@"网络连接失败");
    }];
}

-(void)getLeftMoney:(NSDictionary *)paraInfo   successBlock:(SuccessBlock)successBlock failureBlock:(FailureBlock)failureBlock{
    AFHTTPRequestOperationManager *manager = [self baseHtppRequest];
    NSString *url   = [[NSString alloc] initWithFormat:@"%@%@", SERVERURL, @"/check/getLeftMoney" ];
    NSString *urlStr = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [manager POST:urlStr parameters:paraInfo success:^(AFHTTPRequestOperation *operation, id responseObject){
        successBlock([self decodeResponse:responseObject]);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error){
        failureBlock(@"网络连接失败");
    }];
}


@end
